Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF4FC2E2B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbfJAHT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 03:19:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732725AbfJAHT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0S4ysf7rtEXMw/wzlhBR7mecKndwZrv5Pmb3IJaLSgg=; b=m3A8xuj7lSd8uA0UiO7usiyK1
        lWfWPn18pSufTimJhZhxZ3t462/KQ5tkb4LDSl856RYyURl7AvhZR0gL5ZVxumlT92Mo1NA22oL8x
        8ZclaWrkh1IR7TyYByKTKoiPDSxSRFuRlKu4t2kjhGauy2eisdedXYFN806TYANNDDPsI0otheNN7
        rbqHu9jbbH/lj36Gf5f6rCWXWBHxa2JE5W+jO4JzN8foT2rPe5XmCwveyzkjc9SBhP3pUIrXCvbJ7
        PczCnK+Dg4P060tJ+lnBFIbYTS/K6ksh4nW2PNT+yEBl0tPozZT79AVxMCNSVAyIWZzqGedb8O/zk
        6n2lK7MRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFCRQ-0001vn-Ff; Tue, 01 Oct 2019 07:19:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CD4430477A;
        Tue,  1 Oct 2019 09:18:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D9B8265261AA; Tue,  1 Oct 2019 09:19:21 +0200 (CEST)
Date:   Tue, 1 Oct 2019 09:19:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joelaf@google.com>,
        Alistair Delva <adelva@google.com>
Subject: Re: [GIT PULL] scheduler fixes
Message-ID: <20191001071921.GJ4519@hirez.programming.kicks-ass.net>
References: <20190928123905.GA97048@gmail.com>
 <CANcMJZB9UrMaJv6OiScZy2e2UFGFOJsFRar9RZUE9HM-00ZXGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANcMJZB9UrMaJv6OiScZy2e2UFGFOJsFRar9RZUE9HM-00ZXGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 04:45:49PM -0700, John Stultz wrote:
> Reverting the following patches:

>   "sched/membarrier: Fix p->mm->membarrier_state racy load"

ARGH, I fudged it... please try:


diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index a39bed2c784f..168479a7d61b 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -174,7 +174,6 @@ static int membarrier_private_expedited(int flags)
 		 */
 		if (cpu == raw_smp_processor_id())
 			continue;
-		rcu_read_lock();
 		p = rcu_dereference(cpu_rq(cpu)->curr);
 		if (p && p->mm == mm)
 			__cpumask_set_cpu(cpu, tmpmask);
