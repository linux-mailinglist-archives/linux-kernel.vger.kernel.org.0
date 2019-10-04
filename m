Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D5CC1A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 19:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfJDRYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 13:24:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:37967 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfJDRYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:24:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 10:23:59 -0700
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="195623520"
Received: from spandruv-mobl.jf.intel.com ([10.24.11.4])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 10:23:59 -0700
Message-ID: <dbda91d07e656ada3a01e19bedef1a447a1a5470.camel@linux.intel.com>
Subject: Re: [PATCH v2 6/7] intel-speed-select: Implement 'perf-profile
 info' on CascadeLake-N
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 04 Oct 2019 10:23:59 -0700
In-Reply-To: <20191003121112.25870-7-prarit@redhat.com>
References: <20191003121112.25870-1-prarit@redhat.com>
         <20191003121112.25870-7-prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-03 at 08:11 -0400, Prarit Bhargava wrote:
> Add functionality for perf-profile info on CascadeLake-N.
> 

This results in 
#intel-speed-select perf-profile info
Intel(R) Speed Select Technology
Executing on CPU model:85[0x55]
intel-speed-select:
/sys/devices/system/cpu/cpu40/cpufreq/base_frequency: open failed: No
such file or directory

Let me fix this.

Also the previous crash was also for this v2 series.

Thanks,
Srinivas

> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  .../x86/intel-speed-select/isst-config.c      | 20 +++++++++++++++
> ----
>  .../x86/intel-speed-select/isst-display.c     | 12 +++++++++++
>  tools/power/x86/intel-speed-select/isst.h     |  1 +
>  3 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/isst-config.c
> b/tools/power/x86/intel-speed-select/isst-config.c
> index 3ab0edade5ec..d9b580139a07 100644
> --- a/tools/power/x86/intel-speed-select/isst-config.c
> +++ b/tools/power/x86/intel-speed-select/isst-config.c
> @@ -836,6 +836,12 @@ static void clx_n_config(void)
>  	ctdp_level->fact_enabled = 0;
>  }
>  
> +static void dump_cn_config_for_cpu(int cpu, void *arg1, void *arg2,
> +				   void *arg3, void *arg4)
> +{
> +	isst_ctdp_display_information(cpu, outf, tdp_level,
> &clx_n_pkg_dev);
> +}
> +
>  static void dump_isst_config_for_cpu(int cpu, void *arg1, void
> *arg2,
>  				     void *arg3, void *arg4)
>  {
> @@ -854,6 +860,8 @@ static void dump_isst_config_for_cpu(int cpu,
> void *arg1, void *arg2,
>  
>  static void dump_isst_config(int arg)
>  {
> +	void *fn;
> +
>  	if (cmd_help) {
>  		fprintf(stderr,
>  			"Print Intel(R) Speed Select Technology
> Performance profile configuration\n");
> @@ -865,14 +873,17 @@ static void dump_isst_config(int arg)
>  		exit(0);
>  	}
>  
> +	if (!is_clx_n_platform())
> +		fn = dump_isst_config_for_cpu;
> +	else
> +		fn = dump_cn_config_for_cpu;
> +
>  	isst_ctdp_display_information_start(outf);
>  
>  	if (max_target_cpus)
> -		for_each_online_target_cpu_in_set(dump_isst_config_for_
> cpu,
> -						  NULL, NULL, NULL,
> NULL);
> +		for_each_online_target_cpu_in_set(fn, NULL, NULL, NULL,
> NULL);
>  	else
> -		for_each_online_package_in_set(dump_isst_config_for_cpu
> , NULL,
> -					       NULL, NULL, NULL);
> +		for_each_online_package_in_set(fn, NULL, NULL, NULL,
> NULL);
>  
>  	isst_ctdp_display_information_end(outf);
>  }
> @@ -1633,6 +1644,7 @@ static void get_clos_assoc(int arg)
>  }
>  
>  static struct process_cmd_struct clx_n_cmds[] = {
> +	{ "perf-profile", "info", dump_isst_config, 0 },
>  	{ NULL, NULL, NULL, 0 }
>  };
>  
> diff --git a/tools/power/x86/intel-speed-select/isst-display.c
> b/tools/power/x86/intel-speed-select/isst-display.c
> index 1caa7ae25245..8309810e7425 100644
> --- a/tools/power/x86/intel-speed-select/isst-display.c
> +++ b/tools/power/x86/intel-speed-select/isst-display.c
> @@ -202,6 +202,9 @@ static void _isst_pbf_display_information(int
> cpu, FILE *outf, int level,
>  		 pbf_info->p1_low * DISP_FREQ_MULTIPLIER);
>  	format_and_print(outf, disp_level + 1, header, value);
>  
> +	if (is_clx_n_platform())
> +		return;
> +
>  	snprintf(header, sizeof(header), "tjunction-temperature(C)");
>  	snprintf(value, sizeof(value), "%d", pbf_info->t_prochot);
>  	format_and_print(outf, disp_level + 1, header, value);
> @@ -375,6 +378,15 @@ void isst_ctdp_display_information(int cpu, FILE
> *outf, int tdp_level,
>  			snprintf(value, sizeof(value), "unsupported");
>  		format_and_print(outf, base_level + 4, header, value);
>  
> +		if (is_clx_n_platform()) {
> +			if (ctdp_level->pbf_support)
> +				_isst_pbf_display_information(cpu,
> outf,
> +							      tdp_level
> ,
> +							  &ctdp_level-
> >pbf_info,
> +							      base_leve
> l + 4);
> +			continue;
> +		}
> +
>  		snprintf(header, sizeof(header), "thermal-design-
> power(W)");
>  		snprintf(value, sizeof(value), "%d", ctdp_level-
> >pkg_tdp);
>  		format_and_print(outf, base_level + 4, header, value);
> diff --git a/tools/power/x86/intel-speed-select/isst.h
> b/tools/power/x86/intel-speed-select/isst.h
> index 0dcae17b3945..bef27bd6138e 100644
> --- a/tools/power/x86/intel-speed-select/isst.h
> +++ b/tools/power/x86/intel-speed-select/isst.h
> @@ -239,4 +239,5 @@ extern void isst_display_result(int cpu, FILE
> *outf, char *feature, char *cmd,
>  extern int isst_clos_get_clos_information(int cpu, int *enable, int
> *type);
>  extern void isst_clos_display_clos_information(int cpu, FILE *outf,
>  					       int clos_enable, int
> type);
> +extern int is_clx_n_platform(void);
>  #endif

