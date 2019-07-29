Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 948DB79061
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfG2QK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 12:10:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfG2QK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HSyRm8Kmm8l8JMI1hY/zT50xKLMEAchWqs4a2VQweLg=; b=NCotWPN/8B+g7XsmW9W7qsWAs
        lymhAfOfY6DBBAa+g3VaynKq2A8l/3wC8aT3mic3pVD7DWggQjxL9lrv6v5OtybxU0ECZ4/POo1XN
        CQ+QKkUgHi6kE9z91R/xvivjaI0MxeAPlomThdTi80nTDy1h5dzH7UeEJWKcZInheuC5geRQbBZiV
        +3aAJ6z7uOlE4kW9sbNBVlpLD6C063WDFBuplPlZk6wGyx978LydtUu2Ct6208pUNNnO+Wg16dutF
        tBjXW8UxlgDoaCrATWSZb/fLkgaxt40jCBiaYzWYPlf537m+cuxWvrO5PBT28J66l5g2V5/YlMw76
        N6srPsqUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs8ED-0000Xh-Fk; Mon, 29 Jul 2019 16:10:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B8F220AFFEAD; Mon, 29 Jul 2019 18:10:23 +0200 (CEST)
Date:   Mon, 29 Jul 2019 18:10:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched/deadline: Fix double accounting of rq/running
 bw in push_dl_task()
Message-ID: <20190729161023.GK31398@hirez.programming.kicks-ass.net>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-2-dietmar.eggemann@arm.com>
 <20190726121159.10fd1138@sweethome>
 <531f753a-57ba-408f-42e0-15252d7b1c32@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531f753a-57ba-408f-42e0-15252d7b1c32@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 09:59:28AM +0100, Dietmar Eggemann wrote:
> On 7/26/19 11:11 AM, luca abeni wrote:
> > Hi Dietmar,
> > 
> > On Fri, 26 Jul 2019 09:27:52 +0100
> > Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > 
> >> push_dl_task() always calls deactivate_task() with flags=0 which sets
> >> p->on_rq=TASK_ON_RQ_MIGRATING.
> > 
> > Uhm... This is a recent change in the deactivate_task() behaviour,
> > right? Because I tested SCHED_DEADLINE a lot, but I've never seen this
> > issue :)
> 
> Looks like it was v5.2 commit 7dd778841164 ("sched/core: Unify p->on_rq
> updates").

Argh, that wasn't intentional (obviously); please post v2 with that as
Fixes and I'll get it in sched/urgent and stable.
