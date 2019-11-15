Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B77FE507
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 19:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKOSmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 13:42:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:40238 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfKOSmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:42:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 10:42:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; 
   d="scan'208";a="208210512"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 15 Nov 2019 10:42:43 -0800
Received: from [10.251.5.106] (kliang2-mobl.ccr.corp.intel.com [10.251.5.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A97EF580472;
        Fri, 15 Nov 2019 10:42:42 -0800 (PST)
Subject: Re: [PATCH] perf/x86/intel: Avoid PEBS_ENABLE MSR access in PMI
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
References: <20191115133917.24424-1-kan.liang@linux.intel.com>
 <20191115140739.GM4131@hirez.programming.kicks-ass.net>
 <c0f562aa-39f3-1291-edd7-17c46178d1e3@linux.intel.com>
 <3e117702-c07f-bd58-9931-766c2698b5d7@linux.intel.com>
 <20191115183341.GB22747@tassilo.jf.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d5da733d-f45a-702d-a8eb-57dd0c596659@linux.intel.com>
Date:   Fri, 15 Nov 2019 13:42:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191115183341.GB22747@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2019 1:33 PM, Andi Kleen wrote:
>> @@ -2620,6 +2624,15 @@ static int handle_pmi_common(struct pt_regs *regs,
>> u64 status)
>>                  handled++;
>>                  x86_pmu.drain_pebs(regs);
>>                  status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
>> +
>> +               /*
>> +                * PMI may land after cpuc->enabled=0 in x86_pmu_disable()
>> and
>> +                * PMI throttle may be triggered for the PMI.
>> +                * For this rare case, intel_pmu_pebs_disable() will not
>> touch
>> +                * MSR_IA32_PEBS_ENABLE. Explicitly disable the PEBS here.
>> +                */
>> +               if (unlikely(!cpuc->enabled && !cpuc->pebs_enabled))
>> +                       wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
> 
> How does the enable_all() code know to reenable it in this case?

For this case, we know that perf is disabling the PMU. The PMI handler 
will not restore PMU state when it's inactive. The enable_all() will not 
be called.

Thanks,
Kan
