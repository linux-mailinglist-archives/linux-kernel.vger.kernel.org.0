Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7962C151BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 15:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBDOEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 09:04:11 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:34495 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgBDOEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:04:11 -0500
Received: by mail-wm1-f73.google.com with SMTP id y125so967369wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 06:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6E0waZpVztRIyJBw+i4kvl8HN7efuLnbdgojMgz5Rmw=;
        b=lGIAixLV+ayI9Qy1abuZWKsUCNlR/mm58aRRkdADj1yiQQQQ6UgooMmeEjiXMabYP+
         6eLNK/UvO4iLGXAEaMMldEKK36LGOFMQNbJ5d/ByJIpnO88H6rQ4xs1IdABmmvfkgeDb
         LNfaU5xZJyX6HR5S8in+nJkQT94lMhroqss66zQB8E8XyH5UdOGkXdyHnASEK5qnxy17
         qr+Fa4e787GsDcAXResbX3NaLr8dDDcP/p8vOhRNXtQ2IwjfdNdSkZ78O+THfeaoiMZb
         LGnPvrMXXW9gItNXuOOXzm7Ar7nFvKSmFMS+wLMfPxZqOvLY1kWGX8JPIcBpvUXQ3kNN
         c5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6E0waZpVztRIyJBw+i4kvl8HN7efuLnbdgojMgz5Rmw=;
        b=Yagan+jVTKFUm9YUMmDY9MPaudT9M8E9h0GM/H2IjXCdNz1EwNbHLIwI4IP1YS/O10
         Osk8tUaeZXNZjPzPQ1yHINPeXPquff3kGOOhO61Buth4UGRGh70dYDOZOePx7vAyUHdq
         ua13re5jQxNODhxI7XiY6dAAzpqfz2Sotc/i8dBbVd/PBfKYPWozZC+ofN9b0bSSIDso
         2ULLqHkjgKPR9W8fY56vmbd7SfQJmmxsqLa0QP9VWd3cgqgMpy73k04p1ebW+Xwvu+Tv
         qKtHU63WxAaDnY26xAUG0Effe6yBySI71CsNbh8fD8vPKXOIsXl8gfpmqmRJahzf86iI
         IKsw==
X-Gm-Message-State: APjAAAV0855pZPXsNuIhSM+la78YqTpBc5f/dno4/Pz1x0PZKEVt37nr
        OPeXby+ssp/ghWhBbrU/Y/33rFiA/A==
X-Google-Smtp-Source: APXvYqysjQzHdNHL9THS4bhwYIM5LDSWJy+qmInHc4Q7Vmwh+2fbp6SIDazfqdEtNsbpSTgob46jEBlYow==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr23816462wru.57.1580825047557;
 Tue, 04 Feb 2020 06:04:07 -0800 (PST)
Date:   Tue,  4 Feb 2020 15:03:51 +0100
Message-Id: <20200204140353.177797-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 1/3] kcsan: Add option to assume plain writes up to word size
 are atomic
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds option KCSAN_ASSUME_PLAIN_WRITES_ATOMIC. If enabled, plain
writes up to word size are also assumed to be atomic, and also not
subject to other unsafe compiler optimizations resulting in data races.

This option has been enabled by default to reflect current kernel-wide
preferences.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 20 +++++++++++++++-----
 lib/Kconfig.kcsan   | 26 +++++++++++++++++++-------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 64b30f7716a12..3bd1bf8d6bfeb 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -169,10 +169,19 @@ static __always_inline struct kcsan_ctx *get_ctx(void)
 	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
 }
 
-static __always_inline bool is_atomic(const volatile void *ptr)
+static __always_inline bool
+is_atomic(const volatile void *ptr, size_t size, int type)
 {
-	struct kcsan_ctx *ctx = get_ctx();
+	struct kcsan_ctx *ctx;
+
+	if ((type & KCSAN_ACCESS_ATOMIC) != 0)
+		return true;
 
+	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
+	    (type & KCSAN_ACCESS_WRITE) != 0 && size <= sizeof(long))
+		return true; /* Assume all writes up to word size are atomic. */
+
+	ctx = get_ctx();
 	if (unlikely(ctx->atomic_next > 0)) {
 		/*
 		 * Because we do not have separate contexts for nested
@@ -193,7 +202,8 @@ static __always_inline bool is_atomic(const volatile void *ptr)
 	return kcsan_is_atomic(ptr);
 }
 
-static __always_inline bool should_watch(const volatile void *ptr, int type)
+static __always_inline bool
+should_watch(const volatile void *ptr, size_t size, int type)
 {
 	/*
 	 * Never set up watchpoints when memory operations are atomic.
@@ -202,7 +212,7 @@ static __always_inline bool should_watch(const volatile void *ptr, int type)
 	 * should not count towards skipped instructions, and (2) to actually
 	 * decrement kcsan_atomic_next for consecutive instruction stream.
 	 */
-	if ((type & KCSAN_ACCESS_ATOMIC) != 0 || is_atomic(ptr))
+	if (is_atomic(ptr, size, type))
 		return false;
 
 	if (this_cpu_dec_return(kcsan_skip) >= 0)
@@ -460,7 +470,7 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
 	if (unlikely(watchpoint != NULL))
 		kcsan_found_watchpoint(ptr, size, type, watchpoint,
 				       encoded_watchpoint);
-	else if (unlikely(should_watch(ptr, type)))
+	else if (unlikely(should_watch(ptr, size, type)))
 		kcsan_setup_watchpoint(ptr, size, type);
 }
 
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 3552990abcfe5..08972376f0454 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -91,13 +91,13 @@ config KCSAN_REPORT_ONCE_IN_MS
 	  limiting reporting to avoid flooding the console with reports.
 	  Setting this to 0 disables rate limiting.
 
-# Note that, while some of the below options could be turned into boot
-# parameters, to optimize for the common use-case, we avoid this because: (a)
-# it would impact performance (and we want to avoid static branch for all
-# {READ,WRITE}_ONCE, atomic_*, bitops, etc.), and (b) complicate the design
-# without real benefit. The main purpose of the below options is for use in
-# fuzzer configs to control reported data races, and they are not expected
-# to be switched frequently by a user.
+# The main purpose of the below options is to control reported data races (e.g.
+# in fuzzer configs), and are not expected to be switched frequently by other
+# users. We could turn some of them into boot parameters, but given they should
+# not be switched normally, let's keep them here to simplify configuration.
+#
+# The defaults below are chosen to be very conservative, and may miss certain
+# bugs.
 
 config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
 	bool "Report races of unknown origin"
@@ -116,6 +116,18 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
 	  the data value of the memory location was observed to remain
 	  unchanged, do not report the data race.
 
+config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
+	bool "Assume that plain writes up to word size are atomic"
+	default y
+	help
+	  Assume that plain writes up to word size are atomic by default, and
+	  also not subject to other unsafe compiler optimizations resulting in
+	  data races. This will cause KCSAN to not report data races due to
+	  conflicts where the only plain accesses are writes up to word size:
+	  conflicts between marked reads and plain writes up to word size will
+	  not be reported as data races; notice that data races between two
+	  conflicting plain writes will also not be reported.
+
 config KCSAN_IGNORE_ATOMICS
 	bool "Do not instrument marked atomic accesses"
 	help
-- 
2.25.0.341.g760bfbb309-goog

