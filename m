Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB01243B5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 10:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLRJvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 04:51:37 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfLRJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CCYsTiKmLFf9CmOEzk5lgJx0OEGqguLyDzTVud+iGeA=; b=TucDaIm+ISUWU5BpkawY63Sb3
        SJ9SWk9Pu7f2dafCRqmUyN1UDC0w4kLQTiN7ACWPV22SKSosG2JeNzQElk7s4wDWElgtDN43Pu3Xs
        rgKJEYCbDoYbJObPK03ZeFF0p1VjonN6AyqIxvArc3Uh6MaYeiUzmHTRev4x8o1yRMSdDNe5l7PXU
        iT9AlSg8sP/UTe+q5TnbqfZ6ZBgMaKbcJ2XmfRB5wfEKx3+h7keMutdUIEhY7YAF9rQEq19Rk2W10
        m2UIYcY37jmJT4elzwPg/t0rAFoteeDnVyns2y1aCLzL+ZhYyumgETnqOsEuTTloMoiggMq44kzI3
        +YKxUJ5nQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihVyx-0001FP-98; Wed, 18 Dec 2019 09:51:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36B023007F2;
        Wed, 18 Dec 2019 10:49:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1966B2B3E30FC; Wed, 18 Dec 2019 10:51:01 +0100 (CET)
Date:   Wed, 18 Dec 2019 10:51:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Long Li <longli@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH 1/3] sched/core: add API for exporting runqueue clock
Message-ID: <20191218095101.GQ2844@hirez.programming.kicks-ass.net>
References: <20191218071942.22336-1-ming.lei@redhat.com>
 <20191218071942.22336-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218071942.22336-2-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 03:19:40PM +0800, Ming Lei wrote:
> Scheduler runqueue maintains its own software clock that is periodically
> synchronised with hardware. Export this clock so that it can be used
> by interrupt flood detection for saving the cost of reading from hardware.

But you don't have much, if any, guarantees the thing gets updated.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 90e4b00ace89..03e2e3c36067 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -219,6 +219,11 @@ void update_rq_clock(struct rq *rq)
>  	update_rq_clock_task(rq, delta);
>  }
>  
> +u64 sched_local_rq_clock(void)
> +{
> +	return this_rq()->clock;
> +}
> +EXPORT_SYMBOL_GPL(sched_local_rq_clock);

Also, more NAK, you're exporting a variant of __rq_clock_broken().

(which, now that I git-grep for it, has become unused, good!)
