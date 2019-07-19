Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810DF6E662
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfGSN2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 09:28:40 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:35778 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfGSN2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:28:40 -0400
Received: by mail-yb1-f202.google.com with SMTP id w6so24675789ybo.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CieYDgU1j7WHeryDkyQpHsfZB1hSZxkxH69srwlIIMw=;
        b=pdZXIxj3VQh4FDQq8n3sOZYekcAiUpZd6+dZYtDpK2uerfYvumeNG5bUhmF8e34Nc9
         Xou5XTNjUFHY0MXFqC2jpiaQXARvha+A/gTaORGnqin+tpogEFn+BxTEP6/+zpXgOX5K
         NiJ/t6OG9gbSHcmLU9/rPGPfQ5tpZC7dpdQpOcQ8iq2SxytfXgcX/9qLgHK5qc16C76I
         L7FfuqaNeCNlfQLNCopwGL6JA8VQNZF+CKYt69nPBv8qZB0ds9+IyzDcp1l6z0loOjrW
         bPSqcp+M558GiYrr98Afd/9EiV1RBKJILFouerf8EZQ0X/qIEy7ls4RJo++5P90x0LcG
         yYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CieYDgU1j7WHeryDkyQpHsfZB1hSZxkxH69srwlIIMw=;
        b=iFUS7bBb4oZTOfClLactfDuZychITmi1CZEFmZfwzJ72NZRO0VbGXT7zVnpdRm9Yc5
         nPZMXswyLsCieZUu6RVtgFPCoHoKcXcfICO1Z27LU96LAcCAIkMRWrE4tUZGkx1pLDUk
         frzsmIO6kq7JlFJ+EvSWjYo4qywgaraBdlTEavN+t3Mwhni67913LkHVrlKxSbGdpoL4
         UezD0h2uctj5sT2STCXQCV1Ny10QHwDUDxbUOYkctVRN8vuXXvCo8GtT/VaWlXDHww+z
         9tbaRUMDYvxX3GvRwapGx6cf2IX8RFDA8SUCr2HHHF9Yr9f2dqs/Ec7wtjJqEA71rDvw
         Y5HQ==
X-Gm-Message-State: APjAAAXaLh1yTJ3StWFbFV/r7vvRJ0UB4DycMSv31iGcjdKU3EY9jAbV
        lFhWPIcY53AF3WPJqKnkwfrV3z6FLQ==
X-Google-Smtp-Source: APXvYqwo88XzN4d2jI5lLCdpmbvbinX9UaANxF9UQI5JNBD6qcfdTMhfF39ek45Mz87NYaC18pQgw6Rfeg==
X-Received: by 2002:a81:a155:: with SMTP id y82mr31345602ywg.80.1563542918815;
 Fri, 19 Jul 2019 06:28:38 -0700 (PDT)
Date:   Fri, 19 Jul 2019 15:28:18 +0200
In-Reply-To: <20190719132818.40258-1-elver@google.com>
Message-Id: <20190719132818.40258-2-elver@google.com>
Mime-Version: 1.0
References: <20190719132818.40258-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH 2/2] lib/test_kasan: Add stack overflow test
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a simple stack overflow test, to check the error being reported on
an overflow. Without CONFIG_STACK_GUARD_PAGE, the result is typically
some seemingly unrelated KASAN error message due to accessing random
other memory.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kasan-dev@googlegroups.com
---
 lib/test_kasan.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index b63b367a94e8..3092ec01189d 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -15,6 +15,7 @@
 #include <linux/mman.h>
 #include <linux/module.h>
 #include <linux/printk.h>
+#include <linux/sched/task_stack.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
@@ -709,6 +710,32 @@ static noinline void __init kmalloc_double_kzfree(void)
 	kzfree(ptr);
 }
 
+#ifdef CONFIG_STACK_GUARD_PAGE
+static noinline void __init stack_overflow_via_recursion(void)
+{
+	volatile int n = 512;
+
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_STACK_GROWSUP));
+
+	/* About to overflow: overflow via alloca'd array and try to write. */
+	if (!object_is_on_stack((void *)&n - n)) {
+		volatile char overflow[n];
+
+		overflow[0] = overflow[0];
+		return;
+	}
+
+	stack_overflow_via_recursion();
+}
+
+static noinline void __init kasan_stack_overflow(void)
+{
+	pr_info("stack overflow begin\n");
+	stack_overflow_via_recursion();
+	pr_info("stack overflow end\n");
+}
+#endif
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -753,6 +780,15 @@ static int __init kmalloc_tests_init(void)
 	kasan_bitops();
 	kmalloc_double_kzfree();
 
+#ifdef CONFIG_STACK_GUARD_PAGE
+	/*
+	 * Only test with CONFIG_STACK_GUARD_PAGE, as without we get other
+	 * random KASAN violations, due to accessing other random memory (we
+	 * want to avoid actually corrupting memory in these tests).
+	 */
+	kasan_stack_overflow();
+#endif
+
 	kasan_restore_multi_shot(multishot);
 
 	return -EAGAIN;
-- 
2.22.0.657.g960e92d24f-goog

