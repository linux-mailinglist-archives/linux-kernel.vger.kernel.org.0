Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282D017F6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 12:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCJLyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 07:54:38 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:16519 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgCJLyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583841276; x=1615377276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=gezZ4d843S2nTlbh9azi04SsH51yHFiHn28vQPiIVl4=;
  b=iLBCfvHBtVhpDKdq4uiSHcPnA5jG5Y+JxnGWCTJF4UWUnP7IM6b7DfJe
   4cCs2oyAIbGgq/4S00A5GznbsGhUbRmiZ00Xo0msYWmK8xXIjqgtrPyVr
   fNrXKjM5eTxWDUu2V1EUfJlDYdgKfLN0HjRhLfEr2xhs824dwx6xGmeeR
   o=;
IronPort-SDR: H53N5QpDKI5MamzQr6yc0Yjhy9NaBhIYeKmGDRzv8TSaaHLlS9BjzeKh3xxENRdj94wrjCuZnU
 LXACy6IFyMvA==
X-IronPort-AV: E=Sophos;i="5.70,536,1574121600"; 
   d="scan'208";a="20840160"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Mar 2020 11:54:23 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id C4AFEA2B10;
        Tue, 10 Mar 2020 11:54:21 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 10 Mar 2020 11:54:21 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.16) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 10 Mar 2020 11:54:09 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <aarcange@redhat.com>,
        <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v6 04/14] mm/damon: Apply dynamic memory mapping changes
Date:   Tue, 10 Mar 2020 12:53:55 +0100
Message-ID: <20200310115355.23840-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310090026.00005ea9@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.16]
X-ClientProxiedBy: EX13D15UWB004.ant.amazon.com (10.43.161.61) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 09:00:26 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 24 Feb 2020 13:30:37 +0100
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Only a number of parts in the virtual address space of the processes is
> > mapped to physical memory and accessed.  Thus, tracking the unmapped
> > address regions is just wasteful.  However, tracking every memory
> > mapping change might incur an overhead.  For the reason, DAMON applies
> > the dynamic memory mapping changes to the tracking regions only for each
> > of a user-specified time interval (``regions update interval``).
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Trivial inline. Otherwise makes sense to me.
> 
[...]
> > +static void damon_apply_three_regions(struct damon_ctx *ctx,
> > +		struct damon_task *t, struct region bregions[3])
> > +{
> > +	struct damon_region *r, *next;
> > +	unsigned int i = 0;
> > +
> > +	/* Remove regions which isn't in the three big regions now */
> > +	damon_for_each_region_safe(r, next, t) {
> > +		for (i = 0; i < 3; i++) {
> > +			if (damon_intersect(r, &bregions[i]))
> > +				break;
> > +		}
> > +		if (i == 3)
> > +			damon_destroy_region(r);
> > +	}
> > +
> > +	/* Adjust intersecting regions to fit with the threee big regions */
> 
> three

Good eye!  Thanks for finding :)

[...]
