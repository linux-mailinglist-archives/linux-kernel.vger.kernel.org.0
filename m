Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F018121C87
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 23:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfLPWPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 17:15:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:54731 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbfLPWPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:15:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 14:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="212362111"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 16 Dec 2019 14:15:23 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v9 12/13] selftests/resctrl: Disable MBA and MBM tests for AMD
Date:   Mon, 16 Dec 2019 14:26:46 -0800
Message-Id: <1576535207-2417-13-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com>
References: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Babu Moger <babu.moger@amd.com>

For now, disable MBA and MBM tests for AMD. Deciding test pass/fail
is not clear right now. We can enable when we have some clarity.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c      | 4 ++--
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index c194fcc42407..5da43767b973 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -64,8 +64,8 @@ static void show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
 				allocated_cache_lines * 100;
 
 	printf("%sok CAT: cache miss rate within %d%%\n",
-	       abs((int)diff_percent) > MAX_DIFF_PERCENT ? "not " : "",
-	       MAX_DIFF_PERCENT);
+	       !is_amd && abs((int)diff_percent) > MAX_DIFF_PERCENT ?
+	       "not " : "", MAX_DIFF_PERCENT);
 	tests_run++;
 	printf("# Percent diff=%d\n", abs((int)diff_percent));
 	printf("# Number of bits: %d\n", no_of_bits);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 884e918b1e97..425cc85ac883 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -158,7 +158,7 @@ int main(int argc, char **argv)
 	check_resctrlfs_support();
 	filter_dmesg();
 
-	if (mbm_test) {
+	if (!is_amd && mbm_test) {
 		printf("# Starting MBM BW change ...\n");
 		if (!has_ben)
 			sprintf(benchmark_cmd[5], "%s", "mba");
@@ -168,7 +168,7 @@ int main(int argc, char **argv)
 		tests_run++;
 	}
 
-	if (mba_test) {
+	if (!is_amd && mba_test) {
 		printf("# Starting MBA Schemata change ...\n");
 		if (!has_ben)
 			sprintf(benchmark_cmd[1], "%d", span);
-- 
2.19.1

