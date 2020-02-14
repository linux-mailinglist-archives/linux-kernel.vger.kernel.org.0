Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9150215D906
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 15:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgBNOIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 09:08:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:14450 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgBNOIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:08:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 06:08:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="228498252"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2020 06:08:32 -0800
Subject: Re: [PATCH V2 3/5] perf tools: cs-etm: fix endless record after being
 terminated
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Wei Li <liwei391@huawei.com>
References: <20200214132654.20395-1-adrian.hunter@intel.com>
 <20200214132654.20395-4-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <216df91c-f65c-f4cc-2d5d-fb108c0b6683@intel.com>
Date:   Fri, 14 Feb 2020 16:07:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214132654.20395-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Leo Yan <leo.yan@linaro.org>


On 14/02/20 3:26 pm, Adrian Hunter wrote:
> From: Wei Li <liwei391@huawei.com>
> 
> In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
> be set and the event list will be disabled by evlist__disable() once.
> 
> While in auxtrace_record.read_finish(), the related events will be
> enabled again, if they are continuous, the recording seems to be endless.
> 
> If the cs_etm event is disabled, we don't enable it again here.
> 
> Note: This patch is NOT tested since i don't have such a machine with
> coresight feature, but the code seems buggy same as arm-spe and intel-pt.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> [ahunter: removed redundant 'else' after 'return']
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # 5.4+
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 2898cfdf8fe1..60141c3007a9 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -865,9 +865,12 @@ static int cs_etm_read_finish(struct auxtrace_record *itr, int idx)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(ptr->evlist, evsel) {
> -		if (evsel->core.attr.type == ptr->cs_etm_pmu->type)
> +		if (evsel->core.attr.type == ptr->cs_etm_pmu->type) {
> +			if (evsel->disabled)
> +				return 0;
>  			return perf_evlist__enable_event_idx(ptr->evlist,
>  							     evsel, idx);
> +		}
>  	}
>  
>  	return -EINVAL;
> 

