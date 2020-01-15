Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7F213C931
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 17:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAOQZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 11:25:29 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:54910 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:25:29 -0500
Received: by mail-wr1-f74.google.com with SMTP id z10so8111911wrt.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 08:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tWWTYC00Bevk0nm3TMQwKmrrXXB+slBnVDIOhwQFpv4=;
        b=r0T9BBionfWskR1Xq8jf7YXoNi96sNhF56hy+4o9Et3S7rtnV01HQNZOu8x1mPe81M
         GXTGmxV3lKvJZuV8exkpoaZFfXTn+ioKab08wxkHakvbIghcQOa0zLoQXVhS8LZkxv/J
         Kc1Fojtf7ptnyIOGFtmijpqNlQhTeK3WDzS2PQD9wYW9rjTs2X2lkFL6x8rYHD6dBpN2
         wPhxY78HPDxmFEBzF0gRqzONB8XDIzs5Eb25GvPAfrNle1FfG01Lh4SzyoZHq5Vqm8r9
         uolzsgsysz4kr64k9tmR1SKt1Z4h5uGk9DEPP0l8VU8H2HaJnH4OSo9fEz7PRL5z6g3E
         zRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tWWTYC00Bevk0nm3TMQwKmrrXXB+slBnVDIOhwQFpv4=;
        b=HJAvynzz44SDl6H4NYRzNEOdgA/Hy9GugVTHhCxo4308JVYfqs3sJxA2qV7wKfSL4p
         Lwn5/rzqKDbFX9o8JiP7tYV/0aJNX45kaxZ2rg+JPGrOd6Z/PygEvKBRhF1pyJmM2zrr
         x0l8jN2Ln17YEVuH800496VNdfNDMhJipRtV0V38r52Ba3sGFfTl7R4osm2H/UzgP6/j
         vZlXB/I2J6uk2R7htIdJL3QBMZ7J7XVQ62wMJNxm7aIz9JaduwG7EY8a730u4rtfvq7+
         ne6xSvoc/ZKuJATg/m6fWMRxBK0ZZqDM4t/zjB0LKAuesUkrGYRKwoFWhATJ+WVRGll/
         Yj4w==
X-Gm-Message-State: APjAAAXKJggrBgstbfdE/BmMnvqfG4hPXzdLVn7FQ3mFqbOTYoniP7wB
        ZxgW5O0yuRHyLHcJWxm01IOqMrmEbA==
X-Google-Smtp-Source: APXvYqySqGkcWRj0mfxo6Gipa21DivFSVqMrAJmqtGMbaQnBj9bVh5a60EfmSLvPbOjMVIREYyAvBbLYcQ==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr31874609wrs.303.1579105526489;
 Wed, 15 Jan 2020 08:25:26 -0800 (PST)
Date:   Wed, 15 Jan 2020 17:25:12 +0100
Message-Id: <20200115162512.70807-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH -rcu v2] kcsan: Make KCSAN compatible with lockdep
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must avoid any recursion into lockdep if KCSAN is enabled on
utilities used by lockdep. One manifestation of this is corrupting
lockdep's IRQ trace state (if TRACE_IRQFLAGS). Fix this by:

1. Using raw_local_irq{save,restore} in kcsan_setup_watchpoint().
2. Disabling lockdep in kcsan_report().

Tested with:

  CONFIG_LOCKDEP=y
  CONFIG_DEBUG_LOCKDEP=y
  CONFIG_TRACE_IRQFLAGS=y

Where previously, the following warning (and variants with different
stack traces) was consistently generated, with the fix introduced in
this patch, the warning cannot be reproduced.

    WARNING: CPU: 0 PID: 2 at kernel/locking/lockdep.c:4406 check_flags.part.0+0x101/0x220
    Modules linked in:
    CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.5.0-rc1+ #11
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
    RIP: 0010:check_flags.part.0+0x101/0x220
    <snip>
    Call Trace:
     lock_is_held_type+0x69/0x150
     freezer_fork+0x20b/0x370
     cgroup_post_fork+0x2c9/0x5c0
     copy_process+0x2675/0x3b40
     _do_fork+0xbe/0xa30
     ? _raw_spin_unlock_irqrestore+0x40/0x50
     ? match_held_lock+0x56/0x250
     ? kthread_park+0xf0/0xf0
     kernel_thread+0xa6/0xd0
     ? kthread_park+0xf0/0xf0
     kthreadd+0x321/0x3d0
     ? kthread_create_on_cpu+0x130/0x130
     ret_from_fork+0x3a/0x50
    irq event stamp: 64
    hardirqs last  enabled at (63): [<ffffffff9a7995d0>] _raw_spin_unlock_irqrestore+0x40/0x50
    hardirqs last disabled at (64): [<ffffffff992a96d2>] kcsan_setup_watchpoint+0x92/0x460
    softirqs last  enabled at (32): [<ffffffff990489b8>] fpu__copy+0xe8/0x470
    softirqs last disabled at (30): [<ffffffff99048939>] fpu__copy+0x69/0x470

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Update comments.
---
 kernel/kcsan/core.c     |  6 ++++--
 kernel/kcsan/report.c   | 11 +++++++++++
 kernel/locking/Makefile |  3 +++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 87bf857c8893..64b30f7716a1 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -336,8 +336,10 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 *      CPU-local data accesses), it makes more sense (from a data race
 	 *      detection point of view) to simply disable preemptions to ensure
 	 *      as many tasks as possible run on other CPUs.
+	 *
+	 * Use raw versions, to avoid lockdep recursion via IRQ flags tracing.
 	 */
-	local_irq_save(irq_flags);
+	raw_local_irq_save(irq_flags);
 
 	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint == NULL) {
@@ -429,7 +431,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
-	local_irq_restore(irq_flags);
+	raw_local_irq_restore(irq_flags);
 out:
 	user_access_restore(ua_flags);
 }
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index b5b4feea49de..33bdf8b229b5 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -2,6 +2,7 @@
 
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/lockdep.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
 #include <linux/sched.h>
@@ -410,6 +411,14 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 {
 	unsigned long flags = 0;
 
+	/*
+	 * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
+	 * we do not turn off lockdep here; this could happen due to recursion
+	 * into lockdep via KCSAN if we detect a data race in utilities used by
+	 * lockdep.
+	 */
+	lockdep_off();
+
 	kcsan_disable_current();
 	if (prepare_report(&flags, ptr, size, access_type, cpu_id, type)) {
 		if (print_report(ptr, size, access_type, value_change, cpu_id, type) && panic_on_warn)
@@ -418,4 +427,6 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		release_report(&flags, type);
 	}
 	kcsan_enable_current();
+
+	lockdep_on();
 }
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 45452facff3b..6d11cfb9b41f 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -5,6 +5,9 @@ KCOV_INSTRUMENT		:= n
 
 obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
 
+# Avoid recursion lockdep -> KCSAN -> ... -> lockdep.
+KCSAN_SANITIZE_lockdep.o := n
+
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_lockdep_proc.o = $(CC_FLAGS_FTRACE)
-- 
2.25.0.rc1.283.g88dfdc4193-goog

