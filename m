Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7DDF31BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 15:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfKGOq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 09:46:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33462 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKGOq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/OrRskXnNuvYig/50XlPP6h0k/nysPrTGBFYIGLGuRs=; b=kbemZYtzK3JmELNafF32Lxmc1
        gRMJufJLmNBt97FDGu3WqjwiEiBwab3dB2xk2Uq1dc/KhBRlA6F1nb9ykoeH+PxuvXVZV8IJ9Z2PR
        kCMyHADv8MmNISol/yEl4ObegVKtLsPlQ1OFf0HSplzPE6vjW58gCTflj6geND/b3XGGSFZoONxwt
        SGAnVg7AYeMBsSi7MFgeApAJIAWu8JKQBwE/XcYqegio3JYvzwqL0OWulqpZRke4vpgywuCBp8m6h
        YWUQ//DhKWRzq7FZyyGOmEgSgY/t3HQWRJoBddWF9vi69IWlNidinqPpqxCiBQeaZpxY6dSBrlkus
        ygLpUVp6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSj3a-0008Ns-BU; Thu, 07 Nov 2019 14:46:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DBB85301747;
        Thu,  7 Nov 2019 15:45:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2746420241336; Thu,  7 Nov 2019 15:46:39 +0100 (CET)
Date:   Thu, 7 Nov 2019 15:46:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     kernel test robot <lkp@intel.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Phil Auld <pauld@redhat.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [sched] 10e7071b2f: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20191107144639.GB4114@hirez.programming.kicks-ass.net>
References: <20191107090808.GW29418@shao2-debian>
 <d94e549d-04de-5b23-c4e0-6c161ec8213e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d94e549d-04de-5b23-c4e0-6c161ec8213e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 01:51:47PM +0000, Valentin Schneider wrote:
> Using that, the fail is on:
> 
> 	if (need_pull_dl_task(rq, prev)) {
> 
> Which is most likely explained by the above call ending up doing a 
> 
>   dl_prio(prev->prio);
> 
> which doesn't play well with 
> 
>   class->pick_next_task(rq, NULL, NULL);
> 
> 
> Now, this is no longer an issue (I think) with the rest of Peter's series,
> since the above deref is gone with
> 
> 67692435c411 ("sched: Rework pick_next_task() slow-path")
> 
> It would be interesting to know whether LKP found this on a mainline kernel
> and bisected it down, or if it stumbled on this while bisecting something
> else.

That seems pausible indeed.
