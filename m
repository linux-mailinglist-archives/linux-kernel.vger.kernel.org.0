Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A771844D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 11:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCMK0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 06:26:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgCMK0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w0wh3Bo/E+yd8WLbN+yv3HuUw/Fwj4zAqX3kGWsq99k=; b=ffp0mdh20NmxHjh2w/JzrVfCQI
        mu3bjvWBkQPZQXWLzqkoqKY7m6Qj7J52aXZVzMkS00trEJ6UBIkV8TuIMkGSgyBEfEKiGnWnlQ6NY
        Od6OOHdBPZ/blRIwjrgOnzRxCwfPJQydWH6Eyyik6yeMJTMfv5nfTueGHwIWv8kku4auV5xPrIr2K
        ZjVarp6wWK/7GFhQXBn1/jvLkLqJ8PD7wHQR97eUDEgIOsQgaHEhasMs7iw2ew6bEWxdnJITTa2DC
        uWcxpvtJUSOsu6j74Q0XIIpn311k6OAVsRdZC1iLsZFFyVWzBrms9lornLP24UkfkhYQzRohGhLzi
        TcdlVcQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jChWP-0001OU-Bf; Fri, 13 Mar 2020 10:26:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 490D1305F2E;
        Fri, 13 Mar 2020 11:26:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8430214344F4; Fri, 13 Mar 2020 11:26:26 +0100 (CET)
Date:   Fri, 13 Mar 2020 11:26:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: improve spreading of utilization
Message-ID: <20200313102626.GY12561@hirez.programming.kicks-ass.net>
References: <20200312165429.990-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312165429.990-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 05:54:29PM +0100, Vincent Guittot wrote:
> During load_balancing, a group with spare capacity will try to pull some
> utilizations from an overloaded group. In such case, the load balance
> looks for the runqueue with the highest utilization. Nevertheless, it
> should also ensure that there are some pending tasks to pull otherwise
> the load balance will fail to pull a task and the spread of the load will
> be delayed.
> 
> This situation is quite transient but it's possible to highlight the
> effect with a short run of sysbench test so the time to spread task impacts
> the global result significantly.
> 
> Below are the average results for 15 iterations on an arm64 octo core:
> sysbench --test=cpu --num-threads=8  --max-requests=1000 run
> 
>                            tip/sched/core  +patchset
> total time:                172ms           158ms
> per-request statistics:
>          avg:                1.337ms         1.244ms
>          max:               21.191ms        10.753ms
> 
> The average max doesn't fully reflect the wide spread of the value which
> ranges from 1.350ms to more than 41ms for the tip/sched/core and from
> 1.350ms to 21ms with the patch.
> 
> Other factors like waiting for an idle load balance or cache hotness
> can delay the spreading of the tasks which explains why we can still
> have up to 21ms with the patch.

Thanks!
