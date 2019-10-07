Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3024CECD1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 21:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfJGTbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 15:31:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:26154 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729082AbfJGTbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:31:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 12:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="192372891"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2019 12:31:08 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 5/6] tools/power/x86/intel-speed-select: Implement 'perf-profile info' on CascadeLake-N
Date:   Mon,  7 Oct 2019 12:30:59 -0700
Message-Id: <20191007193100.36934-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191007193100.36934-1-srinivas.pandruvada@linux.intel.com>
References: <20191007193100.36934-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

Add functionality for "perf-profile info" on CascadeLake-N.

Sample output:
intel-speed-select perf-profile info
Intel(R) Speed Select Technology
Executing on CPU model:85[0x55]
 package-0
  die-0
    cpu-0
      perf-profile-level-0
        cpu-count:20
        enable-cpu-mask:00000000,000fffff
        enable-cpu-list:0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
        thermal-design-power-ratio:23
        base-frequency(MHz):2300
        speed-select-turbo-freq:unsupported
        speed-select-base-freq:enabled
        speed-select-base-freq
          high-priority-base-frequency(MHz):2700000
          high-priority-cpu-mask:00000000,0000e8c0
          high-priority-cpu-list:6,7,11,13,14,15
          low-priority-base-frequency(MHz):2100000
 package-1
  die-0
    cpu-20
      perf-profile-level-0
        cpu-count:20
        enable-cpu-mask:000000ff,fff00000
        enable-cpu-list:20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39
        thermal-design-power-ratio:23
        base-frequency(MHz):2300
        speed-select-turbo-freq:unsupported
        speed-select-base-freq:enabled
        speed-select-base-freq
          high-priority-base-frequency(MHz):2700000
          high-priority-cpu-mask:0000000e,8c000000
          high-priority-cpu-list:26,27,31,33,34,35
          low-priority-base-frequency(MHz):2100000

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 163 +++++++++++++++++-
 .../x86/intel-speed-select/isst-display.c     |  14 +-
 tools/power/x86/intel-speed-select/isst.h     |   3 +
 3 files changed, 173 insertions(+), 7 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 449025c6ea46..3c0eb4240df4 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -750,6 +750,152 @@ _get_tdp_level("get-config-current_level", levels, current_level,
 	       "Current TDP Level");
 _get_tdp_level("get-lock-status", levels, locked, "TDP lock status");
 
