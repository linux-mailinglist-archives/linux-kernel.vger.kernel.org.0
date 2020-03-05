Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C622E17A74A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 15:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEOVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 09:21:31 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:53487 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgCEOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:21:30 -0500
Received: by mail-wr1-f73.google.com with SMTP id w11so2349078wrp.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R7b8JJ9ZwHsRnaGbo6IVVSmSzWDTP61ESXIDdbshLCY=;
        b=ji9tVXHnNWRk47lx3rHyk6YRTtosV++W28AWMCAr59Cbsf7yqi4HVOaoi2fKa+SrID
         IriAjGAKoEumztP0Z/swgdCr3991ukzzDTPfqy6cLso6VvEDnrxaHEraQrkSK7yHzPVz
         z6FBTN1i43lsZwSh6bzUKwMayyAOvJzwjNEIrVxN5ISXZk1H21BQcKx4uFbgLZlVoVlh
         /C+M8tPdZIIbW43WDrbL1TyYlwD5sNEE1/Vd7aFIV+Of1OpRFHXvb5DT2yZkeLeKkYpo
         4nxmJwhbvaI8QEj3LC4+l7HkqJ05zlBSRl1usOOPxn86O+8fRq1RXk8qGtlU11YLkPyY
         agxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R7b8JJ9ZwHsRnaGbo6IVVSmSzWDTP61ESXIDdbshLCY=;
        b=NIRGfwdOzXuxdEiuzh6BWWAsrfBp+Jysz52X9sO95J+EvykoqqOoNBspytl/w63jPr
         1Zrw3MY4BwUUWn8/kmfxuASRN6RnlQmIsBcD920naoSc/mbn6M10E5QnOuRzx1G0rJUC
         ocQYVNmDhsAhZOXiZWjGu4hRW/AYhm/2pz/H7DckwcXJ4NkvqLAJaDNqmOKAkNza2vl2
         Id0E5PhpagZNWf+GVrbGoalBl0AzSk8Du0Eg/mo+XaKeR/0SZCFm/87Hbwl6Mtxzl1Qy
         4nSfyU5XIvROypENMB7oJLCei+n8O3pZwsty3PhLePxfmr4JOLxWCIWonBUZTvAtnutl
         5U7w==
X-Gm-Message-State: ANhLgQ3LoFyIAFTiAuFspOT8r2uXJVagXevA80ExE1LM8hF3CBIcxlrq
        kDN3bVy5Hv2kQPNmX1DhWPJ4FB74dQ==
X-Google-Smtp-Source: ADFU+vvb7Vh2TQTwawDTChJM3ls+KlVkNmyX0j7Ks22BOxANZZqtxKV7P86xhAPvp1lY4LFecodt+HoExg==
X-Received: by 2002:adf:f504:: with SMTP id q4mr10007007wro.28.1583418086225;
 Thu, 05 Mar 2020 06:21:26 -0800 (PST)
Date:   Thu,  5 Mar 2020 15:21:09 +0100
In-Reply-To: <20200305142109.50945-1-elver@google.com>
Message-Id: <20200305142109.50945-3-elver@google.com>
Mime-Version: 1.0
References: <20200305142109.50945-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 3/3] kcsan: Update API documentation in kcsan-checks.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the API documentation for ASSERT_EXCLUSIVE_* macros and make them
generate readable documentation for the code examples.

All @variable short summaries were missing ':', which was updated for
the whole file.

Tested with "make htmldocs".

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kcsan-checks.h | 98 ++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 37 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 1b8aac5d6a0b5..14fd10e5a9177 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -26,9 +26,9 @@
 /**
  * __kcsan_check_access - check generic access for races
  *
- * @ptr address of access
- * @size size of access
- * @type access type modifier
+ * @ptr: address of access
+ * @size: size of access
+ * @type: access type modifier
  */
 void __kcsan_check_access(const volatile void *ptr, size_t size, int type);
 
@@ -64,7 +64,7 @@ void kcsan_flat_atomic_end(void);
  * Force treating the next n memory accesses for the current context as atomic
  * operations.
  *
- * @n number of following memory accesses to treat as atomic.
+ * @n: number of following memory accesses to treat as atomic.
  */
 void kcsan_atomic_next(int n);
 
@@ -74,7 +74,7 @@ void kcsan_atomic_next(int n);
  * Set the access mask for all accesses for the current context if non-zero.
  * Only value changes to bits set in the mask will be reported.
  *
- * @mask bitmask
+ * @mask: bitmask
  */
 void kcsan_set_access_mask(unsigned long mask);
 
@@ -106,16 +106,16 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 /**
  * __kcsan_check_read - check regular read access for races
  *
- * @ptr address of access
- * @size size of access
+ * @ptr: address of access
+ * @size: size of access
  */
 #define __kcsan_check_read(ptr, size) __kcsan_check_access(ptr, size, 0)
 
 /**
  * __kcsan_check_write - check regular write access for races
  *
- * @ptr address of access
- * @size size of access
+ * @ptr: address of access
+ * @size: size of access
  */
 #define __kcsan_check_write(ptr, size)                                         \
 	__kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
@@ -123,16 +123,16 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 /**
  * kcsan_check_read - check regular read access for races
  *
- * @ptr address of access
- * @size size of access
+ * @ptr: address of access
+ * @size: size of access
  */
 #define kcsan_check_read(ptr, size) kcsan_check_access(ptr, size, 0)
 
 /**
  * kcsan_check_write - check regular write access for races
  *
- * @ptr address of access
- * @size size of access
+ * @ptr: address of access
+ * @size: size of access
  */
 #define kcsan_check_write(ptr, size)                                           \
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
@@ -158,14 +158,26 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
  * allowed. This assertion can be used to specify properties of concurrent code,
  * where violation cannot be detected as a normal data race.
  *
