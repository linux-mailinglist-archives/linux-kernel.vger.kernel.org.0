Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB631989F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 08:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfEJGzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 02:55:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36380 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfEJGzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 02:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nSJVr7DrkLGkqkdyFPqIgwXShT1bf00nOpHzyaCw/7U=; b=SYf4bR9dfob6NlrLLsymleQ3f
        nnMQiemLD3tn4CgeWx6Tcs8cEyzkIMlj5sjW0FlS5tnamx0cDEh6GQ7eCUb1/E6XbD/2VGecWSU55
        7Szp4sRjKhWJZ+Mc+D1XE50CuCOzU6pNMewQ1XLmb+m0MfmmRtUpnDpF8lzBhNZ35PbAEf72UtvZI
        RsxG/XU4gLscOTWQ3pUkRIHT/dYhEc8Kae9TOnmeLBWsus22ylKwHNHBRRiRnCJVGNJKzGdCQINMn
        LwyEh7/wyXNGt0iw5sOpj4r5RX5wd7G9Qw5VDJbb8xdYP39jMWGqchWPM7V7wqMiyOgavKW5gmkXv
        tcBxcb/iA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOzRO-00039O-RV; Fri, 10 May 2019 06:55:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03E262023AD97; Fri, 10 May 2019 08:55:31 +0200 (CEST)
Date:   Fri, 10 May 2019 08:55:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 1/2] sched: Start tracking SCHED_IDLE tasks count in
 cfs_rq
Message-ID: <20190510065531.GF2623@hirez.programming.kicks-ass.net>
References: <cover.1556182964.git.viresh.kumar@linaro.org>
 <ec46d6d30116742c48bfc0eb301aa72df266d6ce.1556182965.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec46d6d30116742c48bfc0eb301aa72df266d6ce.1556182965.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 03:07:39PM +0530, Viresh Kumar wrote:
> @@ -5166,6 +5170,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	struct cfs_rq *cfs_rq;
>  	struct sched_entity *se = &p->se;
> +	int idle_h_nr_running = unlikely(task_has_idle_policy(p)) ? 1 : 0;
>  
>  	/*
>  	 * The code below (indirectly) updates schedutil which looks at

> @@ -5266,6 +5273,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	struct cfs_rq *cfs_rq;
>  	struct sched_entity *se = &p->se;
>  	int task_sleep = flags & DEQUEUE_SLEEP;
> +	int idle_h_nr_running = unlikely(task_has_idle_policy(p)) ? 1 : 0;
>  
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);

That's a completely pointless branch there (and I suspect the compiler
will see that too), just write:

	int idle_h_nr_running = task_has_idle_policy(p);

