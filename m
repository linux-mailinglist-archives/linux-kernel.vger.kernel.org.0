Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A3185B82
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 10:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgCOJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 05:31:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47864 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726521AbgCOJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584264667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NskdIeesjzIp9l2WHfY+vsEAmi7voX22LG95jDKnurM=;
        b=PNI4nE8erd2/nl8vpNvxbLkJKKIyjbO58q7Qk91/rt1FKqG2NMINSrxUbEdvyooc33OsZV
        vcEI1rkkUTGk5lD5pd2pE6bbh75oEX3gp4/XeldykSNhZtnvA9pjKffx2gtaw+/wpq/GsN
        NYa1Wyhu1vhzPpeT/9rhuFCESYXZnl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-opja8U-XMLS4so4aBi8vrQ-1; Sun, 15 Mar 2020 05:31:03 -0400
X-MC-Unique: opja8U-XMLS4so4aBi8vrQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D2E98017CC;
        Sun, 15 Mar 2020 09:31:01 +0000 (UTC)
Received: from krava (ovpn-204-71.brq.redhat.com [10.40.204.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 205785DA76;
        Sun, 15 Mar 2020 09:30:57 +0000 (UTC)
Date:   Sun, 15 Mar 2020 10:30:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf parse-events: fix 3 use after frees
Message-ID: <20200315093055.GD492969@krava>
References: <20200314170356.62914-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314170356.62914-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 10:03:56AM -0700, Ian Rogers wrote:
> Reproducible with a clang asan build and then running perf test in
> particular 'Parse event definition strings'.
> 
> v2 frees the evsel->pmu_name avoiding a memory leak.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c        | 1 +
>  tools/perf/util/parse-events.c | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 816d930d774e..15ccd193483f 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1287,6 +1287,7 @@ void perf_evsel__exit(struct evsel *evsel)
>  	perf_thread_map__put(evsel->core.threads);
>  	zfree(&evsel->group_name);
>  	zfree(&evsel->name);
> +	zfree(&evsel->pmu_name);
>  	perf_evsel__object.fini(evsel);
>  }
>  
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index a14995835d85..593b6b03785d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1449,7 +1449,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		evsel = __add_event(list, &parse_state->idx, &attr, NULL, pmu, NULL,
>  				    auto_merge_stats, NULL);
>  		if (evsel) {
> -			evsel->pmu_name = name;
> +			evsel->pmu_name = name ? strdup(name) : NULL;
>  			evsel->use_uncore_alias = use_uncore_alias;
>  			return 0;
>  		} else {
> @@ -1497,7 +1497,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		evsel->snapshot = info.snapshot;
>  		evsel->metric_expr = info.metric_expr;
>  		evsel->metric_name = info.metric_name;
> -		evsel->pmu_name = name;
> +		evsel->pmu_name = name ? strdup(name) : NULL;
>  		evsel->use_uncore_alias = use_uncore_alias;
>  		evsel->percore = config_term_percore(&evsel->config_terms);
>  	}
> @@ -1547,7 +1547,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  				if (!parse_events_add_pmu(parse_state, list,
>  							  pmu->name, head,
>  							  true, true)) {
> -					pr_debug("%s -> %s/%s/\n", config,
> +					pr_debug("%s -> %s/%s/\n", str,
>  						 pmu->name, alias->str);
>  					ok++;
>  				}
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 

