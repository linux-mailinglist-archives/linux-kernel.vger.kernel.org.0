Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC25D42A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 18:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfGBQXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 12:23:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfGBQXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6zAYyPY36YK1JZb3r2s9SglZU9BCEOlK2aec31cVYo8=; b=GnkeN3PosBhEhc7kFZfZzd8KV
        1NgRhEcI5+vctfoX/Kcb0nxKTBOMygJxNMgR3LkSNF1a/wyfvl3R1+4wsLjBIyYbyJ0/PfXfNSn+8
        SqpLoVhYPm75g1ZK28ZcpOV/2Q+MsMUZLk9R5k9xuXwAQzFAznXSzoJUclNz1+v4zcngk9UUouIsJ
        jdUPLf0jrMmtk/bTgBpJvBFg/d0Akamp+Z26km6BKTaxXtYT55L2W/GkFUroAX1xrdaCLH85H+Ks1
        Crld7XscodEqA5pwa1avhQbfWydRvt0rl+AP32D4BNSXtp0fgY2Fs6L+Z5TY5JColhC17Y5IzI0t6
        dlFWVfQMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiLYo-0006r3-5Q; Tue, 02 Jul 2019 16:23:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 447F3203C694A; Tue,  2 Jul 2019 18:23:12 +0200 (CEST)
Date:   Tue, 2 Jul 2019 18:23:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        prakash.sangappa@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
Subject: Re: [RFC PATCH 1/3] sched: Introduce new interface for scheduler
 soft affinity
Message-ID: <20190702162312.GY3436@hirez.programming.kicks-ass.net>
References: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
 <20190626224718.21973-2-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626224718.21973-2-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:47:16PM -0700, subhra mazumdar wrote:
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1183741..b863fa8 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -652,6 +652,8 @@ struct task_struct {
>  	unsigned int			policy;
>  	int				nr_cpus_allowed;
>  	cpumask_t			cpus_allowed;

You're patching dead code, that no longer exists.

> +	cpumask_t			cpus_preferred;
> +	bool				affinity_unequal;

Urgh, no. cpumask_t is an abomination and having one of them is already
unfortunate, having two is really not sane, esp. since for 99% of the
tasks they'll be exactly the same.

Why not add cpus_ptr_soft or something like that, and have it point at
cpus_mask by default, and when it needs to not be the same, allocate a
cpumask for it. That also gets rid of that unequal thing.


