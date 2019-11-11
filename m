Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D014F8323
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 23:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKKW4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 17:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfKKW4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:56:14 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F4A20659;
        Mon, 11 Nov 2019 22:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573512973;
        bh=Z3qpgytwGG/uM8u/1Veq7O94/qCL6tFO45pqS6ZAmOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rj/HCH/zb307UBe50EiURObwyYmarROa0C5OArwZ7/eka01/4riFU2QdBwpSCWDI0
         AvpLAoOVBO6MoZ9KibjlFQaGVS4nOkJeZQAJhA+LaCN7wewZRLNykPgdrf50AcKziV
         M9zekoVIJznDJ4WdxgJm/7P+Sqa7CwyTjn3pU6uI=
Date:   Mon, 11 Nov 2019 23:56:11 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] irq_work: Convert flags to atomic_t
Message-ID: <20191111225610.GB27917@lenoir>
References: <20191108160858.31665-1-frederic@kernel.org>
 <20191108160858.31665-2-frederic@kernel.org>
 <20191111080058.GA72562@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111080058.GA72562@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 09:00:58AM +0100, Ingo Molnar wrote:
> 
> * Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > We need to convert flags to atomic_t in order to later fix an ordering
> > issue on cmpxchg() failure. This will allow us to use atomic_fetch_or().
> > Also that clarify the nature of those flags.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > ---
> >  include/linux/irq_work.h | 10 +++++++---
> >  kernel/irq_work.c        | 18 +++++++++---------
> >  kernel/printk/printk.c   |  2 +-
> >  3 files changed, 17 insertions(+), 13 deletions(-)
> 
> You missed the irq_work use in kernel/bpf/stackmap.c - see the fix below.
> 
> Thanks,
> 
> 	Ingo

Oh thanks. Strange that I haven't seen a 0-day warning about those.
