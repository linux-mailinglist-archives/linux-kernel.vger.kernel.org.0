Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A61771620
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 12:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbfGWKcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 06:32:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfGWKcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ukEYKf1M4OnYfTjpJ4fZ7m2Aul+YT4ndGqZQ09dQPek=; b=NlVgJao63MTknlityhkCvzh5T
        ehimb3P8DcG2W6DP3KqD4/nRB/JDEefAQXmKf7TlYbeanZDSsqy2zbqoBzQnA/MenmpkBlKiG6Eqf
        rdCbPoiHfFqiNKruyCddvYsbrex8cxoWFTJyMHluSsI42YFf4x5yeBHY0dZkP5csVc2AuMGVbU3KO
        BIkVam+4cerr+gAABO3z0mPWf9uVUQ5D6vCU4bKsqRQNl6VTJ7zBWi55ZmhRMBXltw8sldi1Gt3qS
        ONbOvudcpXhZ49MsU2RY5JAVwN9Ng90VMMgDY08puCIodAeqGnymVZRLs3aMFjk1is0yX0ksacf/B
        EqwuuCOtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hps5S-0003nn-JH; Tue, 23 Jul 2019 10:32:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6029201A9429; Tue, 23 Jul 2019 12:32:00 +0200 (CEST)
Date:   Tue, 23 Jul 2019 12:32:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v9 2/8] sched/core: Streamlining calls to task_rq_unlock()
Message-ID: <20190723103200.GC3402@hirez.programming.kicks-ass.net>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-3-juri.lelli@redhat.com>
 <50f00347-ffb3-285c-5a7d-3a9c5f813950@arm.com>
 <20190722083214.GF25636@localhost.localdomain>
 <b18f1ec3-46a1-e65e-2c6e-85729031c996@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b18f1ec3-46a1-e65e-2c6e-85729031c996@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:08:17AM +0200, Dietmar Eggemann wrote:

> Not sure, there is another little issue on 3/8 since uclamp is in
> v5.3-rc1 as well commit 69842cba9ace8 ("sched/uclamp: Add CPU's clamp
> buckets refcounting").

Also, 8/8, but all conflicts are trivial and I've fixed them up.
