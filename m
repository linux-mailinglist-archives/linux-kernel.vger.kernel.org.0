Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5E47983A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390846AbfG2UGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 16:06:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51216 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389378AbfG2UGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0gMfhsL57S9uWkYqeXAfJBBv5D0vkqm5tG9LEtrmObA=; b=q1JasuZiwMWBl6dcjR7LBhWsx
        3B/1dFwHMg28at/6J5SY8UmpgbYzTsm/qdmf+sGHkJldSejrQ/sHdTLPL7JmZ3/rDqiFYpUoA8+Lp
        TWEMznaK492NCxlVuwoJix6GwCXzx6DIKBQu5ncHhRRpLRD095+mti4pFVjNj2nueg8aMDtP9NpCx
        0e9TIZ1FJ/0/v7oeQtPoBZYkFgsrR1VE2qi08TDrUGqAVk45j6v+2XHSOILUcx8t+LI4yolIJ3/hB
        6kZ/XFejyIwhjSyupFLiYj+K2JemBql8PDHiYKoDucjcbUGBEBmV+PjStne7AQ8xl1gdQeCzong/E
        23HfEyTTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsBuA-0006hT-JF; Mon, 29 Jul 2019 20:05:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54B7820C9B165; Mon, 29 Jul 2019 22:05:57 +0200 (CEST)
Date:   Mon, 29 Jul 2019 22:05:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH 03/14] sched,fair: redefine runnable_load_avg as the sum
 of task_h_load
Message-ID: <20190729200557.GR31398@hirez.programming.kicks-ass.net>
References: <20190722173348.9241-1-riel@surriel.com>
 <20190722173348.9241-4-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722173348.9241-4-riel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:33:37PM -0400, Rik van Riel wrote:
> @@ -3012,25 +2983,24 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
>  static void update_cfs_group(struct sched_entity *se)
>  {
>  	struct cfs_rq *gcfs_rq = group_cfs_rq(se);
> -	long shares, runnable;
> +	long shares;
>  
> -	if (!gcfs_rq)
> +	if (!gcfs_rq) {
> +		update_runnable_load_avg(se);
>  		return;
> +	}
>  
>  	if (throttled_hierarchy(gcfs_rq))
>  		return;
>  
>  #ifndef CONFIG_SMP
> -	runnable = shares = READ_ONCE(gcfs_rq->tg->shares);
> -
>  	if (likely(se->load.weight == shares))

I'm thinking this uses @shares uninitialized...

>  		return;
>  #else
>  	shares   = calc_group_shares(gcfs_rq);
> -	runnable = calc_group_runnable(gcfs_rq, shares);
>  #endif
>  
> -	reweight_entity(cfs_rq_of(se), se, shares, runnable);
> +	reweight_entity(cfs_rq_of(se), se, shares);
>  }