- * For example, if a per-CPU variable is only meant to be written by a single
- * CPU, but may be read from other CPUs; in this case, reads and writes must be
- * marked properly, however, if an off-CPU WRITE_ONCE() races with the owning
- * CPU's WRITE_ONCE(), would not constitute a data race but could be a harmful
- * race condition. Using this macro allows specifying this property in the code
- * and catch such bugs.
+ * For example, if we only have a single writer, but multiple concurrent
+ * readers, to avoid data races, all these accesses must be marked; even
+ * concurrent marked writes racing with the single writer are bugs.
+ * Unfortunately, due to being marked, they are no longer data races. For cases
+ * like these, we can use the macro as follows:
  *
- * @var variable to assert on
+ * .. code-block:: c
+ *
+ *	void writer(void) {
+ *		spin_lock(&update_foo_lock);
+ *		ASSERT_EXCLUSIVE_WRITER(shared_foo);
+ *		WRITE_ONCE(shared_foo, ...);
+ *		spin_unlock(&update_foo_lock);
+ *	}
+ *	void reader(void) {
+ *		// update_foo_lock does not need to be held!
+ *		... = READ_ONCE(shared_foo);
+ *	}
+ *
+ * @var: variable to assert on
  */
 #define ASSERT_EXCLUSIVE_WRITER(var)                                           \
 	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT)
@@ -177,16 +189,22 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
  * writers). This assertion can be used to specify properties of concurrent
  * code, where violation cannot be detected as a normal data race.
  *
- * For example, in a reference-counting algorithm where exclusive access is
- * expected after the refcount reaches 0. We can check that this property
- * actually holds as follows:
+ * For example, where exclusive access is expected after determining no other
+ * users of an object are left, but the object is not actually freed. We can
+ * check that this property actually holds as follows:
+ *
+ * .. code-block:: c
  *
  *	if (refcount_dec_and_test(&obj->refcnt)) {
  *		ASSERT_EXCLUSIVE_ACCESS(*obj);
- *		safely_dispose_of(obj);
+ *		do_some_cleanup(obj);
+ *		release_for_reuse(obj);
  *	}
  *
- * @var variable to assert on
+ * Note: For cases where the object is freed, `KASAN <kasan.html>`_ is a better
+ * fit to detect use-after-free bugs.
+ *
+ * @var: variable to assert on
  */
 #define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
 	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
@@ -200,7 +218,7 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
  * concurrent readers are permitted. This assertion captures more detailed
  * bit-level properties, compared to the other (word granularity) assertions.
  * Only the bits set in @mask are checked for concurrent modifications, while
- * ignoring the remaining bits, i.e. concurrent writes (or reads) to ~@mask bits
+ * ignoring the remaining bits, i.e. concurrent writes (or reads) to ~mask bits
  * are ignored.
  *
  * Use this for variables, where some bits must not be modified concurrently,
@@ -210,17 +228,21 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
  * but other bits may still be modified concurrently. A reader may wish to
  * assert that this is true as follows:
  *
+ * .. code-block:: c
+ *
  *	ASSERT_EXCLUSIVE_BITS(flags, READ_ONLY_MASK);
  *	foo = (READ_ONCE(flags) & READ_ONLY_MASK) >> READ_ONLY_SHIFT;
  *
- *   Note: The access that immediately follows ASSERT_EXCLUSIVE_BITS() is
- *   assumed to access the masked bits only, and KCSAN optimistically assumes it
- *   is therefore safe, even in the presence of data races, and marking it with
- *   READ_ONCE() is optional from KCSAN's point-of-view. We caution, however,
- *   that it may still be advisable to do so, since we cannot reason about all
- *   compiler optimizations when it comes to bit manipulations (on the reader
- *   and writer side). If you are sure nothing can go wrong, we can write the
- *   above simply as:
+ * Note: The access that immediately follows ASSERT_EXCLUSIVE_BITS() is assumed
+ * to access the masked bits only, and KCSAN optimistically assumes it is
+ * therefore safe, even in the presence of data races, and marking it with
+ * READ_ONCE() is optional from KCSAN's point-of-view. We caution, however, that
+ * it may still be advisable to do so, since we cannot reason about all compiler
+ * optimizations when it comes to bit manipulations (on the reader and writer
+ * side). If you are sure nothing can go wrong, we can write the above simply
+ * as:
+ *
+ * .. code-block:: c
  *
  * 	ASSERT_EXCLUSIVE_BITS(flags, READ_ONLY_MASK);
  *	foo = (flags & READ_ONLY_MASK) >> READ_ONLY_SHIFT;
@@ -230,15 +252,17 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
  * be modified concurrently. Writers, where other bits may change concurrently,
  * could use the assertion as follows:
  *
+ * .. code-block:: c
+ *
  *	spin_lock(&foo_lock);
  *	ASSERT_EXCLUSIVE_BITS(flags, FOO_MASK);
- *	old_flags = READ_ONCE(flags);
+ *	old_flags = flags;
  *	new_flags = (old_flags & ~FOO_MASK) | (new_foo << FOO_SHIFT);
  *	if (cmpxchg(&flags, old_flags, new_flags) != old_flags) { ... }
  *	spin_unlock(&foo_lock);
  *
- * @var variable to assert on
- * @mask only check for modifications to bits set in @mask
+ * @var: variable to assert on
+ * @mask: only check for modifications to bits set in @mask
  */
 #define ASSERT_EXCLUSIVE_BITS(var, mask)                                       \
 	do {                                                                   \
-- 
2.25.0.265.gbab2e86ba0-goog