+struct isst_pkg_ctdp clx_n_pkg_dev;
+
+static int clx_n_get_base_ratio(void)
+{
+	FILE *fp;
+	char *begin, *end, *line = NULL;
+	char number[5];
+	float value = 0;
+	size_t n = 0;
+
+	fp = fopen("/proc/cpuinfo", "r");
+	if (!fp)
+		err(-1, "cannot open /proc/cpuinfo\n");
+
+	while (getline(&line, &n, fp) > 0) {
+		if (strstr(line, "model name")) {
+			/* this is true for CascadeLake-N */
+			begin = strstr(line, "@ ") + 2;
+			end = strstr(line, "GHz");
+			strncpy(number, begin, end - begin);
+			value = atof(number) * 10;
+			break;
+		}
+	}
+	free(line);
+	fclose(fp);
+
+	return (int)(value);
+}
+
+static int clx_n_config(int cpu)
+{
+	int i, ret, pkg_id, die_id;
+	unsigned long cpu_bf;
+	struct isst_pkg_ctdp_level_info *ctdp_level;
+	struct isst_pbf_info *pbf_info;
+
+	ctdp_level = &clx_n_pkg_dev.ctdp_level[0];
+	pbf_info = &ctdp_level->pbf_info;
+	ctdp_level->core_cpumask_size =
+			alloc_cpu_set(&ctdp_level->core_cpumask);
+
+	/* find the frequency base ratio */
+	ctdp_level->tdp_ratio = clx_n_get_base_ratio();
+	if (ctdp_level->tdp_ratio == 0) {
+		debug_printf("CLX: cn base ratio is zero\n");
+		ret = -1;
+		goto error_ret;
+	}
+
+	/* find the high and low priority frequencies */
+	pbf_info->p1_high = 0;
+	pbf_info->p1_low = ~0;
+
+	pkg_id = get_physical_package_id(cpu);
+	die_id = get_physical_die_id(cpu);
+
+	for (i = 0; i < topo_max_cpus; i++) {
+		if (!CPU_ISSET_S(i, present_cpumask_size, present_cpumask))
+			continue;
+
+		if (pkg_id != get_physical_package_id(i) ||
+		    die_id != get_physical_die_id(i))
+			continue;
+
+		CPU_SET_S(i, ctdp_level->core_cpumask_size,
+			  ctdp_level->core_cpumask);
+
+		cpu_bf = parse_int_file(1,
+			"/sys/devices/system/cpu/cpu%d/cpufreq/base_frequency",
+					i);
+		if (cpu_bf > pbf_info->p1_high)
+			pbf_info->p1_high = cpu_bf;
+		if (cpu_bf < pbf_info->p1_low)
+			pbf_info->p1_low = cpu_bf;
+	}
+
+	if (pbf_info->p1_high == ~0UL) {
+		debug_printf("CLX: maximum base frequency not set\n");
+		ret = -1;
+		goto error_ret;
+	}
+
+	if (pbf_info->p1_low == 0) {
+		debug_printf("CLX: minimum base frequency not set\n");
+		ret = -1;
+		goto error_ret;
+	}
+
+	/* convert frequencies back to ratios */
+	pbf_info->p1_high = pbf_info->p1_high / DISP_FREQ_MULTIPLIER;
+	pbf_info->p1_low = pbf_info->p1_low / DISP_FREQ_MULTIPLIER;
+
+	/* create high priority cpu mask */
+	pbf_info->core_cpumask_size = alloc_cpu_set(&pbf_info->core_cpumask);
+	for (i = 0; i < topo_max_cpus; i++) {
+		if (!CPU_ISSET_S(i, present_cpumask_size, present_cpumask))
+			continue;
+
+		if (pkg_id != get_physical_package_id(i) ||
+		    die_id != get_physical_die_id(i))
+			continue;
+
+		cpu_bf = parse_int_file(1,
+			"/sys/devices/system/cpu/cpu%d/cpufreq/base_frequency",
+					i);
+		cpu_bf = cpu_bf / DISP_FREQ_MULTIPLIER;
+		if (cpu_bf == pbf_info->p1_high)
+			CPU_SET_S(i, pbf_info->core_cpumask_size,
+				  pbf_info->core_cpumask);
+	}
+
+	/* extra ctdp & pbf struct parameters */
+	ctdp_level->processed = 1;
+	ctdp_level->pbf_support = 1; /* PBF is always supported and enabled */
+	ctdp_level->pbf_enabled = 1;
+	ctdp_level->fact_support = 0; /* FACT is never supported */
+	ctdp_level->fact_enabled = 0;
+
+	return 0;
+
+error_ret:
+	free_cpu_set(ctdp_level->core_cpumask);
+	return ret;
+}
+
+static void dump_clx_n_config_for_cpu(int cpu, void *arg1, void *arg2,
+				   void *arg3, void *arg4)
+{
+	int ret;
+
+	ret = clx_n_config(cpu);
+	if (ret) {
+		perror("isst_get_process_ctdp");
+	} else {
+		struct isst_pkg_ctdp_level_info *ctdp_level;
+		struct isst_pbf_info *pbf_info;
+
+		ctdp_level = &clx_n_pkg_dev.ctdp_level[0];
+		pbf_info = &ctdp_level->pbf_info;
+		isst_ctdp_display_information(cpu, outf, tdp_level, &clx_n_pkg_dev);
+		free_cpu_set(ctdp_level->core_cpumask);
+		free_cpu_set(pbf_info->core_cpumask);
+	}
+}
+
 static void dump_isst_config_for_cpu(int cpu, void *arg1, void *arg2,
 				     void *arg3, void *arg4)
 {
@@ -768,6 +914,8 @@ static void dump_isst_config_for_cpu(int cpu, void *arg1, void *arg2,
 
 static void dump_isst_config(int arg)
 {
+	void *fn;
+
 	if (cmd_help) {
 		fprintf(stderr,
 			"Print Intel(R) Speed Select Technology Performance profile configuration\n");
@@ -779,14 +927,17 @@ static void dump_isst_config(int arg)
 		exit(0);
 	}
 
+	if (!is_clx_n_platform())
+		fn = dump_isst_config_for_cpu;
+	else
+		fn = dump_clx_n_config_for_cpu;
+
 	isst_ctdp_display_information_start(outf);
 
 	if (max_target_cpus)
-		for_each_online_target_cpu_in_set(dump_isst_config_for_cpu,
-						  NULL, NULL, NULL, NULL);
+		for_each_online_target_cpu_in_set(fn, NULL, NULL, NULL, NULL);
 	else
-		for_each_online_package_in_set(dump_isst_config_for_cpu, NULL,
-					       NULL, NULL, NULL);
+		for_each_online_package_in_set(fn, NULL, NULL, NULL, NULL);
 
 	isst_ctdp_display_information_end(outf);
 }
@@ -1611,6 +1762,7 @@ static void get_clos_assoc(int arg)
 }
 
 static struct process_cmd_struct clx_n_cmds[] = {
+	{ "perf-profile", "info", dump_isst_config, 0 },
 	{ NULL, NULL, NULL, 0 }
 };
 
@@ -1888,7 +2040,8 @@ void process_command(int argc, char **argv,
 		}
 	}
 
