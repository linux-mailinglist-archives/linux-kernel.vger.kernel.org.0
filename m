Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B614056BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 16:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfFZO2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 10:28:02 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34046 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZO2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:28:00 -0400
Received: by mail-pg1-f201.google.com with SMTP id x19so1492776pgx.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rln2FP6BOxdiVf8wORphr5UbX/lGN9PNgnvsQm0pxfA=;
        b=b1IaFK1mLKquMHrwUdq8QS9ugryrRPvq91UQ0Uq6LFY+c2JG0h8vOnQRBq9Y4iBHrd
         17LsoajCwmnclKkY2LGLzmZK9jswwvQ8KphGCaAcqDw3Y5nANf73MjW7Cdyza3VWGCrS
         zpMj+JpcmgUaOeIauUqJJoduT7cgP35I/T6J0lq7MXm+xBM7VbsrPucsTC/qhyGJNYqj
         Jq0SH14PhfI7POH8+ntsXeZlQLTimCrlHvzHDw1oHqI66dDTIlPptw8JxI9T+XhR2DNf
         D9MpYcQLyK6spvA7kZWNLDDdjpLaHgbAIKd/hbGa6ghj3SUJRGWYatvWEVeUYYzWX5l9
         DKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rln2FP6BOxdiVf8wORphr5UbX/lGN9PNgnvsQm0pxfA=;
        b=Xj6TZHVIJLt4RAtSN7UxjrA9d8hkA+LXNf7G/yuXTAIN4eoZr009RFKPQECWmjGkrm
         su4u65cJWxVHjfaRaBw8GqQBNVLHE2ycj+M04JZV844H7ZGWcuq7HUWB/0C5IjIOq1nW
         zKTqPY1S8vxsa2AJk6r/G3sIBvkLZBtqGJ/Q3hnkz8zC28NSm44tEQNTvgNdjJJ/hb5N
         M5KmcSjt93hUs5fM/xG0wbbLq6uJkLpZ8ftBOhCCaY6/MivaSIMKqwboOJdujXKoirSo
         yv81I0Eie8UO4sZLKzMf5uWtl2G/nxsnRdomyZ9kFKMzL6yDQJow4lDC5pF/rNHt4C3i
         byOg==
X-Gm-Message-State: APjAAAXWRsjtOAlXGtTW6NI9lgERPWlL/iBDX+CD2ZIRacQz0IW+zgkJ
        YhkBgWagEYMEzDbb585V3fcXuQSIEg==
X-Google-Smtp-Source: APXvYqwQ22+0NkxIaX9CnqzWtnR2UzcffAGPuQ8MCIc490y2qHEX39KgAM5Jw+zu+rhdlMT/dvmAxkp4nA==
X-Received: by 2002:a65:4387:: with SMTP id m7mr3168635pgp.287.1561559279316;
 Wed, 26 Jun 2019 07:27:59 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:20:11 +0200
In-Reply-To: <20190626142014.141844-1-elver@google.com>
Message-Id: <20190626142014.141844-3-elver@google.com>
Mime-Version: 1.0
References: <20190626142014.141844-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 2/5] mm/kasan: Change kasan_check_{read,write} to return boolean
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes {,__}kasan_check_{read,write} functions to return a boolean
denoting if the access was valid or not.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
v3:
* Fix Formatting and split introduction of __kasan_check_* and returning
  bool into 2 patches.
---
 include/linux/kasan-checks.h | 36 ++++++++++++++++++++++--------------
 mm/kasan/common.c            |  8 ++++----
 mm/kasan/generic.c           | 13 +++++++------
 mm/kasan/kasan.h             | 10 +++++++++-
 mm/kasan/tags.c              | 12 +++++++-----
 5 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
index 19a0175d2452..2c7f0b6307b2 100644
--- a/include/linux/kasan-checks.h
+++ b/include/linux/kasan-checks.h
@@ -8,13 +8,17 @@
  * to validate access to an address.   Never use these in header files!
  */
 #ifdef CONFIG_KASAN
-void __kasan_check_read(const volatile void *p, unsigned int size);
-void __kasan_check_write(const volatile void *p, unsigned int size);
+bool __kasan_check_read(const volatile void *p, unsigned int size);
+bool __kasan_check_write(const volatile void *p, unsigned int size);
 #else
-static inline void __kasan_check_read(const volatile void *p, unsigned int size)
-{ }
-static inline void __kasan_check_write(const volatile void *p, unsigned int size)
-{ }
+static inline bool __kasan_check_read(const volatile void *p, unsigned int size)
+{
+	return true;
+}
+static inline bool __kasan_check_write(const volatile void *p, unsigned int size)
+{
+	return true;
+}
 #endif
 
 /*
@@ -22,19 +26,23 @@ static inline void __kasan_check_write(const volatile void *p, unsigned int size
  * instrumentation enabled. May be used in header files.
  */
 #ifdef __SANITIZE_ADDRESS__
-static inline void kasan_check_read(const volatile void *p, unsigned int size)
+static inline bool kasan_check_read(const volatile void *p, unsigned int size)
 {
-	__kasan_check_read(p, size);
+	return __kasan_check_read(p, size);
 }
