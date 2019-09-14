Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 953BBB2A3C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 09:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfINHFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 03:05:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:2408 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfINHFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 03:05:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 00:05:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,503,1559545200"; 
   d="scan'208";a="210615631"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.128.120])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2019 00:05:35 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy.shevchenko@gmail.com, andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com, darcari@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/5] tools/power/x86/intel-speed-select: Allow online/offline based on tdp
Date:   Sat, 14 Sep 2019 00:05:10 -0700
Message-Id: <20190914070513.19807-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190914070513.19807-1-srinivas.pandruvada@linux.intel.com>
References: <20190914070513.19807-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using enable core mask, do online offline CPUs. There is a new option
--online|-o for set-config-level.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 52 ++++++++++++++++++-
 tools/power/x86/intel-speed-select/isst.h     |  2 +
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 83ac72902b36..b44f5b822348 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -38,6 +38,7 @@ static int fact_avx = 0xFF;
 static unsigned long long fact_trl;
 static int out_format_json;
 static int cmd_help;
+static int force_online_offline;
 
 /* clos related */
 static int current_clos = -1;
@@ -165,6 +166,26 @@ int get_topo_max_cpus(void)
 	return topo_max_cpus;
 }
 
+static void set_cpu_online_offline(int cpu, int state)
+{
+	char buffer[128];
+	int fd;
+
+	snprintf(buffer, sizeof(buffer),
+		 "/sys/devices/system/cpu/cpu%d/online", cpu);
+
+	fd = open(buffer, O_WRONLY);
+	if (fd < 0)
+		err(-1, "%s open failed", buffer);
+
+	if (state)
+		write(fd, "1\n", 2);
+	else
+		write(fd, "0\n", 2);
+
+	close(fd);
+}
+
 #define MAX_PACKAGE_COUNT 8
 #define MAX_DIE_PER_PACKAGE 2
 static void for_each_online_package_in_set(void (*callback)(int, void *, void *,
@@ -736,9 +757,30 @@ static void set_tdp_level_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	ret = isst_set_tdp_level(cpu, tdp_level);
 	if (ret)
 		perror("set_tdp_level_for_cpu");
-	else
+	else {
 		isst_display_result(cpu, outf, "perf-profile", "set_tdp_level",
 				    ret);
+		if (force_online_offline) {
+			struct isst_pkg_ctdp_level_info ctdp_level;
+
+			fprintf(stderr, "Option is set to online/offline\n");
+			ctdp_level.core_cpumask_size =
+				alloc_cpu_set(&ctdp_level.core_cpumask);
+			isst_get_coremask_info(cpu, tdp_level, &ctdp_level);
+			if (ctdp_level.cpu_count) {
+				int i, max_cpus = get_topo_max_cpus();
+				for (i = 0; i < max_cpus; ++i) {
+					if (CPU_ISSET_S(i, ctdp_level.core_cpumask_size, ctdp_level.core_cpumask)) {
+						fprintf(stderr, "online cpu %d\n", i);
+						set_cpu_online_offline(i, 1);
+					} else {
+						fprintf(stderr, "offline cpu %d\n", i);
+						set_cpu_online_offline(i, 0);
+					}
+				}
+			}
+		}
+	}
 }
 
 static void set_tdp_level(void)
@@ -747,6 +789,8 @@ static void set_tdp_level(void)
 		fprintf(stderr, "Set Config TDP level\n");
 		fprintf(stderr,
 			"\t Arguments: -l|--level : Specify tdp level\n");
+		fprintf(stderr,
+			"\t Optional Arguments: -o | online : online/offline for the tdp level\n");
 		exit(0);
 	}
 
@@ -1319,6 +1363,7 @@ static void parse_cmd_args(int argc, int start, char **argv)
 	static struct option long_options[] = {
 		{ "bucket", required_argument, 0, 'b' },
 		{ "level", required_argument, 0, 'l' },
+		{ "online", required_argument, 0, 'o' },
 		{ "trl-type", required_argument, 0, 'r' },
 		{ "trl", required_argument, 0, 't' },
 		{ "help", no_argument, 0, 'h' },
@@ -1335,7 +1380,7 @@ static void parse_cmd_args(int argc, int start, char **argv)
 	option_index = start;
 
 	optind = start + 1;
-	while ((opt = getopt_long(argc, argv, "b:l:t:c:d:e:n:m:p:w:h",
+	while ((opt = getopt_long(argc, argv, "b:l:t:c:d:e:n:m:p:w:ho",
 				  long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'b':
@@ -1347,6 +1392,9 @@ static void parse_cmd_args(int argc, int start, char **argv)
 		case 'l':
 			tdp_level = atoi(optarg);
 			break;
+		case 'o':
+			force_online_offline = 1;
+			break;
 		case 't':
 			sscanf(optarg, "0x%llx", &fact_trl);
 			break;
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 2f7f62765eb6..668f914d077f 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -187,6 +187,8 @@ extern int isst_send_msr_command(unsigned int cpu, unsigned int command,
 				 int write, unsigned long long *req_resp);
 
 extern int isst_get_ctdp_levels(int cpu, struct isst_pkg_ctdp *pkg_dev);
+extern int isst_get_coremask_info(int cpu, int config_index,
+			   struct isst_pkg_ctdp_level_info *ctdp_level);
 extern int isst_get_process_ctdp(int cpu, int tdp_level,
 				 struct isst_pkg_ctdp *pkg_dev);
 extern void isst_get_process_ctdp_complete(int cpu,
-- 
2.17.2

