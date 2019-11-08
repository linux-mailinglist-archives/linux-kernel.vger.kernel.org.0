Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E4FF58DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 21:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfKHUrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 15:47:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfKHUq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kag+V5gPxSXe0dtQ6AhFcnziP3Uqpz6ZhAyPk3Lh2Tg=; b=VmuVY36nxRsV7S+i4WuIQdQ+M
        ryvrNG19Xg78p6srVO59JyAT7OlL86OibA2CwnRh7Vs43jxVweLdh689xCSah6gn5Q9K3bf31Ymjz
        dmWkyNcdCT4/GyC5UOHTiYmDg+alKc6QU4L//VwOi83uyFTIhpWWZa0YPUlUVxeGPvOQ1lTqI2d9z
        /stTypoZaDmHYq35tsv6H9C1ckEY6UUwJ6Ej3e0kFUadsBYOS0TBCW134IzbhhnGGrulAsX2NmwZQ
        IL5BMTY0i7pJEvDWf4te74zbjcoSGtbh0Fc2kIukxHmAsmt332qKAWBj15Al/Ug36sT2zE3IQJu0c
        2FCfHxBgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTB9Y-0007Bb-FI; Fri, 08 Nov 2019 20:46:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BFB6980E2D; Fri,  8 Nov 2019 21:46:42 +0100 (CET)
Date:   Fri, 8 Nov 2019 21:46:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        qais.yousef@arm.com, ktkhai@virtuozzo.com
Subject: Re: [PATCH 4/7] sched: Optimize pick_next_task()
Message-ID: <20191108204642.GK3079@worktop.programming.kicks-ass.net>
References: <20191108131553.027892369@infradead.org>
 <20191108131909.603037345@infradead.org>
 <20191108143348.GB123156@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108143348.GB123156@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 02:33:48PM +0000, Quentin Perret wrote:
> On Friday 08 Nov 2019 at 14:15:57 (+0100), Peter Zijlstra wrote:

> > Also remove the unlikely() from the idle case, it is in fact /the/ way
> > we select idle -- and that is a very common thing to do.
> 
> I assumed this was to optimize the case where we did find a cfs task to
> run. That is, we can afford to hit the unlikely case when there is no
> work to do after, but when there is, we shouldn't spend time checking
> the idle case. Makes sense ?

There is that, but it is also the way we pick idle when nr_running drops
to 0.

I just couldn't make up my mind if the unlikely made sense or not.
