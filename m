Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07D4CE82C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 17:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfJGPrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 11:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbfJGPrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:47:12 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B947320679;
        Mon,  7 Oct 2019 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570463231;
        bh=C8JmJDT+tPzJjfKLb5X9KzRiaf++pQ8Rgf431GY5hKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSpXyU9qzJJohs68LWbMUsAXPTZLKtfuJrtcm4trDq0gPlnC7Xni2fo4yRSZrlGtt
         /UWTqB6srs6lnzfOBHLpYfVaBdFWg+s0Tlk3tpfAa1x2SLPNDAE+C8ZqdHb8VksyOr
         BxGr3jjlbPoJMRs5n7dOShRNzF2RzocwoMMKPa3w=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v3 01/10] lib/refcount: Define constants for saturation and max refcount values
Date:   Mon,  7 Oct 2019 16:46:54 +0100
Message-Id: <20191007154703.5574-2-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191007154703.5574-1-will@kernel.org>
References: <20191007154703.5574-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The REFCOUNT_FULL implementation uses a different saturation point than
the x86 implementation, which means that the shared refcount code in
lib/refcount.c (e.g. refcount_dec_not_one()) needs to be aware of the
difference.

Rather than duplicate the definitions from the lkdtm driver, instead
move them into linux/refcount.h and update all references accordingly.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/misc/lkdtm/refcount.c |  8 --------
 include/linux/refcount.h      | 10 +++++++++-
 lib/refcount.c                | 37 +++++++++++++++++++----------------
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/lkdtm/refcount.c b/drivers/misc/lkdtm/refcount.c
index 0a146b32da13..abf3b7c1f686 100644
--- a/drivers/misc/lkdtm/refcount.c
+++ b/drivers/misc/lkdtm/refcount.c
@@ -6,14 +6,6 @@
 #include "lkdtm.h"
 #include <linux/refcount.h>
 
-#ifdef CONFIG_REFCOUNT_FULL
-#define REFCOUNT_MAX		(UINT_MAX - 1)
-#define REFCOUNT_SATURATED	UINT_MAX
-#else
-#define REFCOUNT_MAX		INT_MAX
-#define REFCOUNT_SATURATED	(INT_MIN / 2)
-#endif
-
 static void overflow_check(refcount_t *ref)
 {
 	switch (refcount_read(ref)) {
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index e28cce21bad6..79f62e8d2256 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -4,6 +4,7 @@
 
 #include <linux/atomic.h>
 #include <linux/compiler.h>
+#include <linux/limits.h>
 #include <linux/spinlock_types.h>
 
 struct mutex;
@@ -12,7 +13,7 @@ struct mutex;
  * struct refcount_t - variant of atomic_t specialized for reference counts
  * @refs: atomic_t counter field
  *
- * The counter saturates at UINT_MAX and will not move once
+ * The counter saturates at REFCOUNT_SATURATED and will not move once
  * there. This avoids wrapping the counter and causing 'spurious'
  * use-after-free bugs.
  */
@@ -56,6 +57,9 @@ extern void refcount_dec_checked(refcount_t *r);
 
 #ifdef CONFIG_REFCOUNT_FULL
 
+#define REFCOUNT_MAX		(UINT_MAX - 1)
+#define REFCOUNT_SATURATED	UINT_MAX
+
 #define refcount_add_not_zero	refcount_add_not_zero_checked
 #define refcount_add		refcount_add_checked
 
@@ -68,6 +72,10 @@ extern void refcount_dec_checked(refcount_t *r);
 #define refcount_dec		refcount_dec_checked
 
 #else
+
+#define REFCOUNT_MAX		INT_MAX
+#define REFCOUNT_SATURATED	(INT_MIN / 2)
+
 # ifdef CONFIG_ARCH_HAS_REFCOUNT
 #  include <asm/refcount.h>
 # else
diff --git a/lib/refcount.c b/lib/refcount.c
index 6e904af0fb3e..48b78a423d7d 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -5,8 +5,8 @@
  * The interface matches the atomic_t interface (to aid in porting) but only
  * provides the few functions one should use for reference counting.
  *
- * It differs in that the counter saturates at UINT_MAX and will not move once
- * there. This avoids wrapping the counter and causing 'spurious'
+ * It differs in that the counter saturates at REFCOUNT_SATURATED and will not
+ * move once there. This avoids wrapping the counter and causing 'spurious'
  * use-after-free issues.
  *
  * Memory ordering rules are slightly relaxed wrt regular atomic_t functions
@@ -48,7 +48,7 @@
  * @i: the value to add to the refcount
  * @r: the refcount
  *
- * Will saturate at UINT_MAX and WARN.
+ * Will saturate at REFCOUNT_SATURATED and WARN.
  *
  * Provides no memory ordering, it is assumed the caller has guaranteed the
  * object memory to be stable (RCU, etc.). It does provide a control dependency
@@ -69,16 +69,17 @@ bool refcount_add_not_zero_checked(unsigned int i, refcount_t *r)
 		if (!val)
 			return false;
 
-		if (unlikely(val == UINT_MAX))
+		if (unlikely(val == REFCOUNT_SATURATED))
 			return true;
 
 		new = val + i;
 		if (new < val)
-			new = UINT_MAX;
+			new = REFCOUNT_SATURATED;
 
 	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &val, new));
 
