Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E158115077
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 13:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfLFMdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 07:33:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfLFMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YR8vgTusDeb4ZBKJOd7QMebA6VEGbZAZ+eRfqQ2fSAo=; b=JsUJJc3A5vUDj4GBUsBUoR470
        3iGMYx+cwJq52kbtH+YFEucK4zr+s/aws4XqXL/AQbcF68g/KbRAS8Z9JQJOSG4i2RtrMtIsXjX7o
        aC9QIzUxeMfGNLFFauKoLKiK6WBvTdy/SHtqhooxSDk3NiGrqGW3QFpOSGs67nUo3FxXAY69oy4cA
        WGJzRGyMgrS4C6SnNhhDt49rLdtgaKG0MwoE0Z1lYtbqAMGYKicA5rn0WDeq2AM8g/ptCG5esFkAs
        t8yC+kkSsk5KKuGe6M8cxRv9mDSsjEGuG1QTryOVkjteYAEs9ZnFM6WczRE7sabFHPU7jyklBV2p5
        zUSMHqWFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idCn2-00068A-QL; Fri, 06 Dec 2019 12:32:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CAD2130025A;
        Fri,  6 Dec 2019 13:31:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7782B2B27F3C1; Fri,  6 Dec 2019 13:32:54 +0100 (CET)
Date:   Fri, 6 Dec 2019 13:32:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Optimize select_idle_core
Message-ID: <20191206123254.GH2844@hirez.programming.kicks-ass.net>
References: <20191205172316.8198-1-srikar@linux.vnet.ibm.com>
 <6242deaa-e570-3384-0737-e49abb0599dd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6242deaa-e570-3384-0737-e49abb0599dd@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 12:00:00PM +0000, Valentin Schneider wrote:

> Say you have a 4-core SMT2 system with the usual numbering scheme:
> 
> {0, 4}  {1, 5}  {2, 6}  {3, 7}
> CORE0   CORE1   CORE2   CORE3
> 
> 
> Say 'target' is the prev_cpu, in that case let's pick 5. Because we do a
> for_each_cpu_wrap(), our iteration for 'core' would start with 
> 
>   5, 6, 7, ...
> 
> So say CORE2 is entirely idle and CORE1 isn't, we would go through the
> inner loop on CORE1 (with 'core' == 5), then go through CORE2 (with
> 'core' == 6) and return 'core'. I find it a bit unusual that we wouldn't
> return the first CPU in the SMT mask, usually we try to fill sched_groups
> in cpumask order.
> 
> 
> If we could have 'cpus' start with only primary CPUs, that would simplify
> things methinks:
> 
>   for_each_cpu_wrap(core, cpus, target) {
> 	  bool idle = true;
> 
> 	  for_each_cpu(cpu, cpu_smt_mask(core)) {
> 		  if (!available_idle_cpu(cpu)) {
> 			  idle = false;
> 			  break;
> 		  }
> 
> 	  __cpumask_clear_cpu(core, cpus);
> 
> 	  if (idle)
> 		  return core;
> 
> 
> Food for thought; 

See here:

  https://lkml.kernel.org/r/20180530142236.667774973@infradead.org

