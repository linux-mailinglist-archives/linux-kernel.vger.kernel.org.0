Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF719B4B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbgDARdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 13:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732279AbgDARdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:33:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1DA2063A;
        Wed,  1 Apr 2020 17:33:04 +0000 (UTC)
Date:   Wed, 1 Apr 2020 13:33:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200401133303.6773c574@gandalf.local.home>
In-Reply-To: <20200401170910.GX20730@hirez.programming.kicks-ass.net>
References: <20200330170200.GU20713@hirez.programming.kicks-ass.net>
        <20200330190205.k5ssixd5hpshpjjq@treble>
        <20200330200254.GV20713@hirez.programming.kicks-ass.net>
        <20200331111652.GH20760@hirez.programming.kicks-ass.net>
        <20200331202315.zialorhlxmml6ec7@treble>
        <20200331204047.GF2452@worktop.programming.kicks-ass.net>
        <20200331211755.pb7f3wa6oxzjnswc@treble>
        <20200331212040.7lrzmj7tbbx2jgrj@treble>
        <20200331222703.GH2452@worktop.programming.kicks-ass.net>
        <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com>
        <20200401170910.GX20730@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 19:09:10 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > > +	if (state->cfa.offset != initial_func_cfi.cfa.offset &&
> > > +	    !(ret_offset && state->cfa.offset == initial_func_cfi.cfa.offset + ret_offset))  
> > 
> > Isn't that the same thing as "state->cfa.offset !=
> > initial_func_cfi.cfa.offset + ret_offset" ?  
> 
> I'm confused on what cfa.offset is, sometimes it increase with
> stack_size, sometimes it doesn't.

I believe what Julien is saying is the above logic is equivalent:

	if (x != y &&
	    !(z && x == y + z))

is the same as:

	if (x != y + z)

-- Steve