-	WARN_ONCE(new == UINT_MAX, "refcount_t: saturated; leaking memory.\n");
+	WARN_ONCE(new == REFCOUNT_SATURATED,
+		  "refcount_t: saturated; leaking memory.\n");
 
 	return true;
 }
@@ -89,7 +90,7 @@ EXPORT_SYMBOL(refcount_add_not_zero_checked);
  * @i: the value to add to the refcount
  * @r: the refcount
  *
- * Similar to atomic_add(), but will saturate at UINT_MAX and WARN.
+ * Similar to atomic_add(), but will saturate at REFCOUNT_SATURATED and WARN.
  *
  * Provides no memory ordering, it is assumed the caller has guaranteed the
  * object memory to be stable (RCU, etc.). It does provide a control dependency
@@ -110,7 +111,8 @@ EXPORT_SYMBOL(refcount_add_checked);
  * refcount_inc_not_zero_checked - increment a refcount unless it is 0
  * @r: the refcount to increment
  *
- * Similar to atomic_inc_not_zero(), but will saturate at UINT_MAX and WARN.
+ * Similar to atomic_inc_not_zero(), but will saturate at REFCOUNT_SATURATED
+ * and WARN.
  *
  * Provides no memory ordering, it is assumed the caller has guaranteed the
  * object memory to be stable (RCU, etc.). It does provide a control dependency
@@ -133,7 +135,8 @@ bool refcount_inc_not_zero_checked(refcount_t *r)
 
 	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &val, new));
 
-	WARN_ONCE(new == UINT_MAX, "refcount_t: saturated; leaking memory.\n");
+	WARN_ONCE(new == REFCOUNT_SATURATED,
+		  "refcount_t: saturated; leaking memory.\n");
 
 	return true;
 }
@@ -143,7 +146,7 @@ EXPORT_SYMBOL(refcount_inc_not_zero_checked);
  * refcount_inc_checked - increment a refcount
  * @r: the refcount to increment
  *
- * Similar to atomic_inc(), but will saturate at UINT_MAX and WARN.
+ * Similar to atomic_inc(), but will saturate at REFCOUNT_SATURATED and WARN.
  *
  * Provides no memory ordering, it is assumed the caller already has a
  * reference on the object.
@@ -164,7 +167,7 @@ EXPORT_SYMBOL(refcount_inc_checked);
  *
  * Similar to atomic_dec_and_test(), but it will WARN, return false and
  * ultimately leak on underflow and will fail to decrement when saturated
- * at UINT_MAX.
+ * at REFCOUNT_SATURATED.
  *
  * Provides release memory ordering, such that prior loads and stores are done
  * before, and provides an acquire ordering on success such that free()
@@ -182,7 +185,7 @@ bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r)
 	unsigned int new, val = atomic_read(&r->refs);
 
 	do {
-		if (unlikely(val == UINT_MAX))
+		if (unlikely(val == REFCOUNT_SATURATED))
 			return false;
 
 		new = val - i;
@@ -207,7 +210,7 @@ EXPORT_SYMBOL(refcount_sub_and_test_checked);
  * @r: the refcount
  *
  * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
- * decrement when saturated at UINT_MAX.
+ * decrement when saturated at REFCOUNT_SATURATED.
  *
  * Provides release memory ordering, such that prior loads and stores are done
  * before, and provides an acquire ordering on success such that free()
@@ -226,7 +229,7 @@ EXPORT_SYMBOL(refcount_dec_and_test_checked);
  * @r: the refcount
  *
  * Similar to atomic_dec(), it will WARN on underflow and fail to decrement
- * when saturated at UINT_MAX.
+ * when saturated at REFCOUNT_SATURATED.
  *
  * Provides release memory ordering, such that prior loads and stores are done
  * before.
@@ -277,7 +280,7 @@ bool refcount_dec_not_one(refcount_t *r)
 	unsigned int new, val = atomic_read(&r->refs);
 
 	do {
-		if (unlikely(val == UINT_MAX))
+		if (unlikely(val == REFCOUNT_SATURATED))
 			return true;
 
 		if (val == 1)
@@ -302,7 +305,7 @@ EXPORT_SYMBOL(refcount_dec_not_one);
  * @lock: the mutex to be locked
  *
  * Similar to atomic_dec_and_mutex_lock(), it will WARN on underflow and fail
- * to decrement when saturated at UINT_MAX.
+ * to decrement when saturated at REFCOUNT_SATURATED.
  *
  * Provides release memory ordering, such that prior loads and stores are done
  * before, and provides a control dependency such that free() must come after.
@@ -333,7 +336,7 @@ EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
  * @lock: the spinlock to be locked
  *
  * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
- * decrement when saturated at UINT_MAX.
+ * decrement when saturated at REFCOUNT_SATURATED.
  *
  * Provides release memory ordering, such that prior loads and stores are done
  * before, and provides a control dependency such that free() must come after.
-- 
2.23.0.581.g78d2f28ef7-goog

