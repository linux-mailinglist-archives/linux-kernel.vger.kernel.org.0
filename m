Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FD2143045
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 17:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgATQvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 11:51:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:45399 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgATQvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:51:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 08:51:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="275080916"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2020 08:51:03 -0800
Received: from [10.251.23.107] (kliang2-mobl.ccr.corp.intel.com [10.251.23.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1D39E58033E;
        Mon, 20 Jan 2020 08:51:02 -0800 (PST)
Subject: Re: [RESEND PATCH V5 1/2] perf/core: Add new branch sample type for
 HW index of raw branch records
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     eranian@google.com, acme@redhat.com, mingo@kernel.org,
        mpe@ellerman.id.au, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com
References: <20200116155757.19624-1-kan.liang@linux.intel.com>
 <20200116155757.19624-2-kan.liang@linux.intel.com>
 <20200120092300.GK14879@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <88802724-aa70-23bc-b2c8-a7a34aa3dfe5@linux.intel.com>
Date:   Mon, 20 Jan 2020 11:50:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120092300.GK14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2020 4:23 AM, Peter Zijlstra wrote:
> On Thu, Jan 16, 2020 at 07:57:56AM -0800, kan.liang@linux.intel.com wrote:
> 
>>   struct perf_branch_stack {
>>   	__u64				nr;
>> +	__u64				hw_idx;
>>   	struct perf_branch_entry	entries[0];
>>   };
> 
> The above and below order doesn't match.
> 
>> @@ -849,7 +853,11 @@ enum perf_event_type {
>>   	 *	  char                  data[size];}&& PERF_SAMPLE_RAW
>>   	 *
>>   	 *	{ u64                   nr;
>> -	 *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
>> +	 *        { u64 from, to, flags } lbr[nr];
>> +	 *
>> +	 *        # only available if PERF_SAMPLE_BRANCH_HW_INDEX is set
>> +	 *        u64			hw_idx;
>> +	 *      } && PERF_SAMPLE_BRANCH_STACK
> 
> That wants to be written as:
> 
> 		{ u64			nr;
> 		  { u64 from, to, flags; } entries[nr];
> 		  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
> 		} && PERF_SAMPLE_BRANCH_STACK
> 
> But the big question is; why isn't it:
> 
> 		{ u64			nr;
> 		  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
> 		  { u64 from, to, flags; } entries[nr];
> 		} && PERF_SAMPLE_BRANCH_STACK
> 
> to match the struct perf_branch_stack order. Having that variable sized
> entry in the middle just seems weird.


Usually, new data should be output to the end of a sample.
The comments and codes are all based on that way.
However, the entries[0] is sized entry, so I have to put the hw_idx 
before entry. It makes the inconsistency. Sorry for the confusion caused.

I will fix it in V6.

Thanks,
Kan

> 
>>   	 *
>>   	 * 	{ u64			abi; # enum perf_sample_regs_abi
>>   	 * 	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
