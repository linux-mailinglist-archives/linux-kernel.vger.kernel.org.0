Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7681217B1D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 23:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCEWqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 17:46:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:5028 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgCEWpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674628"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:49 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 12/27] tools/power/x86/intel-speed-select: Improve error display for perf-profile feature
Date:   Thu,  5 Mar 2020 14:45:23 -0800
Message-Id: <20200305224538.490864-13-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds improved error display and handling for commands related
to perf-profile feature. The changes include:
- When invalid TDP level is passed. display error and exit
- Replace perror with helpful error message
- Show error when TDP level can't be set
- Print error when information can't be read for a level
- Validate user options for invalid level
- Display error for TDP lock status

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 21 +++++++++---
 .../power/x86/intel-speed-select/isst-core.c  | 33 ++++++++++++++++---
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 360fa00f9c7a..4230a19664d3 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1130,6 +1130,11 @@ static void dump_clx_n_config_for_cpu(int cpu, void *arg1, void *arg2,
 {
 	int ret;
 
+	if (tdp_level != 0xff && tdp_level != 0) {
+		isst_display_error_info_message(1, "Invalid level", 1, tdp_level);
+		exit(0);
+	}
+
 	ret = clx_n_config(cpu);
 	if (ret) {
 		perror("isst_get_process_ctdp");
@@ -1154,7 +1159,9 @@ static void dump_isst_config_for_cpu(int cpu, void *arg1, void *arg2,
 	memset(&pkg_dev, 0, sizeof(pkg_dev));
 	ret = isst_get_process_ctdp(cpu, tdp_level, &pkg_dev);
 	if (ret) {
-		perror("isst_get_process_ctdp");
+		isst_display_error_info_message(1, "Failed to get perf-profile info on cpu", 1, cpu);
+		isst_ctdp_display_information_end(outf);
+		exit(1);
 	} else {
 		isst_ctdp_display_information(cpu, outf, tdp_level, &pkg_dev);
 		isst_get_process_ctdp_complete(cpu, &pkg_dev);
@@ -1197,9 +1204,11 @@ static void set_tdp_level_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	int ret;
 
 	ret = isst_set_tdp_level(cpu, tdp_level);
-	if (ret)
-		perror("set_tdp_level_for_cpu");
-	else {
+	if (ret) {
+		isst_display_error_info_message(1, "Set TDP level failed", 0, 0);
+		isst_ctdp_display_information_end(outf);
+		exit(1);
+	} else {
 		isst_display_result(cpu, outf, "perf-profile", "set_tdp_level",
 				    ret);
 		if (force_online_offline) {
@@ -1237,11 +1246,13 @@ static void set_tdp_level(int arg)
 			"\t Arguments: -l|--level : Specify tdp level\n");
 		fprintf(stderr,
 			"\t Optional Arguments: -o | online : online/offline for the tdp level\n");
+		fprintf(stderr,
+			"\t  online/offline operation has limitations, refer to Linux hotplug documentation\n");
 		exit(0);
 	}
 
 	if (tdp_level == 0xff) {
-		fprintf(outf, "Invalid command: specify tdp_level\n");
+		isst_display_error_info_message(1, "Invalid command: specify tdp_level", 0, 0);
 		exit(1);
 	}
 	isst_ctdp_display_information_start(outf);
diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index 81a119f688a3..2f3921cd87f3 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -114,8 +114,10 @@ int isst_get_tdp_info(int cpu, int config_index,
 
 	ret = isst_send_mbox_command(cpu, CONFIG_TDP, CONFIG_TDP_GET_TDP_INFO,
 				     0, config_index, &resp);
-	if (ret)
+	if (ret) {
+		isst_display_error_info_message(1, "Invalid level, Can't get TDP information at level", 1, config_index);
 		return ret;
+	}
 
 	ctdp_level->pkg_tdp = resp & GENMASK(14, 0);
 	ctdp_level->tdp_ratio = (resp & GENMASK(23, 16)) >> 16;
@@ -352,7 +354,7 @@ int isst_set_tdp_level_msr(int cpu, int tdp_level)
 	debug_printf("cpu: tdp_level via MSR %d\n", cpu, tdp_level);
 
 	if (isst_get_config_tdp_lock_status(cpu)) {
-		debug_printf("cpu: tdp_locked %d\n", cpu);
+		isst_display_error_info_message(1, "tdp_locked", 0, 0);
 		return -1;
 	}
 
@@ -373,10 +375,19 @@ int isst_set_tdp_level(int cpu, int tdp_level)
 	unsigned int resp;
 	int ret;
 
+
+	if (isst_get_config_tdp_lock_status(cpu)) {
+		isst_display_error_info_message(1, "TDP is locked", 0, 0);
+		return -1;
+
+	}
+
 	ret = isst_send_mbox_command(cpu, CONFIG_TDP, CONFIG_TDP_SET_LEVEL, 0,
 				     tdp_level, &resp);
-	if (ret)
-		return isst_set_tdp_level_msr(cpu, tdp_level);
+	if (ret) {
+		isst_display_error_info_message(1, "Set TDP level failed for level", 1, tdp_level);
+		return ret;
+	}
 
 	return 0;
 }
@@ -671,7 +682,7 @@ void isst_get_process_ctdp_complete(int cpu, struct isst_pkg_ctdp *pkg_dev)
 
 int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 {
-	int i, ret;
+	int i, ret, valid = 0;
 
 	if (pkg_dev->processed)
 		return 0;
@@ -684,6 +695,14 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 		     cpu, pkg_dev->enabled, pkg_dev->current_level,
 		     pkg_dev->levels);
 
+	if (tdp_level != 0xff && tdp_level > pkg_dev->levels) {
+		isst_display_error_info_message(1, "Invalid level", 0, 0);
+		return -1;
+	}
+
+	if (!pkg_dev->enabled)
+		isst_display_error_info_message(0, "perf-profile feature is not supported, just base-config level 0 is valid", 0, 0);
+
 	for (i = 0; i <= pkg_dev->levels; ++i) {
 		struct isst_pkg_ctdp_level_info *ctdp_level;
 
@@ -703,6 +722,7 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 		if (ret)
 			continue;
 
+		valid = 1;
 		pkg_dev->processed = 1;
 		ctdp_level->processed = 1;
 
@@ -775,6 +795,9 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 		isst_get_uncore_mem_freq(cpu, i, ctdp_level);
 	}
 
+	if (!valid)
+		isst_display_error_info_message(0, "Invalid level, Can't get TDP control information at specified levels on cpu", 1, cpu);
+
 	return 0;
 }
 
-- 
2.24.1

