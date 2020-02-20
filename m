Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA5165C30
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 11:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBTKyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 05:54:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34415 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726825AbgBTKyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582196046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b8cmeVk6m5ZlfvIFE5Df7V1HaWAbyPSgB3zgpuvfmXQ=;
        b=hlot7YPXAalaSirQz2gRZ4k3wU5QTjy4UQapJ4twncz474Yb3FBZEvpmfKcb5tBlxN5fND
        6XBg3snbxbTUiBPgyKggkzQf7cNXVUTjWoXXvQNz8176WI5da9tS1VHdbhiiechxEEBKn/
        DjQ9LKP7Q/ttbkIojQqE7nMYK1z0ylE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-CMt26U-kM_2OZ0jktMGedw-1; Thu, 20 Feb 2020 05:54:02 -0500
X-MC-Unique: CMt26U-kM_2OZ0jktMGedw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E198107ACCA;
        Thu, 20 Feb 2020 10:54:00 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D7038CCC5;
        Thu, 20 Feb 2020 10:53:58 +0000 (UTC)
Date:   Thu, 20 Feb 2020 11:53:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Align the output for interval aggregation mode
Message-ID: <20200220105355.GA553812@krava>
References: <20200218071614.25736-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218071614.25736-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 03:16:14PM +0800, Jin Yao wrote:
> There is a slight misalignment in -A -I output.
> 
> For example,
> 
>  perf stat -e cpu/event=cpu-cycles/ -a -A -I 1000
> 
>  #           time CPU                    counts unit events
>       1.000440863 CPU0               1,068,388      cpu/event=cpu-cycles/
>       1.000440863 CPU1                 875,954      cpu/event=cpu-cycles/
>       1.000440863 CPU2               3,072,538      cpu/event=cpu-cycles/
>       1.000440863 CPU3               4,026,870      cpu/event=cpu-cycles/
>       1.000440863 CPU4               5,919,630      cpu/event=cpu-cycles/
>       1.000440863 CPU5               2,714,260      cpu/event=cpu-cycles/
>       1.000440863 CPU6               2,219,240      cpu/event=cpu-cycles/
>       1.000440863 CPU7               1,299,232      cpu/event=cpu-cycles/
> 
> The value of counts is not aligned with the column "counts" and
> the event name is not aligned with the column "events".
> 
> With this patch, the output is,
> 
>  perf stat -e cpu/event=cpu-cycles/ -a -A -I 1000
> 
>  #           time CPU                    counts unit events
>       1.000423009 CPU0                  997,421      cpu/event=cpu-cycles/
>       1.000423009 CPU1                1,422,042      cpu/event=cpu-cycles/
>       1.000423009 CPU2                  484,651      cpu/event=cpu-cycles/
>       1.000423009 CPU3                  525,791      cpu/event=cpu-cycles/
>       1.000423009 CPU4                1,370,100      cpu/event=cpu-cycles/
>       1.000423009 CPU5                  442,072      cpu/event=cpu-cycles/
>       1.000423009 CPU6                  205,643      cpu/event=cpu-cycles/
>       1.000423009 CPU7                1,302,250      cpu/event=cpu-cycles/
> 
> Now output is aligned.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/stat-display.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index bc31fccc0057..95b29c9cba36 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -114,11 +114,11 @@ static void aggr_printout(struct perf_stat_config *config,
>  			fprintf(config->output, "S%d-D%d-C%*d%s",
>  				cpu_map__id_to_socket(id),
>  				cpu_map__id_to_die(id),
> -				config->csv_output ? 0 : -5,
> +				config->csv_output ? 0 : -3,
>  				cpu_map__id_to_cpu(id), config->csv_sep);
>  		} else {
> -			fprintf(config->output, "CPU%*d%s ",
> -				config->csv_output ? 0 : -5,
> +			fprintf(config->output, "CPU%*d%s",
> +				config->csv_output ? 0 : -7,
>  				evsel__cpus(evsel)->map[id],
>  				config->csv_sep);
>  		}
> -- 
> 2.17.1
> 

