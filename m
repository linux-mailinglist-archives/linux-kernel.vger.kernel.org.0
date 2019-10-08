Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C301CFD18
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 17:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfJHPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 11:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfJHPEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:04:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6DD4205C9;
        Tue,  8 Oct 2019 15:04:14 +0000 (UTC)
Date:   Tue, 8 Oct 2019 11:04:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 1/6] x86/alternatives: Teach text_poke_bp() to
 emulate instructions
Message-ID: <20191008110412.29afac9f@gandalf.local.home>
In-Reply-To: <20191008145423.GG14765@zn.tnic>
References: <20191007081716.07616230.8@infradead.org>
        <20191007081944.88332264.2@infradead.org>
        <20191008142924.GE14765@zn.tnic>
        <20191008144834.GD2328@hirez.programming.kicks-ass.net>
        <20191008145423.GG14765@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 16:54:24 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Oct 08, 2019 at 04:48:34PM +0200, Peter Zijlstra wrote:
> > Can, but why? That's more lines for no raisin ;-)  
> 
> Here's a raisin: I was looking at this and then all of a sudden went:
> "W00t, why is this do_sync part of the loop at all? Do they belong
> together? Nope."
> 

But it is part of the loop...


+	for (do_sync = 0, i = 0; i < nr_entries; i++) {
+		if (tp[i].text[0] == INT3_INSN_OPCODE)
+			continue;
+
+		text_poke(tp[i].addr, tp[i].text, sizeof(int3));
+		do_sync++;
+	}
+

The difference between do_sync and i is that i gets incremented at
every iteration, where do_sync gets incremented only when the first
conditional is false. But I still see do_sync as a loop variable.

-- Steve