-	create_cpu_map();
+	if (!is_clx_n_platform())
+		create_cpu_map();
 
 	i = 0;
 	while (cmds[i].feature) {
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 40346d534f78..8309810e7425 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -6,8 +6,6 @@
 
 #include "isst.h"
 
-#define DISP_FREQ_MULTIPLIER 100
-
 static void printcpulist(int str_len, char *str, int mask_size,
 			 cpu_set_t *cpu_mask)
 {
@@ -204,6 +202,9 @@ static void _isst_pbf_display_information(int cpu, FILE *outf, int level,
 		 pbf_info->p1_low * DISP_FREQ_MULTIPLIER);
 	format_and_print(outf, disp_level + 1, header, value);
 
+	if (is_clx_n_platform())
+		return;
+
 	snprintf(header, sizeof(header), "tjunction-temperature(C)");
 	snprintf(value, sizeof(value), "%d", pbf_info->t_prochot);
 	format_and_print(outf, disp_level + 1, header, value);
@@ -377,6 +378,15 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 			snprintf(value, sizeof(value), "unsupported");
 		format_and_print(outf, base_level + 4, header, value);
 
+		if (is_clx_n_platform()) {
+			if (ctdp_level->pbf_support)
+				_isst_pbf_display_information(cpu, outf,
+							      tdp_level,
+							  &ctdp_level->pbf_info,
+							      base_level + 4);
+			continue;
+		}
+
 		snprintf(header, sizeof(header), "thermal-design-power(W)");
 		snprintf(value, sizeof(value), "%d", ctdp_level->pkg_tdp);
 		format_and_print(outf, base_level + 4, header, value);
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index d280b27d600d..bef27bd6138e 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -69,6 +69,8 @@
 #define PM_CLOS_OFFSET				0x08
 #define PQR_ASSOC_OFFSET			0x20
 
+#define DISP_FREQ_MULTIPLIER 100
+
 struct isst_clos_config {
 	int pkg_id;
 	int die_id;
@@ -237,4 +239,5 @@ extern void isst_display_result(int cpu, FILE *outf, char *feature, char *cmd,
 extern int isst_clos_get_clos_information(int cpu, int *enable, int *type);
 extern void isst_clos_display_clos_information(int cpu, FILE *outf,
 					       int clos_enable, int type);
+extern int is_clx_n_platform(void);
 #endif
-- 
2.17.2

