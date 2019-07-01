Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D492C2CE86
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 20:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfE1SVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 14:21:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:16145 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbfE1SVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:21:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 11:21:51 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 28 May 2019 11:21:50 -0700
Received: from [10.254.95.162] (kliang2-mobl.ccr.corp.intel.com [10.254.95.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 559AA580372;
        Tue, 28 May 2019 11:21:50 -0700 (PDT)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH 2/9] perf/x86/intel: Basic support for metrics counters
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-3-kan.liang@linux.intel.com>
 <20190528121508.GS2606@hirez.programming.kicks-ass.net>
Message-ID: <991ef247-8efe-bc21-a988-3d628733d915@linux.intel.com>
Date:   Tue, 28 May 2019 14:21:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528121508.GS2606@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2019 8:15 AM, Peter Zijlstra wrote:
> On Tue, May 21, 2019 at 02:40:48PM -0700, kan.liang@linux.intel.com wrote:
>> +/*
>> + * We model PERF_METRICS as more magic fixed-mode PMCs, one for each metric
>> + * and another for the whole slots counter
>> + *
>> + * Internally they all map to Fixed Ctr 3 (SLOTS), and allocate PERF_METRICS
>> + * as an extra_reg. PERF_METRICS has no own configuration, but we fill in
>> + * the configuration of FxCtr3 to enforce that all the shared users of SLOTS
>> + * have the same configuration.
>> + */
>> +#define INTEL_PMC_IDX_FIXED_METRIC_BASE		(INTEL_PMC_IDX_FIXED + 17)
>> +#define INTEL_PMC_IDX_TD_RETIRING		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 0)
>> +#define INTEL_PMC_IDX_TD_BAD_SPEC		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 1)
>> +#define INTEL_PMC_IDX_TD_FE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 2)
>> +#define INTEL_PMC_IDX_TD_BE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 3)
>> +#define INTEL_PMC_MSK_ANY_SLOTS			((0xfull << INTEL_PMC_IDX_FIXED_METRIC_BASE) | \
>> +						 INTEL_PMC_MSK_FIXED_SLOTS)
>> +static inline bool is_metric_idx(int idx)
>> +{
>> +	return idx >= INTEL_PMC_IDX_FIXED_METRIC_BASE && idx <= INTEL_PMC_IDX_TD_BE_BOUND;
>> +}
> 
> Something like:
> 
> 	return (idx >> INTEL_PMC_IDX_FIXED_METRIC_BASE) & 0xf;
> 
> might be faster code... (if it wasn't for 64bit literals being a pain,
> it could be a simple test instruction).
> 

is_metric_idx() is not a mask. It's to check if the idx between 49 and 52.

Thanks,
Kan
