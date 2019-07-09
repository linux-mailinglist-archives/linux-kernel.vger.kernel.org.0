Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3A263505
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 13:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfGILia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 07:38:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:54615 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfGILi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:38:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 04:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="340729765"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga005.jf.intel.com with ESMTP; 09 Jul 2019 04:38:25 -0700
Subject: Re: [PATCH v2 3/4] perf intel-pt: Smatch: Fix potential NULL pointer
 dereference
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190708143937.7722-1-leo.yan@linaro.org>
 <20190708143937.7722-4-leo.yan@linaro.org> <20190708215940.GD7455@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <13c2a09d-3031-56ea-1c71-39dd8a3c74e8@intel.com>
Date:   Tue, 9 Jul 2019 14:37:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708215940.GD7455@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/07/19 12:59 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 08, 2019 at 10:39:36PM +0800, Leo Yan escreveu:
>> Based on the following report from Smatch, fix the potential
>> NULL pointer dereference check.
> 
> Adrian, are you ok now with these two for pt and bts? Can I have your
> acked-by?

Yes they are good. For both:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> - Arnaldo
>  
>>   tools/perf/util/intel-pt.c:3200
>>   intel_pt_process_auxtrace_info() error: we previously assumed
>>   'session->itrace_synth_opts' could be null (see line 3196)
>>
>>   tools/perf/util/intel-pt.c:3206
>>   intel_pt_process_auxtrace_info() warn: variable dereferenced before
>>   check 'session->itrace_synth_opts' (see line 3200)
>>
>> tools/perf/util/intel-pt.c
>> 3196         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
>> 3197                 pt->synth_opts = *session->itrace_synth_opts;
>> 3198         } else {
>> 3199                 itrace_synth_opts__set_default(&pt->synth_opts,
>> 3200                                 session->itrace_synth_opts->default_no_sample);
>>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
>> 3201                 if (!session->itrace_synth_opts->default_no_sample &&
>> 3202                     !session->itrace_synth_opts->inject) {
>> 3203                         pt->synth_opts.branches = false;
>> 3204                         pt->synth_opts.callchain = true;
>> 3205                 }
>> 3206                 if (session->itrace_synth_opts)
>>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^
>> 3207                         pt->synth_opts.thread_stack =
>> 3208                                 session->itrace_synth_opts->thread_stack;
>> 3209         }
>>
>> 'session->itrace_synth_opts' is impossible to be a NULL pointer in
>> intel_pt_process_auxtrace_info(), thus this patch removes the NULL
>> test for 'session->itrace_synth_opts'.
>>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> ---
>>  tools/perf/util/intel-pt.c | 13 +++++--------
>>  1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
>> index c76a96f777fb..df061599fef4 100644
>> --- a/tools/perf/util/intel-pt.c
>> +++ b/tools/perf/util/intel-pt.c
>> @@ -3210,7 +3210,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>>  		goto err_delete_thread;
>>  	}
>>  
>> -	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
>> +	if (session->itrace_synth_opts->set) {
>>  		pt->synth_opts = *session->itrace_synth_opts;
>>  	} else {
>>  		itrace_synth_opts__set_default(&pt->synth_opts,
>> @@ -3220,8 +3220,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>>  			pt->synth_opts.branches = false;
>>  			pt->synth_opts.callchain = true;
>>  		}
>> -		if (session->itrace_synth_opts)
>> -			pt->synth_opts.thread_stack =
>> +		pt->synth_opts.thread_stack =
>>  				session->itrace_synth_opts->thread_stack;
>>  	}
>>  
>> @@ -3241,11 +3240,9 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>>  		pt->cbr2khz = tsc_freq / pt->max_non_turbo_ratio / 1000;
>>  	}
>>  
>> -	if (session->itrace_synth_opts) {
>> -		err = intel_pt_setup_time_ranges(pt, session->itrace_synth_opts);
>> -		if (err)
>> -			goto err_delete_thread;
>> -	}
>> +	err = intel_pt_setup_time_ranges(pt, session->itrace_synth_opts);
>> +	if (err)
>> +		goto err_delete_thread;
>>  
>>  	if (pt->synth_opts.calls)
>>  		pt->branches_filter |= PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |
>> -- 
>> 2.17.1
> 

