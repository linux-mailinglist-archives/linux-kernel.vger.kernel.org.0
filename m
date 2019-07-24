Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F6B73900
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbfGXTfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 15:35:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:56931 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389255AbfGXTfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:35:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 12:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="321437783"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.165])
  by orsmga004.jf.intel.com with ESMTP; 24 Jul 2019 12:35:42 -0700
Date:   Wed, 24 Jul 2019 12:35:42 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        serge.ayoun@intel.com, shay.katz-zamir@intel.com,
        haitao.huang@intel.com, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, kai.svahn@intel.com, bp@alien8.de,
        josh@joshtriplett.org, luto@kernel.org, kai.huang@intel.com,
        rientjes@google.com, cedric.xing@intel.com
Subject: Re: [PATCH v21 08/28] x86/cpu/intel: Detect SGX support and update
 caps appropriately
Message-ID: <20190724193542.GD25376@linux.intel.com>
References: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
 <20190713170804.2340-9-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713170804.2340-9-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 08:07:44PM +0300, Jarkko Sakkinen wrote:
>  arch/x86/kernel/cpu/intel.c | 71 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 8d6d92ebeb54..1503b251d10f 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -623,6 +623,72 @@ static void detect_tme(struct cpuinfo_x86 *c)
>  	c->x86_phys_bits -= keyid_bits;
>  }
>  
> +static void __maybe_unused detect_sgx(struct cpuinfo_x86 *c)
> +{
> +	unsigned long long fc;
> +
> +	rdmsrl(MSR_IA32_FEATURE_CONTROL, fc);
> +	if (!(fc & FEATURE_CONTROL_LOCKED)) {
> +		pr_err_once("sgx: The feature control MSR is not locked\n");
> +		goto err_unsupported;
> +	}
> +
> +	if (!(fc & FEATURE_CONTROL_SGX_ENABLE)) {
> +		pr_err_once("sgx: SGX is not enabled in IA32_FEATURE_CONTROL MSR\n");
> +		goto err_unsupported;
> +	}
> +
> +	if (!cpu_has(c, X86_FEATURE_SGX1)) {
> +		pr_err_once("sgx: SGX1 instruction set is not supported\n");
> +		goto err_unsupported;
> +	}
> +
> +	if (!(fc & FEATURE_CONTROL_SGX_LE_WR)) {
> +		pr_info_once("sgx: The launch control MSRs are not writable\n");
> +		goto err_msrs_rdonly;
> +	}
> +
> +	return;
> +
> +err_unsupported:
> +	setup_clear_cpu_cap(X86_FEATURE_SGX);
> +	setup_clear_cpu_cap(X86_FEATURE_SGX1);
> +	setup_clear_cpu_cap(X86_FEATURE_SGX2);
> +
> +err_msrs_rdonly:
> +	setup_clear_cpu_cap(X86_FEATURE_SGX_LC);
> +}
> +
> +static void init_intel_energy_perf(struct cpuinfo_x86 *c)
> +{
> +	u64 epb;
> +
> +	/*
> +	 * Initialize MSR_IA32_ENERGY_PERF_BIAS if not already initialized.
> +	 * (x86_energy_perf_policy(8) is available to change it at run-time.)
> +	 */
> +	if (!cpu_has(c, X86_FEATURE_EPB))
> +		return;
> +
> +	rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> +	if ((epb & 0xF) != ENERGY_PERF_BIAS_PERFORMANCE)
> +		return;
> +
> +	pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
> +	pr_warn_once("ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)\n");
> +	epb = (epb & ~0xF) | ENERGY_PERF_BIAS_NORMAL;
> +	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> +}
> +
> +static void intel_bsp_resume(struct cpuinfo_x86 *c)
> +{
> +	/*
> +	 * MSR_IA32_ENERGY_PERF_BIAS is lost across suspend/resume,
> +	 * so reinitialize it properly like during bootup:
> +	 */
> +	init_intel_energy_perf(c);
> +}
> +
>  static void init_cpuid_fault(struct cpuinfo_x86 *c)
>  {
>  	u64 msr;
> @@ -760,6 +826,11 @@ static void init_intel(struct cpuinfo_x86 *c)
>  	if (cpu_has(c, X86_FEATURE_TME))
>  		detect_tme(c);
>  
> +	if (IS_ENABLED(CONFIG_INTEL_SGX) && cpu_has(c, X86_FEATURE_SGX))
> +		detect_sgx(c);
> +
> +	init_intel_energy_perf(c);

All of the energy_perf additions are bogus, looks like a rebase gone wrong.

> +
>  	init_intel_misc_features(c);
>  }
>  
> -- 
> 2.20.1
> 
