Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 084B917F292
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 10:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgCJJBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 05:01:33 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2534 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbgCJJBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:01:33 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1AB38615AD1B600B7010;
        Tue, 10 Mar 2020 09:01:32 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 09:01:18 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 09:01:18 +0000
Date:   Tue, 10 Mar 2020 09:01:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <aarcange@redhat.com>, <yang.shi@linux.alibaba.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/14] mm/damon: Implement callbacks
Message-ID: <20200310090116.0000723f@Huawei.com>
In-Reply-To: <20200224123047.32506-6-sjpark@amazon.com>
References: <20200224123047.32506-1-sjpark@amazon.com>
 <20200224123047.32506-6-sjpark@amazon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 13:30:38 +0100
SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements callbacks for DAMON.  Using this, DAMON users can
> install their callbacks for each step of the access monitoring so that
> they can do something interesting with the monitored access pattrns

patterns

> online.  For example, callbacks can report the monitored patterns to
> users or do some access pattern based memory management such as
> proactive reclamations or access pattern based THP promotions/demotions
> decision makings.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  mm/damon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/damon.c b/mm/damon.c
> index 6a17408e83c2..554720778e8a 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -83,6 +83,10 @@ struct damon_ctx {
>  	struct rnd_state rndseed;
>  
>  	struct list_head tasks_list;	/* 'damon_task' objects */
> +
> +	/* callbacks */
> +	void (*sample_cb)(struct damon_ctx *context);
> +	void (*aggregate_cb)(struct damon_ctx *context);
>  };
>  
>  /* Get a random number in [l, r) */
> @@ -814,9 +818,13 @@ static int kdamond_fn(void *data)
>  			}
>  			mmput(mm);
>  		}
> +		if (ctx->sample_cb)
> +			ctx->sample_cb(ctx);
>  
>  		if (kdamond_aggregate_interval_passed(ctx)) {
>  			kdamond_merge_regions(ctx, max_nr_accesses / 10);
> +			if (ctx->aggregate_cb)
> +				ctx->aggregate_cb(ctx);
>  			kdamond_flush_aggregated(ctx);
>  			kdamond_split_regions(ctx);
>  		}


