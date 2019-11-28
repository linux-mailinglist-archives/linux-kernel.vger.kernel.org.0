Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D951E10C1CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 02:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfK1BnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 20:43:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:14341 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbfK1BnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:43:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 17:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="410537920"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 27 Nov 2019 17:43:20 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "Andre Przywara" <Andre.Przywara@arm.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v8 12/13] selftests/resctrl: Disable MBA and MBM tests for AMD
Date:   Wed, 27 Nov 2019 16:39:43 -0800
Message-Id: <1574901584-212957-13-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1574901584-212957-1-git-send-email-fenghua.yu@intel.com>
References: <1574901584-212957-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Babu Moger <babu.moger@amd.com>

For now, disable MBA and MBM tests for AMD. Deciding test pass/fail
is not clear right now. We can enable when we have some clarity.

Signed-off-by: Babu Moger <babu.moger@amd.com>
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

