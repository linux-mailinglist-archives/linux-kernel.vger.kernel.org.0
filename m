Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6584EC9E23
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 14:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfJCMLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 08:11:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbfJCMLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:11:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33F232A09BF;
        Thu,  3 Oct 2019 12:11:24 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA9145C226;
        Thu,  3 Oct 2019 12:11:23 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2 4/7] intel-speed-select: Add configuration for CascadeLake-N
Date:   Thu,  3 Oct 2019 08:11:09 -0400
Message-Id: <20191003121112.25870-5-prarit@redhat.com>
In-Reply-To: <20191003121112.25870-1-prarit@redhat.com>
References: <20191003121112.25870-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 03 Oct 2019 12:11:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a 'dummy' pkg_dev struct for use by CascadeLake-N processors.  This
struct will be used in later patches to implement info and status calls
for CascadeLake-N SST-BF.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 .../x86/intel-speed-select/isst-config.c      | 98 ++++++++++++++++++-
 .../x86/intel-speed-select/isst-display.c     |  2 -
 tools/power/x86/intel-speed-select/isst.h     |  2 +
 3 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 734a7960458c..164c4e5e6ccb 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -748,6 +748,94 @@ _get_tdp_level("get-config-current_level", levels, current_level,
 	       "Current TDP Level");
 _get_tdp_level("get-lock-status", levels, locked, "TDP lock status");
 
+struct isst_pkg_ctdp clx_n_pkg_dev;
+
+static int clx_n_get_base_ratio(void)
+{
+	FILE *fp;
+	char *begin, *end, *line;
+	char number[5];
+	float value = 0;
+	size_t n;
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
+static void clx_n_config(void)
+{
+	int i;
+	unsigned long cpu_bf;
+	struct isst_pkg_ctdp_level_info *ctdp_level;
+	struct isst_pbf_info *pbf_info;
+
+	ctdp_level = &clx_n_pkg_dev.ctdp_level[0];
+	pbf_info = &ctdp_level->pbf_info;
+
+	/* find the frequency base ratio */
+	ctdp_level->tdp_ratio = clx_n_get_base_ratio();
+	if (ctdp_level->tdp_ratio == 0)
+		err(-1, "cn base ratio is zero\n");
+
+	/* find the high and low priority frequencies */
+	pbf_info->p1_high = 0;
+	pbf_info->p1_low = ~0;
+	for (i = 0; i < topo_max_cpus; i++) {
+		cpu_bf = parse_int_file(1,
+			"/sys/devices/system/cpu/cpu%d/cpufreq/base_frequency",
+					i);
+		if (cpu_bf > pbf_info->p1_high)
+			pbf_info->p1_high = cpu_bf;
+		if (cpu_bf < pbf_info->p1_low)
+			pbf_info->p1_low = cpu_bf;
+	}
+
+	if (pbf_info->p1_high == ~0UL)
+		err(-1, "maximum base frequency not set\n");
+
+	if (pbf_info->p1_low == 0)
+		err(-1, "minimum base frequency not set\n");
+
+	/* convert frequencies back to ratios */
+	pbf_info->p1_high = pbf_info->p1_high / DISP_FREQ_MULTIPLIER;
+	pbf_info->p1_low = pbf_info->p1_low / DISP_FREQ_MULTIPLIER;
+
+	/* create high priority cpu mask */
+	pbf_info->core_cpumask_size = alloc_cpu_set(&pbf_info->core_cpumask);
+	for (i = 0; i < topo_max_cpus; i++) {
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
+}
+
 static void dump_isst_config_for_cpu(int cpu, void *arg1, void *arg2,
 				     void *arg3, void *arg4)
 {
@@ -1809,7 +1897,10 @@ void process_command(int argc, char **argv,
 		}
 	}
 
-	create_cpu_map();
+	if (!is_clx_n_platform())
+		create_cpu_map();
+	else
+		clx_n_config();
 
 	i = 0;
 	while (cmds[i].feature) {
@@ -1825,6 +1916,11 @@ void process_command(int argc, char **argv,
 
 	if (!matched)
 		fprintf(stderr, "Invalid command\n");
+
+	if (!is_clx_n_platform()) {
+		/* this was allocated in clx_n_config() */
+		free_cpu_set(clx_n_pkg_dev.ctdp_level[0].pbf_info.core_cpumask);
+	}
 }
 
 static void usage(void)
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 40346d534f78..1caa7ae25245 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -6,8 +6,6 @@
 
 #include "isst.h"
 
-#define DISP_FREQ_MULTIPLIER 100
-
 static void printcpulist(int str_len, char *str, int mask_size,
 			 cpu_set_t *cpu_mask)
 {
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index d280b27d600d..0dcae17b3945 100644
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
-- 
2.18.1

