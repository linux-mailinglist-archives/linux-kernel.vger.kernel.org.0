Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29723140A66
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 14:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgAQNFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 08:05:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgAQNFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:05:50 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFA72073A;
        Fri, 17 Jan 2020 13:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579266349;
        bh=L1zoGMWMD7GFL0CwGUKmunxxgOSlfjBcbC1FTwML6Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8Yyn90x9eGvWw0lUERypmXK5evaHbD7KpAaI9pHhcBAhgD9sUh6IK8wfIBFm8JsH
         Q454WacBPD5YNVCg7VVFgHMR42UuWtS8WLNz267HRTKSyfXQlUoaFp0XsBQ4roXYSE
         0CdXOfUvCzMqHJ7hSNtyNvXqZ1LSWRcDB7Qi4nkc=
Date:   Fri, 17 Jan 2020 13:05:44 +0000
From:   Will Deacon <will@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, nd@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Return EINVAL when precise_ip perf events are
 requested on Arm
Message-ID: <20200117130543.GA9093@willie-the-truck>
References: <20200115105855.13395-1-james.clark@arm.com>
 <20200115105855.13395-2-james.clark@arm.com>
 <20200117123920.GB8199@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117123920.GB8199@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jan 15, 2020 at 10:58:55AM +0000, James Clark wrote:
> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index df352b334ea7..4ddbdb93b3b6 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -102,6 +102,9 @@ armpmu_map_event(struct perf_event *event,
> >  	u64 config = event->attr.config;
> >  	int type = event->attr.type;
> >  
> > +	if (event->attr.precise)
> > +		return -EINVAL;

Also, does this field even exist? Guessing you mean 'precise_ip', but
then that means this hasn't even seen a compiler :(

Will
