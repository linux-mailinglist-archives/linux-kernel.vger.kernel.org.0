Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364C91393EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 15:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgAMOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 09:48:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:9992 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgAMOsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:48:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 06:48:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="217425109"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2020 06:48:11 -0800
Subject: Re: [PATCH] perf tools: intel-pt: fix endless record after being
 terminated
To:     Wei Li <liwei391@huawei.com>, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
References: <20200102074211.19901-1-liwei391@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <539e4aca-3bae-6586-fefd-8be49308b5d7@intel.com>
Date:   Mon, 13 Jan 2020 16:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102074211.19901-1-liwei391@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/01/20 9:42 am, Wei Li wrote:
> In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
> be set and the event list will be disabled by evlist__disable() once.
> 
> While in auxtrace_record.read_finish(), the related events will be
> enabled again, if they are continuous, the recording seems to be endless.
> 
> If the intel_pt event is disabled, we don't enable it again here.
> 
> Before the patch:
> huawei@huawei-2288H-V5:~/linux-5.5-rc4/tools/perf$ ./perf record -e \
> intel_pt//u -p 46803
> ^C^C^C^C^C^C
> 
> After the patch:
> huawei@huawei-2288H-V5:~/linux-5.5-rc4/tools/perf$ ./perf record -e \
> intel_pt//u -p 48591
> ^C[ perf record: Woken up 0 times to write data ]
> Warning:
> AUX data lost 504 times out of 4816!
> 
> [ perf record: Captured and wrote 2024.405 MB perf.data ]
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>

All ->read_finish() implementations seem the same, so can we make a common
helper auxtrace_read_finish() and set all .read_finish = to that.

> ---
>  tools/perf/arch/x86/util/intel-pt.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 20df442fdf36..1e96afcd8646 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -1173,9 +1173,13 @@ static int intel_pt_read_finish(struct auxtrace_record *itr, int idx)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(ptr->evlist, evsel) {
> -		if (evsel->core.attr.type == ptr->intel_pt_pmu->type)
> -			return perf_evlist__enable_event_idx(ptr->evlist, evsel,
> -							     idx);
> +		if (evsel->core.attr.type == ptr->intel_pt_pmu->type) {
> +			if (evsel->disabled)
> +				return 0;
> +			else
> +				return perf_evlist__enable_event_idx(
> +						ptr->evlist, evsel, idx);
> +		}
>  	}
>  	return -EINVAL;
>  }
> 

