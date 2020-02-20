Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD1166506
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 18:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgBTRhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 12:37:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:6474 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgBTRha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:37:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 09:37:30 -0800
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="254546047"
Received: from jbrandeb-desk.jf.intel.com ([10.166.244.152])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 09:37:29 -0800
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        andriy.shevchenko@intel.com, dan.j.williams@intel.com
Subject: [PATCH v2 2/2] lib: make a test module with set/clear bit
Date:   Thu, 20 Feb 2020 09:37:22 -0800
Message-Id: <20200220173722.2034546-2-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220173722.2034546-1-jesse.brandeburg@intel.com>
References: <20200220173722.2034546-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test some bit clears/sets to make sure assembly doesn't change.
Instruct Kbuild to build this file with extra warning level -Wextra,
to catch new issues, and also doesn't hurt to build with C=1.

This was used to test changes to arch/x86/include/asm/bitops.h.

Recommended usage:
make defconfig
scripts/config -m CONFIG_TEST_BITOPS
make modules_prepare
make C=1 W=1 lib/test_bitops.ko
objdump -S -d lib/test_bitops.ko

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v2: use correct CC: list
---
 lib/Kconfig.debug                  | 13 ++++++++++++
 lib/Makefile                       |  2 ++
 lib/test_bitops.c                  | 34 ++++++++++++++++++++++++++++++
 tools/testing/selftests/lib/config |  1 +
 4 files changed, 50 insertions(+)
 create mode 100644 lib/test_bitops.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 69def4a9df00..61a5d00ea064 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1947,6 +1947,19 @@ config TEST_LKM
 
 	  If unsure, say N.
 
+config TEST_BITOPS
+	tristate "Test module for compilation of clear_bit/set_bit operations"
+	depends on m
+	help
+	  This builds the "test_bitops" module that is much like the
+	  TEST_LKM module except that it does a basic exercise of the
+	  clear_bit and set_bit macros to make sure there are no compiler
+	  warnings from C=1 sparse checker or -Wextra compilations. It has
+	  no dependencies and doesn't run or load unless explicitly requested
+	  by name.  for example: modprobe test_bitops.
+
+	  If unsure, say N.
+
 config TEST_VMALLOC
 	tristate "Test module for stress/performance analysis of vmalloc allocator"
 	default n
diff --git a/lib/Makefile b/lib/Makefile
index 611872c06926..b18db565b355 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -89,6 +89,8 @@ obj-$(CONFIG_TEST_OBJAGG) += test_objagg.o
 obj-$(CONFIG_TEST_STACKINIT) += test_stackinit.o
 obj-$(CONFIG_TEST_BLACKHOLE_DEV) += test_blackhole_dev.o
 obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
+obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
+CFLAGS_test_bitops.o += -Werror
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
diff --git a/lib/test_bitops.c b/lib/test_bitops.c
new file mode 100644
index 000000000000..077af86cf616
--- /dev/null
+++ b/lib/test_bitops.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+/* a tiny module only meant to compile-test set/clear_bit */
+
+static DECLARE_BITMAP(g_bitmap, 80);
+
+static int __init test_bitops_startup(void)
+{
+	pr_warn("Loaded test module\n");
+	set_bit(4, g_bitmap);
+	set_bit(11, g_bitmap);
+	set_bit(40, g_bitmap);
+	return 0;
+}
+
+static void __exit test_bitops_unstartup(void)
+{
+	clear_bit(4, g_bitmap);
+	clear_bit(11, g_bitmap);
+	clear_bit(40, g_bitmap);
+	pr_warn("Unloaded test module\n");
+}
+
+module_init(test_bitops_startup);
+module_exit(test_bitops_unstartup);
+
+MODULE_AUTHOR("Jesse Brandeburg <jesse.brandeburg@intel.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Bit testing module");
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index 14a77ea4a8da..b80ee3f6e265 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -2,3 +2,4 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_TEST_STRSCPY=m
+CONFIG_TEST_BITOPS=m
-- 
2.24.1

