Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40C0A1B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 15:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfH2Nbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 09:31:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:41930 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfH2Nbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:31:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 06:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="192957950"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2019 06:31:39 -0700
Received: from [10.251.1.23] (kliang2-mobl.ccr.corp.intel.com [10.251.1.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 93B4458046E;
        Thu, 29 Aug 2019 06:31:38 -0700 (PDT)
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <20190828151921.GD17205@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <fd95a255-4499-2907-8af9-d340f157da68@linux.intel.com>
Date:   Thu, 29 Aug 2019 09:31:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828151921.GD17205@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2019 11:19 AM, Peter Zijlstra wrote:
>> +static int icl_set_topdown_event_period(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	s64 left = local64_read(&hwc->period_left);
>> +
>> +	/*
>> +	 * Clear PERF_METRICS and Fixed counter 3 in initialization.
>> +	 * After that, both MSRs will be cleared for each read.
>> +	 * Don't need to clear them again.
>> +	 */
>> +	if (left == x86_pmu.max_period) {
>> +		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
>> +		wrmsrl(MSR_PERF_METRICS, 0);
>> +		local64_set(&hwc->period_left, 0);
>> +	}
> This really doesn't make sense to me; if you set FIXED_CTR3 := 0, you'll
> never trigger the overflow there; this then seems to suggest the actual
> counter value is irrelevant. Therefore you don't actually need this.
> 

Could you please elaborate on why initialization to 0 never triggers an 
overflow?
As of my understanding, initialization to 0 only means that it will take 
more time than initialization to -max_period (0x8000 0000 0001) to 
trigger an overflow.

Maybe 0 is too tricky. We can set the initial value to 1.
I think the bottom line is that we need a small initial value for 
FIXED_CTR3 here.
PERF_METRICS reports an 8bit integer fraction which is something like 
0xff * internal counters / FIXCTR3.
The internal counters only start counting from 0. (SW cannot set an 
arbitrary initial value for internal counters.)
If the initial value of FIXED_CTR3 is too big, PERF_METRICS could always 
remain constant, e.g. 0.

Thanks,
Kan
