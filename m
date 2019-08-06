Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3855182DC7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 10:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbfHFIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 04:34:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbfHFIeQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:34:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07886859FF;
        Tue,  6 Aug 2019 08:34:16 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0B4BA5C1D4;
        Tue,  6 Aug 2019 08:34:13 +0000 (UTC)
Date:   Tue, 6 Aug 2019 10:34:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf diff: Report noisy for cycles diff
Message-ID: <20190806083413.GG7695@krava>
References: <20190724221432.26297-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724221432.26297-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 06 Aug 2019 08:34:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:14:32AM +0800, Jin Yao wrote:

SNIP

> +}
> +
>  double avg_stats(struct stats *stats)
>  {
>  	return stats->mean;
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 95b4de7a9d51..3448d319a220 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -8,14 +8,18 @@
>  #include <sys/time.h>
>  #include <sys/resource.h>
>  #include <sys/wait.h>
> +#include <stdio.h>
>  #include "xyarray.h"
>  #include "rblist.h"
>  #include "perf.h"
>  #include "event.h"
>  
> +#define NUM_SPARK_VALS	8 /* support spark line on first N items */
> +
>  struct stats {
>  	double n, mean, M2;
>  	u64 max, min;
> +	unsigned long svals[NUM_SPARK_VALS];
>  };

please do it without changing the 'struct stats', it's all
over the place and diff would be the only user

thanks
jirka