-static inline void kasan_check_write(const volatile void *p, unsigned int size)
+static inline bool kasan_check_write(const volatile void *p, unsigned int size)
 {
-	__kasan_check_read(p, size);
+	return __kasan_check_read(p, size);
 }
 #else
-static inline void kasan_check_read(const volatile void *p, unsigned int size)
-{ }
-static inline void kasan_check_write(const volatile void *p, unsigned int size)
-{ }
+static inline bool kasan_check_read(const volatile void *p, unsigned int size)
+{
+	return true;
+}
+static inline bool kasan_check_write(const volatile void *p, unsigned int size)
+{
+	return true;
+}
 #endif
 
 #endif
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6bada42cc152..2277b82902d8 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -87,15 +87,15 @@ void kasan_disable_current(void)
 	current->kasan_depth--;
 }
 
-void __kasan_check_read(const volatile void *p, unsigned int size)
+bool __kasan_check_read(const volatile void *p, unsigned int size)
 {
-	check_memory_region((unsigned long)p, size, false, _RET_IP_);
+	return check_memory_region((unsigned long)p, size, false, _RET_IP_);
 }
 EXPORT_SYMBOL(__kasan_check_read);
 
-void __kasan_check_write(const volatile void *p, unsigned int size)
+bool __kasan_check_write(const volatile void *p, unsigned int size)
 {
-	check_memory_region((unsigned long)p, size, true, _RET_IP_);
+	return check_memory_region((unsigned long)p, size, true, _RET_IP_);
 }
 EXPORT_SYMBOL(__kasan_check_write);
 
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 504c79363a34..616f9dd82d12 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -166,29 +166,30 @@ static __always_inline bool memory_is_poisoned(unsigned long addr, size_t size)
 	return memory_is_poisoned_n(addr, size);
 }
 
-static __always_inline void check_memory_region_inline(unsigned long addr,
+static __always_inline bool check_memory_region_inline(unsigned long addr,
 						size_t size, bool write,
 						unsigned long ret_ip)
 {
 	if (unlikely(size == 0))
-		return;
+		return true;
 
 	if (unlikely((void *)addr <
 		kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
 		kasan_report(addr, size, write, ret_ip);
-		return;
+		return false;
 	}
 
 	if (likely(!memory_is_poisoned(addr, size)))
-		return;
+		return true;
 
 	kasan_report(addr, size, write, ret_ip);
+	return false;
 }
 
-void check_memory_region(unsigned long addr, size_t size, bool write,
+bool check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip)
 {
-	check_memory_region_inline(addr, size, write, ret_ip);
+	return check_memory_region_inline(addr, size, write, ret_ip);
 }
 
 void kasan_cache_shrink(struct kmem_cache *cache)
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 3ce956efa0cb..e62ea45d02e3 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -123,7 +123,15 @@ static inline bool addr_has_shadow(const void *addr)
 
 void kasan_poison_shadow(const void *address, size_t size, u8 value);
 
-void check_memory_region(unsigned long addr, size_t size, bool write,
+/**
+ * check_memory_region - Check memory region, and report if invalid access.
+ * @addr: the accessed address
+ * @size: the accessed size
+ * @write: true if access is a write access
+ * @ret_ip: return address
+ * @return: true if access was valid, false if invalid
+ */
+bool check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip);
 
 void *find_first_bad_addr(void *addr, size_t size);
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 63fca3172659..0e987c9ca052 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -76,7 +76,7 @@ void *kasan_reset_tag(const void *addr)
 	return reset_tag(addr);
 }
 
-void check_memory_region(unsigned long addr, size_t size, bool write,
+bool check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip)
 {
 	u8 tag;
@@ -84,7 +84,7 @@ void check_memory_region(unsigned long addr, size_t size, bool write,
 	void *untagged_addr;
 
 	if (unlikely(size == 0))
-		return;
+		return true;
 
 	tag = get_tag((const void *)addr);
 
@@ -106,22 +106,24 @@ void check_memory_region(unsigned long addr, size_t size, bool write,
 	 * set to KASAN_TAG_KERNEL (0xFF)).
 	 */
 	if (tag == KASAN_TAG_KERNEL)
-		return;
+		return true;
 
 	untagged_addr = reset_tag((const void *)addr);
 	if (unlikely(untagged_addr <
 			kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
 		kasan_report(addr, size, write, ret_ip);
-		return;
+		return false;
 	}
 	shadow_first = kasan_mem_to_shadow(untagged_addr);
 	shadow_last = kasan_mem_to_shadow(untagged_addr + size - 1);
 	for (shadow = shadow_first; shadow <= shadow_last; shadow++) {
 		if (*shadow != tag) {
 			kasan_report(addr, size, write, ret_ip);
-			return;
+			return false;
 		}
 	}
+
+	return true;
 }
 
 #define DEFINE_HWASAN_LOAD_STORE(size)					\
-- 
2.22.0.410.gd8fdbe21b5-goog

