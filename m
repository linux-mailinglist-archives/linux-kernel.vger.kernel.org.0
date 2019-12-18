Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43FDB1246E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 13:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfLRMaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 07:30:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36570 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfLRMaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WsfnNd7m2nvvl03QBT9ECyml/bzyuRqjZFKsto4Vzsg=; b=0DgA0W9llHe5C9DFdwetb4wNv
        1C43E4j/YR7Ex8bi/XiWUwLPzzczrdH3iBq5Pg6NyJAIpYePKI+chlpY6UFcW7Givfi6B5VptscDP
        N+0kXd9lM2tLT5HHPpor8skjygrw3ztPgFJh0N/8tSj7FbsvGdYHe1ZDiyl8+rQiG6rVzOykB71IX
        AObFVoToGixx7PdzxtzEWhJ/8s93CH3EOMVqdXnZ142uutwz7zFiEzunGR6JHxPqceRlDAVgwZnIf
        NwuH/Jsve3rOH/VLsrWW0kyqAvppzYNSJVZuT8Ghmpfl4B4X8rCbrXM14v4LELNPivzpt5pz9sCGA
        bnhx5ETOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihYSF-0003IU-82; Wed, 18 Dec 2019 12:29:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46B16300F29;
        Wed, 18 Dec 2019 13:27:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CC6529DFB923; Wed, 18 Dec 2019 13:29:22 +0100 (CET)
Date:   Wed, 18 Dec 2019 13:29:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Long Li <longli@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH 2/3] softirq: implement interrupt flood detection
Message-ID: <20191218122922.GR2871@hirez.programming.kicks-ass.net>
References: <20191218071942.22336-1-ming.lei@redhat.com>
 <20191218071942.22336-3-ming.lei@redhat.com>
 <20191218104941.GR2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218104941.GR2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:49:41AM +0100, Peter Zijlstra wrote:
> 
> _If_ you want to do something like this, do it like the below. That only
> adds a few instruction to irq_exit() and only touches a cacheline that's
> already touched.
> 
> It computes both the avg duration and the avg inter-arrival-time of
> hardirqs. Things get critical when:
> 
> 	inter-arrival-avg < 2*duration-avg
> 
> or something like that.

Better yet, try something like:

bool cpu_irq_heavy(int cpu)
{
	return cpu_util_irq(cpu_rq(cpu)) >= arch_scale_cpu_capacity(cpu);
}


