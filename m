Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B2154962
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 17:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgBFQjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 11:39:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:22808 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgBFQjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:39:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 08:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="225067192"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2020 08:39:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5BFCF2AF; Thu,  6 Feb 2020 18:39:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/4] kernel.h: Move lower_32_bits()/upper_32_bits() to bitops.h
Date:   Thu,  6 Feb 2020 18:39:40 +0200
Message-Id: <20200206163940.1940-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206163940.1940-1-andriy.shevchenko@linux.intel.com>
References: <20200206163940.1940-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move lower_32_bits()/upper_32_bits() to bitops.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new patch
 include/linux/bitops.h | 16 ++++++++++++++++
 include/linux/kernel.h | 16 ----------------
 lib/clz_ctz.c          |  2 +-
 lib/lz4/lz4defs.h      |  1 +
 lib/math/gcd.c         |  2 ++
 5 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 21696ea359d1..bcd91b2f0d89 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -20,6 +20,22 @@
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
 #define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
+/**
+ * upper_32_bits - return bits 32-63 of a number
+ * @n: the number we're accessing
+ *
+ * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
+ * the "right shift count >= width of type" warning when that quantity is
+ * 32-bits.
+ */
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+
+/**
+ * lower_32_bits - return bits 0-31 of a number
+ * @n: the number we're accessing
+ */
+#define lower_32_bits(n) ((u32)(n))
+
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d9ce634457cb..7c443bb779fb 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -60,22 +60,6 @@
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
 
-/**
- * upper_32_bits - return bits 32-63 of a number
- * @n: the number we're accessing
- *
- * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
- * the "right shift count >= width of type" warning when that quantity is
- * 32-bits.
- */
-#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
-
-/**
- * lower_32_bits - return bits 0-31 of a number
- * @n: the number we're accessing
- */
-#define lower_32_bits(n) ((u32)(n))
-
 struct completion;
 struct pt_regs;
 
diff --git a/lib/clz_ctz.c b/lib/clz_ctz.c
index 0d3a686b5ba2..28bb53f6cea3 100644
--- a/lib/clz_ctz.c
+++ b/lib/clz_ctz.c
@@ -11,8 +11,8 @@
  * __c[lt]z[sd]i2 can be overridden by linking arch-specific versions.
  */
 
+#include <linux/bitops.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
 
 int __weak __ctzsi2(int val);
 int __weak __ctzsi2(int val)
diff --git a/lib/lz4/lz4defs.h b/lib/lz4/lz4defs.h
index 1a7fa9d9170f..c468eab7f3c6 100644
--- a/lib/lz4/lz4defs.h
+++ b/lib/lz4/lz4defs.h
@@ -36,6 +36,7 @@
  */
 
 #include <asm/unaligned.h>
+#include <linux/bitops.h>
 #include <linux/string.h>	 /* memset, memcpy */
 
 #define FORCE_INLINE __always_inline
diff --git a/lib/math/gcd.c b/lib/math/gcd.c
index e3b042214d1b..6cd0d5b2aef7 100644
--- a/lib/math/gcd.c
+++ b/lib/math/gcd.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/gcd.h>
 #include <linux/export.h>
-- 
2.24.1

