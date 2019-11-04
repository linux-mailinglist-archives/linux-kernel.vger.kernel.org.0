Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34ED9EDD40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 12:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfKDLDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 06:03:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:13209 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbfKDLDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:03:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 03:03:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="232021248"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2019 03:03:10 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 09/10] tools/power/x86/intel-speed-select: Use core count for base-freq mask
Date:   Mon,  4 Nov 2019 03:02:45 -0800
Message-Id: <20191104110246.70465-10-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
References: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some firmware implementation gives error when a command is sent get mask
for core count 32-61. So use core count to decide.

But there is no function to get core count. So introduce one function to
get core count.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 23 ++++++++++++++++++-
 .../power/x86/intel-speed-select/isst-core.c  |  7 ++++--
 tools/power/x86/intel-speed-select/isst.h     |  1 +
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 2dffb67d3194..e0bad43697dc 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -338,6 +338,7 @@ void free_cpu_set(cpu_set_t *cpu_set)
 }
 
 static int cpu_cnt[MAX_PACKAGE_COUNT][MAX_DIE_PER_PACKAGE];
+static long long core_mask[MAX_PACKAGE_COUNT][MAX_DIE_PER_PACKAGE];
 static void set_cpu_present_cpu_mask(void)
 {
 	size_t size;
@@ -362,13 +363,33 @@ static void set_cpu_present_cpu_mask(void)
 
 			pkg_id = get_physical_package_id(i);
 			if (pkg_id < MAX_PACKAGE_COUNT &&
-			    die_id < MAX_DIE_PER_PACKAGE)
+			    die_id < MAX_DIE_PER_PACKAGE) {
+				int core_id = get_physical_core_id(i);
+
 				cpu_cnt[pkg_id][die_id]++;
+				core_mask[pkg_id][die_id] |= (1ULL << core_id);
+			}
 		}
 		closedir(dir);
 	}
 }
 
+int get_core_count(int pkg_id, int die_id)
+{
+	int cnt = 0;
+
+	if (pkg_id < MAX_PACKAGE_COUNT && die_id < MAX_DIE_PER_PACKAGE) {
+		int i;
+
+		for (i = 0; i < sizeof(long long) * 8; ++i) {
+			if (core_mask[pkg_id][die_id] & (1ULL << i))
+				cnt++;
+		}
+	}
+
+	return cnt;
+}
+
 int get_cpu_count(int pkg_id, int die_id)
 {
 	if (pkg_id < MAX_PACKAGE_COUNT && die_id < MAX_DIE_PER_PACKAGE)
diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index 8b3e1c7abb42..52698553de92 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -335,12 +335,15 @@ int isst_set_tdp_level(int cpu, int tdp_level)
 
 int isst_get_pbf_info(int cpu, int level, struct isst_pbf_info *pbf_info)
 {
+	int i, ret, core_cnt, max;
 	unsigned int req, resp;
-	int i, ret;
 
 	pbf_info->core_cpumask_size = alloc_cpu_set(&pbf_info->core_cpumask);
 
-	for (i = 0; i < 2; ++i) {
+	core_cnt = get_core_count(get_physical_package_id(cpu), get_physical_die_id(cpu));
+	max = core_cnt > 32 ? 2 : 1;
+
+	for (i = 0; i < max; ++i) {
 		unsigned long long mask;
 		int count;
 
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 84f56a468f82..cdf0f8a6dbbf 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -163,6 +163,7 @@ struct isst_pkg_ctdp {
 
 extern int get_topo_max_cpus(void);
 extern int get_cpu_count(int pkg_id, int die_id);
+extern int get_core_count(int pkg_id, int die_id);
 
 /* Common interfaces */
 extern void debug_printf(const char *format, ...);
-- 
2.17.2

