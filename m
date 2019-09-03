Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE484A6129
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 08:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfICGRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 02:17:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:41193 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfICGRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:17:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 23:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="266194176"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2019 23:17:46 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, x86@kernel.org
Cc:     andriy.shevchenko@intel.com, alan@linux.intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 1/1] x86/init: Noop get/set wallclock when platform doesn't support RTC
Date:   Tue,  3 Sep 2019 14:17:37 +0800
Message-Id: <21f458d27acf9e39af8f20b7fe5f7ef17edf5e0a.1567484279.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1567484279.git.rahul.tanwar@linux.intel.com>
References: <cover.1567484279.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1567484279.git.rahul.tanwar@linux.intel.com>
References: <cover.1567484279.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use wallclock_init() op to detect platforms which does not support RTC and
noop get/set wallclock ops for such platforms.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 1461badd03e7 ("x86/init: Noop get/set wallclock when platform doesn't support RTC")
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 arch/x86/kernel/x86_init.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 1bef687faf22..50aa8257fd20 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -31,6 +31,30 @@ static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
+static int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
+static void get_rtc_noop(struct timespec64 *now) { }
+
+static const struct of_device_id of_cmos_match[] = {
+	{ .compatible = "motorola,mc146818" },
+	{}
+};
+
+static void x86_wallclock_init(void)
+{
+	struct device_node *node;
+
+	node = of_find_matching_node(NULL, of_cmos_match);
+	if (node && !of_device_is_available(node)) {
+		/*
+		 * Some products do not support RTC as persistent clock source. This can be
+		 * optionally indicated by having status property as disabled in the
+		 * corresponding DT node. Override get/set wallclock routines to noops for
+		 * such products.
+		 */
+		x86_platform.get_wallclock = get_rtc_noop;
+		x86_platform.set_wallclock = set_rtc_noop;
+	}
+}
 
 /*
  * The platform setup functions are preset with the default functions
@@ -73,7 +97,7 @@ struct x86_init_ops x86_init __initdata = {
 	.timers = {
 		.setup_percpu_clockev	= setup_boot_APIC_clock,
 		.timer_init		= hpet_time_init,
-		.wallclock_init		= x86_init_noop,
+		.wallclock_init		= x86_wallclock_init,
 	},
 
 	.iommu = {
-- 
2.11.0

