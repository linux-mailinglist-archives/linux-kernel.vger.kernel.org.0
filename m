Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA812D3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 20:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfL3TPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 14:15:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfL3TPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:15:50 -0500
Received: from zzz.localdomain (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A6F3206CB;
        Mon, 30 Dec 2019 19:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577733349;
        bh=Di7rnIR7c21+Vdrdl1E5rG0N/9TZyCG7j0ogQSbim70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCA5m3JvAiuvkGK7SGTzVPxv3P3psUWpEKTm25af8SjUIDzgNI4CBysSlQskQ8bkL
         CIvYLWMpYSq9yDLL2fkaDB6WWZkaQtLvs0cFeanutrsITQ7lmRkWIB8qaifb6FWAzD
         DqjTgR6b1vDY6hvWhHkvt4ZGJMvwn25s5rMIWcqI=
Date:   Mon, 30 Dec 2019 13:15:47 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Message-ID: <20191230191547.GA1501@zzz.localdomain>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912301042.FB806E1133@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 10:43:20AM -0800, Kees Cook wrote:
> On Sat, Dec 28, 2019 at 12:49:18PM +0100, Peter Zijlstra wrote:
> > On Thu, Dec 26, 2019 at 09:29:22AM -0600, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Wrap refcount_dec_and_lock() and refcount_dec_and_lock_irqsave() with
> > > macros using __cond_lock() so that 'sparse' doesn't report warnings
> > > about unbalanced locking when using them.
> > > 
> > > This is the same thing that's done for their atomic_t equivalents.
> > > 
> > > Don't annotate refcount_dec_and_mutex_lock(), because mutexes don't
> > > currently have sparse annotations.
> > 
> > I so f'ing hate that __cond_lock() crap. Previously I've suggested
> > fixing sparse instead of making such an atrocious trainwreck of the
> > code.
> 
> Ew, I never noticed these before. That is pretty ugly. Can't __acquire()
> be used directly in the functions instead of building the nasty
> wrappers?

The annotation needs to go in the .h file, not the .c file, because sparse only
analyzes individual translation units.

It needs to be a wrapper macro because it needs to tie the acquisition of the
lock to the return value being true.  I.e. there's no annotation you can apply
directly to the function prototype that means "if this function returns true, it
acquires the lock that was passed in parameter N".

- Eric
