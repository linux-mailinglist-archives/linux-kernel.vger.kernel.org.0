Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E75B212BED3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 21:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfL1UPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 15:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfL1UPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:15:21 -0500
Received: from zzz.localdomain (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207D9207E0;
        Sat, 28 Dec 2019 20:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577564120;
        bh=hXgMYc8GBQ/inlmuUvwxM76ZQX3hIRNnBN51niq7Ou8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKnuh65SExXA9hH1Y7TmxMELvhiLrtXSa6vSk40OdvcKf6On6WWedXTi1QyunTbs4
         NqUOKS3E7AMdctymSQTJY9tWMz8QGf3TE7q1EboVLX8ATSFZiuuOtk1E1rxqq4sphA
         Jp6W8thQJsoR5hXwZ7Kd6b1zUPvxDK0dkPG+3KeI=
Date:   Sat, 28 Dec 2019 14:15:18 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Message-ID: <20191228201518.GA266348@zzz.localdomain>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228114918.GU2827@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 12:49:18PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 26, 2019 at 09:29:22AM -0600, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Wrap refcount_dec_and_lock() and refcount_dec_and_lock_irqsave() with
> > macros using __cond_lock() so that 'sparse' doesn't report warnings
> > about unbalanced locking when using them.
> > 
> > This is the same thing that's done for their atomic_t equivalents.
> > 
> > Don't annotate refcount_dec_and_mutex_lock(), because mutexes don't
> > currently have sparse annotations.
> 
> I so f'ing hate that __cond_lock() crap. Previously I've suggested
> fixing sparse instead of making such an atrocious trainwreck of the
> code.

What is your suggestion exactly?  There has to be an annotation for this,
because by design sparse only analyzes individual translation units; it's not a
full-blown static analyzer that operates on the AST for the whole kernel.

- Eric
