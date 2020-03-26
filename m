Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 998D419424C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 16:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgCZPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 11:04:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:34716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbgCZPEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:04:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F0DA9AC4A;
        Thu, 26 Mar 2020 15:04:13 +0000 (UTC)
Date:   Thu, 26 Mar 2020 16:04:13 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
In-Reply-To: <alpine.LSU.2.21.2003261537380.17254@pobox.suse.cz>
Message-ID: <alpine.LSU.2.21.2003261602110.17254@pobox.suse.cz>
References: <20200325174525.772641599@infradead.org> <20200325174605.369570202@infradead.org> <20200326113049.GD20696@hirez.programming.kicks-ass.net> <20200326125844.GD20760@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.21.2003261537380.17254@pobox.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020, Miroslav Benes wrote:

> On Thu, 26 Mar 2020, Peter Zijlstra wrote:
> 
> > On Thu, Mar 26, 2020 at 12:30:50PM +0100, Peter Zijlstra wrote:
> > 
> > > There is a special case in the UNWIND_HINT_RESTORE code. When, upon
> > > looking for the UNWIND_HINT_SAVE instruction to restore from, it finds
> > > the instruction hasn't been visited yet, it normally issues a WARN,
> > > except when this HINT_SAVE instruction is the first instruction of
> > > this branch.
> > > 
> > > The reason for this special case comes apparent when we remove it;
> > > code like:
> > > 
> > > 	if (cond) {
> > > 		UNWIND_HINT_SAVE
> > > 		// do stuff
> > > 		UNWIND_HINT_RESTORE
> > > 	}
> > > 	// more stuff
> > > 
> > > will now trigger the warning. This is because UNWIND_HINT_RESTORE is
> > > just a label, and there is nothing keeping it inside the (extended)
> > > basic block covered by @cond. It will attach itself to the first
> > > instruction of 'more stuff' and we'll hit it outside of the @cond,
> > > confusing things.
> > > 
> > > I don't much like this special case, it confuses things and will come
> > > apart horribly if/when the annotation needs to support nesting.
> > > Instead extend the affected code to at least form an extended basic
> > > block.
> > > 
> > > In particular, of the 2 users of this annotation: ftrace_regs_caller()
> > > and sync_core(), only the latter suffers this problem. Extend it's
> > > code sequence with a NOP to make it an extended basic block.
> > > 
> > > This isn't ideal either; stuffing code with NOPs just to make
> > > annotations work is certainly sub-optimal, but given that sync_core()
> > > is stupid expensive in any case, one extra nop isn't going to be a
> > > problem here.
> > 
> > So instr_begin() / instr_end() have this exact problem, but worse. Those
> > actually do nest and I've ran into the following situation:
> > 
> > 	if (cond1) {
> > 		instr_begin();
> > 		// code1
> > 		instr_end();
> > 	}
> > 	// code
> > 
> > 	if (cond2) {
> > 		instr_begin();
> > 		// code2
> > 		instr_end();
> > 	}
> > 	// tail
> > 
> > Where objtool then finds the path: !cond1, cond2, which ends up at code2
> > with 0, instead of 1.
> > 
> > I've also seen:
> > 
> > 	if (cond) {
> > 		instr_begin();
> > 		// code1
> > 		instr_end();
> > 	}
> > 	instr_begin();
> > 	// code2
> > 	instr_end();
> > 
> > Where instr_end() and instr_begin() merge onto the same instruction of
> > code2 as a 0, and again code2 will issue a false warning.
> > 
> > You can also not make objtool lift the end marker to the previous
> > instruction, because then:
> > 
> > 	if (cond1) {
> > 		instr_begin();
> > 		if (cond2) {
> > 			// code2
> > 		}
> > 		instr_end();
> > 	}
> > 
> > Suffers the reverse problem, instr_end() becomes part of the @cond2
> > block and cond1 grows a path that misses it entirely.
> 
> One could argue that this is really nasty and the correct way should be
> 
> 	if (cond1) {
> 		if (cond2) {
> 			instr_begin();
> 			// code2
> 			instr_end();
> 		}
> 	}
> 
> Then it should work if instr_begin() marks the next instruction and 
> instr_end() marks the previous one, no? There is a corner case when code2 
> is exactly one instruction, so instr counting would have to be updated.

	if (cond1) {
		instr_begin()
		if (cond2) {
			// code2
		}
		// code1
		instr_end();
	}

is a counter example though, so I take it back.

M
