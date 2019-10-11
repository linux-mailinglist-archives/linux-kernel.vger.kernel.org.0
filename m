Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C7D4156
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 15:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfJKNdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 09:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfJKNdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:33:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F95D2084C;
        Fri, 11 Oct 2019 13:33:21 +0000 (UTC)
Date:   Fri, 11 Oct 2019 09:33:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191011093319.3ef302ff@gandalf.local.home>
In-Reply-To: <20191011125903.GN2359@hirez.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
        <20191007081945.10951536.8@infradead.org>
        <20191008104335.6fcd78c9@gandalf.local.home>
        <20191009224135.2dcf7767@oasis.local.home>
        <20191010092054.GR2311@hirez.programming.kicks-ass.net>
        <20191010091956.48fbcf42@gandalf.local.home>
        <20191010140513.GT2311@hirez.programming.kicks-ass.net>
        <20191010115449.22044b53@gandalf.local.home>
        <20191010172819.GS2328@hirez.programming.kicks-ass.net>
        <20191011125903.GN2359@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019 14:59:03 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Oct 10, 2019 at 07:28:19PM +0200, Peter Zijlstra wrote:
> 
> > Really the best solution is to move all the poking into
> > ftrace_module_init(), before we mark it RO+X. That's what I'm going to
> > do for jump_label and static_call as well, I just need to add that extra
> > notifier callback.  
> 
> OK, so I started writing that patch... or rather, I wrote the patch and
> started on the Changelog when I ran into trouble describing why we need
> it.
> 
> That is, I'm struggling to explain why we cannot flip
> prepare_coming_module() and complete_formation().
> 
> Yes, it breaks ftrace, but I'm thinking that is all it breaks. So let me
> see if we can cure that.

For someone that doesn't use modules, you are making me very nervous
with all the changes you are making to the module code! ;-)

-- Steve
