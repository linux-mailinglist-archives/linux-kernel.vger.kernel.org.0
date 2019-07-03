Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC95ED82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 22:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfGCU3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 16:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGCU3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:29:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590ED218A0;
        Wed,  3 Jul 2019 20:29:44 +0000 (UTC)
Date:   Wed, 3 Jul 2019 16:29:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        luto@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
Subject: Re: [PATCH 3/3] x86/mm, tracing: Fix CR2 corruption
Message-ID: <20190703162942.63c750a3@gandalf.local.home>
In-Reply-To: <20190703202231.GI16275@worktop.programming.kicks-ass.net>
References: <20190703102731.236024951@infradead.org>
        <20190703102807.588906400@infradead.org>
        <20190703202231.GI16275@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 22:22:31 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jul 03, 2019 at 12:27:34PM +0200, root wrote:
> > Despire the current efforts to read CR2 before tracing happens there
> > still exist a number of possible holes:
> > 
> >   idtentry page_fault             do_page_fault           has_error_code=1
> >     call error_entry
> >       TRACE_IRQS_OFF
> >         call trace_hardirqs_off*
> >           #PF // modifies CR2
> > 
> >       CALL_enter_from_user_mode
> >         __context_tracking_exit()
> >           trace_user_exit(0)
> >             #PF // modifies CR2
> > 
> >     call do_page_fault
> >       address = read_cr2(); /* whoopsie */
> > 
> > And similar for i386.
> > 
> > Fix it by pulling the CR2 read into the entry code, before any of that
> > stuff gets a chance to run and ruin things.
> > 
> > Ideally we'll clean up the entry code by moving this tracing and
> > context tracking nonsense into C some day, but let's not delay fixing
> > this longer.
> >   
> 
> > @@ -1180,10 +1189,10 @@ idtentry xenint3		do_int3			has_error_co
> >  #endif
> >  
> >  idtentry general_protection	do_general_protection	has_error_code=1
> > -idtentry page_fault		do_page_fault		has_error_code=1
> > +idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
> >  
> >  #ifdef CONFIG_KVM_GUEST
> > -idtentry async_page_fault	do_async_page_fault	has_error_code=1
> > +idtentry async_page_fault	do_async_page_fault	has_error_code=1	read_cr2=1
> >  #endif  
> 
> While going over the various idt handlers, I found that we probably also
> need read_cr2 on do_double_fault(), otherwise it is susceptible to the
> same problem.
> 

BTW, do you plan on making this for stable? Even though it's rather
invasive. Or should we just apply the band-aids first, have them
backported to stable, and then put this change on top of them for
upstream?

-- Steve
