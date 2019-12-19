Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A766B12716F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 00:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLSX1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 18:27:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:45268 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfLSX1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:27:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 15:27:24 -0800
X-IronPort-AV: E=Sophos;i="5.69,333,1571727600"; 
   d="scan'208";a="213147778"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.148]) ([10.24.14.148])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Dec 2019 15:26:31 -0800
Subject: Re: [PATCH] x86/resctrl: Fix potential memory leak
To:     Shakeel Butt <shakeelb@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20191219223834.233692-1-shakeelb@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <1da649da-6527-d4c2-7d12-40126856ae75@intel.com>
Date:   Thu, 19 Dec 2019 15:26:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191219223834.233692-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel,

On 12/19/2019 2:38 PM, Shakeel Butt wrote:
> The set_cache_qos_cfg() is leaking memory when the given level is not
> RDT_RESOURCE_L3 or RDT_RESOURCE_L2. Fix that.

I think it would be valuable to those considering whether they need to
backport to know that RDT_RESOURCE_L3 and RDT_RESOURCE_L2 are currently
the only possible levels with which this function is called. It is thus
not currently possible for this leak to occur. Indeed a valuable safety
to add in case this code may change in the future. Thank you very much.

> 
> Fixes: 99adde9b370de ("x86/intel_rdt: Enable L2 CDP in MSR IA32_L2_QOS_CFG")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 2e3b06d6bbc6..a0c279c7f4b9 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1748,8 +1748,10 @@ static int set_cache_qos_cfg(int level, bool enable)
>  		update = l3_qos_cfg_update;
>  	else if (level == RDT_RESOURCE_L2)
>  		update = l2_qos_cfg_update;
> -	else
> +	else {
> +		free_cpumask_var(cpu_mask);
>  		return -EINVAL;
> +	}
>  
>  	r_l = &rdt_resources_all[level];
>  	list_for_each_entry(d, &r_l->domains, list) {
> 

Reinette
