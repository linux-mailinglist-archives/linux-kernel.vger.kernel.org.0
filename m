Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1296445EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 15:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfFNNpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 09:45:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:37988 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfFNNpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:45:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 06:45:23 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 14 Jun 2019 06:45:23 -0700
Received: from [10.254.88.254] (kliang2-mobl.ccr.corp.intel.com [10.254.88.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5C0FE5803E4;
        Fri, 14 Jun 2019 06:45:22 -0700 (PDT)
Subject: Re: [RFC] perf/x86/intel: Disable check_msr for real hw
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Tom Vaden <tom.vaden@hpe.com>
References: <20190614112853.GC4325@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <aafc5b7c-220e-dfab-c49d-d9e75a4efa87@linux.intel.com>
Date:   Fri, 14 Jun 2019 09:45:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614112853.GC4325@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2019 7:28 AM, Jiri Olsa wrote:
> hi,
> the HPE server can do POST tracing and have enabled LBR
> tracing during the boot, which makes check_msr fail falsly.
> 
> It looks like check_msr code was added only to check on guests
> MSR access, would it be then ok to disable check_msr for real
> hardware? (as in patch below)

Yes, the check_msr patch was to fix a bug report in guest.
I didn't get similar bug report for real hardware.
I think it should be OK to disable it for real hardware.

Thanks,
Kan

> 
> We could also check if LBR tracing is enabled and make
> appropriate checks, but this change is simpler ;-)
> 
> ideas? thanks,
> jirka
> 
> 
> ---
>   arch/x86/events/intel/core.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 71001f005bfe..1194ae7e1992 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -20,6 +20,7 @@
>   #include <asm/intel-family.h>
>   #include <asm/apic.h>
>   #include <asm/cpu_device_id.h>
> +#include <asm/hypervisor.h>
>   
>   #include "../perf_event.h"
>   
> @@ -4050,6 +4051,13 @@ static bool check_msr(unsigned long msr, u64 mask)
>   {
>   	u64 val_old, val_new, val_tmp;
>   
> +	/*
> +	 * Disable the check for real HW, so we don't
> +	 * mess up with potentionaly enabled regs.
> +	 */
> +	if (hypervisor_is_type(X86_HYPER_NATIVE))
> +		return true;
> +
>   	/*
>   	 * Read the current value, change it and read it back to see if it
>   	 * matches, this is needed to detect certain hardware emulators
> 
