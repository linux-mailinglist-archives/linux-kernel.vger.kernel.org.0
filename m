Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA77D656A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732872AbfJNOmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 10:42:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731121AbfJNOmL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:42:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97E9A18C8921;
        Mon, 14 Oct 2019 14:42:11 +0000 (UTC)
Received: from krava (unknown [10.40.205.218])
        by smtp.corp.redhat.com (Postfix) with SMTP id 50AB1600CD;
        Mon, 14 Oct 2019 14:42:09 +0000 (UTC)
Date:   Mon, 14 Oct 2019 16:42:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Support --all-kernel/--all-user
Message-ID: <20191014144208.GC9700@krava>
References: <20191011050545.3899-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011050545.3899-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Mon, 14 Oct 2019 14:42:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 01:05:45PM +0800, Jin Yao wrote:
> perf record has supported --all-kernel / --all-user to configure all
> used events to run in kernel space or run in user space. But perf
> stat doesn't support these options.
> 
> It would be useful to support these options in perf-stat too to keep
> the same semantics.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/Documentation/perf-stat.txt |  6 ++++++
>  tools/perf/builtin-stat.c              |  6 ++++++
>  tools/perf/util/stat.c                 | 10 ++++++++++
>  tools/perf/util/stat.h                 |  2 ++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 930c51c01201..a9af4e440e80 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -323,6 +323,12 @@ The output is SMI cycles%, equals to (aperf - unhalted core cycles) / aperf
>  
>  Users who wants to get the actual value can apply --no-metric-only.
>  
> +--all-kernel::
> +Configure all used events to run in kernel space.
> +
> +--all-user::
> +Configure all used events to run in user space.
> +
>  EXAMPLES
>  --------
>  
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 468fc49420ce..c88d4e118409 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -803,6 +803,12 @@ static struct option stat_options[] = {
>  	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
>  		     "monitor specified metrics or metric groups (separated by ,)",
>  		     parse_metric_groups),
> +	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
> +			 "Configure all used events to run in kernel space.",
> +			 PARSE_OPT_EXCLUSIVE),
> +	OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
> +			 "Configure all used events to run in user space.",
> +			 PARSE_OPT_EXCLUSIVE),
>  	OPT_END()
>  };
>  
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index ebdd130557fb..6822e4ffe224 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -490,6 +490,16 @@ int create_perf_stat_counter(struct evsel *evsel,
>  	if (config->identifier)
>  		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
>  
> +	if (config->all_user) {
> +		attr->exclude_kernel = 1;
> +		attr->exclude_user   = 0;
> +	}
> +
> +	if (config->all_kernel) {
> +		attr->exclude_kernel = 0;
> +		attr->exclude_user   = 1;
> +	}
> +
>  	/*
>  	 * Disabling all counters initially, they will be enabled
>  	 * either manually by us or by kernel via enable_on_exec
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index edbeb2f63e8d..081c4a5113c6 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -106,6 +106,8 @@ struct perf_stat_config {
>  	bool			 big_num;
>  	bool			 no_merge;
>  	bool			 walltime_run_table;
> +	bool			 all_kernel;
> +	bool			 all_user;
>  	FILE			*output;
>  	unsigned int		 interval;
>  	unsigned int		 timeout;
> -- 
> 2.17.1
> 
