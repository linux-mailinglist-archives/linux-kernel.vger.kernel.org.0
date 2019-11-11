Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F57F8351
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 00:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfKKXRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 18:17:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKXRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:17:09 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8849E21872;
        Mon, 11 Nov 2019 23:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573514229;
        bh=LX9VeEqrFW1EFKmCoPu2j64UPY5i5NUdQVCJdGdQ7Xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXgwpHMdECRCuwrlNJLqaHXWtPYF1eC2pEcBnplWf7S6N9DPySDx4zNPR+AOHqnzY
         lpqW9E0JgcBlWFIX6aDHx/46lfbXwvbPrN+53+aJNt/H4tomr1Pt1WHc/6KJ1EDi7j
         0FqdU8k3KOhHmfomNnl3v4QN1/7nRiO/vKPyzgrQ=
Date:   Tue, 12 Nov 2019 00:17:06 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] irq_work: Fix irq_work_claim() ordering
Message-ID: <20191111231705.GC27917@lenoir>
References: <20191108160858.31665-1-frederic@kernel.org>
 <20191108160858.31665-3-frederic@kernel.org>
 <20191111072005.GA112047@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111072005.GA112047@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 08:20:05AM +0100, Ingo Molnar wrote:
> 
> * Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > When irq_work_claim() finds IRQ_WORK_PENDING flag already set, we just
> > return and don't raise a new IPI. We expect the destination to see
> > and handle our latest updades thanks to the pairing atomic_xchg()
> > in irq_work_run_list().
> > 
> > But cmpxchg() doesn't guarantee a full memory barrier upon failure. So
> > it's possible that the destination misses our latest updates.
> > 
> > So use atomic_fetch_or() instead that is unconditionally fully ordered
> > and also performs exactly what we want here and simplify the code.
> 
> Just curious, how was this bug found - in the wild, or via code review?

Well, I wanted to make sure the nohz kcpustat patches are safe and I had
a last minute doubt about that irq work scenario. So I would say code
review :)

