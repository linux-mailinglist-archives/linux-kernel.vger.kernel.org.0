Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD68863D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389997AbfHHOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 10:02:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:62031 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbfHHOCK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:02:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 07:02:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="182601746"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.215.31]) ([10.254.215.31])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2019 07:02:08 -0700
Subject: Re: [PATCH] perf pmu-events: Fix the missing "cpu_clk_unhalted.core"
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20190729072755.2166-1-yao.jin@linux.intel.com>
 <20190808135636.GI19444@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <504a3bf5-d2fb-3576-0f43-ed80d3479c75@linux.intel.com>
Date:   Thu, 8 Aug 2019 22:02:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808135636.GI19444@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2019 9:56 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 29, 2019 at 03:27:55PM +0800, Jin Yao escreveu:
>> The events defined in pmu-events JSON are parsed and added into
>> perf tool. For fixed counters, we handle the encodings between
>> JSON and perf by using a static array fixed[].
>>
>> But the fixed[] has missed an important event "cpu_clk_unhalted.core".
>>
>> For example, on tremont platform,
>>
>> [root@localhost ~]# perf stat -e cpu_clk_unhalted.core -a
>> event syntax error: 'cpu_clk_unhalted.core'
>>                       \___ parser error
>>
>> With this patch, the event cpu_clk_unhalted.core can be parsed.
>>
>> [root@localhost perf]# ./perf stat -e cpu_clk_unhalted.core -a -vvv
>> ------------------------------------------------------------
>> perf_event_attr:
>>    type                             4
>>    size                             112
>>    config                           0x3c
>>    sample_type                      IDENTIFIER
>>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>    disabled                         1
>>    inherit                          1
>>    exclude_guest                    1
>> ------------------------------------------------------------
> 
> Thanks, applied, next time please do not add lines starting with ---,
> prefix it with two spaces so that git am scripts don't get confused.
> 
> 
> - Arnaldo
> 

Got it, thanks for reminding. I will be careful next time.

Thanks
Jin Yao

>> ...
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/pmu-events/jevents.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index 1a91a197cafb..d413761621b0 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -453,6 +453,7 @@ static struct fixed {
>>   	{ "inst_retired.any_p", "event=0xc0" },
>>   	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
>>   	{ "cpu_clk_unhalted.thread", "event=0x3c" },
>> +	{ "cpu_clk_unhalted.core", "event=0x3c" },
>>   	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1" },
>>   	{ NULL, NULL},
>>   };
>> -- 
>> 2.17.1
> 
