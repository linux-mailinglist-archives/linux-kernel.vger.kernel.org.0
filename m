Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3CE1158FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 23:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfLFWOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 17:14:11 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:44634 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLFWOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:14:09 -0500
Received: by mail-pj1-f73.google.com with SMTP id m20so4335891pjn.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FMhmbhjj+jlhlGOIJevuL9+5dok3NSGwTiDcKrJ6WaM=;
        b=T10VjxXldfSsUXZpdI0G9ZatVECfZiubpqxIgjHBe18vbfvPE8Kw2zm/cP2p5npgfl
         4fxbv0dJ2kPnx7vyVNtmDiNLeNShVc0SGKtjL2NThHRUdYPKplWdrBkC1jawy6cqFlnT
         U1nf8oinF9mLpc4vLzXdmbceF8348PdrZIGztQjVHesOdnTmapYS/8BvsmnzrftgzleW
         z8oLDFx97oFzY/JpwoIkmx1KBZQT8eV09q1Y9hagTP5dffyCBQrBerPuV1Pegq4iyYDP
         xiQ4oYNQdAjeowb0gba8Fy9//zrJVt17RkJ4Mz9yi0CoVv+NrmjmRqRXZO4Cfm2HPbSq
         g+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FMhmbhjj+jlhlGOIJevuL9+5dok3NSGwTiDcKrJ6WaM=;
        b=ejnQfkVPZOdupL0BZCbSmWp/7nvyyNSB7n437J1wtsBy7a2OQz/CL9SR0SmI2Yq8Vn
         Z+INnZzVA/xd2XJH0iL7vMQSr6EgCCQAAG64mOGGbYghzbhxF8+zc7KM1Ambqx07yfJv
         wW10Q7qtf5unZkO8X7eEXHE+UHQyhuCtawbw1OEAMFQDfu2e55q2dIyB9BC6Lapgqcp+
         iikCo9DwwHEC7TVlYAgfjb9nT0D0w0vBUYPnIQaELIrkZIZ1CIp5PZ/BST3tVEQ8jf05
         2JJ1FLwpqr1nAYuioyGQcfs2NRK4xoRMB3Fp0O2hzMzZwEQPwaKOIwEfwV+hZA19/Rfb
         4TrQ==
X-Gm-Message-State: APjAAAWsDY3wxLCUkEGBiqln/yjA471iMoyxh0wyDNHic5mlXZMfjtP4
        CSZqxehLegFdGosCUGlDMFrDk2g6Bv0l2LwaXgk=
X-Google-Smtp-Source: APXvYqwGu9BzVzkTOEUjboJwACNSqyWsIuW/Lz9sm1DFyWdywR4ueC8vPNMAtG8rMfeEabCrSGyLK8YlbM6USAq6cgg=
X-Received: by 2002:a63:215d:: with SMTP id s29mr5512170pgm.200.1575670448781;
 Fri, 06 Dec 2019 14:14:08 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:13:41 -0800
In-Reply-To: <20191206221351.38241-1-samitolvanen@google.com>
Message-Id: <20191206221351.38241-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191206221351.38241-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 05/15] add support for Clang's Shadow Call Stack (SCS)
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds generic support for Clang's Shadow Call Stack,
which uses a shadow stack to protect return addresses from being
overwritten by an attacker. Details are available here:

  https://clang.llvm.org/docs/ShadowCallStack.html

Note that security guarantees in the kernel differ from the
ones documented for user space. The kernel must store addresses
of shadow stacks used by other tasks and interrupt handlers in
memory, which means an attacker capable reading and writing
arbitrary memory may be able to locate them and hijack control
flow by modifying shadow stacks that are not currently in use.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 Makefile                       |   6 ++
 arch/Kconfig                   |  34 ++++++
 include/linux/compiler-clang.h |   6 ++
 include/linux/compiler_types.h |   4 +
 include/linux/scs.h            |  57 ++++++++++
 init/init_task.c               |   8 ++
 kernel/Makefile                |   1 +
 kernel/fork.c                  |   9 ++
 kernel/sched/core.c            |   2 +
 kernel/scs.c                   | 187 +++++++++++++++++++++++++++++++++
 10 files changed, 314 insertions(+)
 create mode 100644 include/linux/scs.h
 create mode 100644 kernel/scs.c

diff --git a/Makefile b/Makefile
index 999a197d67d2..1b76c1ea2a02 100644
--- a/Makefile
+++ b/Makefile
@@ -845,6 +845,12 @@ ifdef CONFIG_LIVEPATCH
 KBUILD_CFLAGS += $(call cc-option, -flive-patching=inline-clone)
 endif
 
+ifdef CONFIG_SHADOW_CALL_STACK
+CC_FLAGS_SCS	:= -fsanitize=shadow-call-stack
+KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
+export CC_FLAGS_SCS
+endif
+
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 48b5e103bdb0..1b16aa9a3fe5 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -521,6 +521,40 @@ config STACKPROTECTOR_STRONG
 	  about 20% of all kernel functions, which increases the kernel code
 	  size by about 2%.
 
+config ARCH_SUPPORTS_SHADOW_CALL_STACK
+	bool
+	help
+	  An architecture should select this if it supports Clang's Shadow
+	  Call Stack, has asm/scs.h, and implements runtime support for shadow
+	  stack switching.
+
+config SHADOW_CALL_STACK
+	bool "Clang Shadow Call Stack"
+	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
+	help
+	  This option enables Clang's Shadow Call Stack, which uses a
+	  shadow stack to protect function return addresses from being
+	  overwritten by an attacker. More information can be found from
+	  Clang's documentation:
+
+	    https://clang.llvm.org/docs/ShadowCallStack.html
+
+	  Note that security guarantees in the kernel differ from the ones
+	  documented for user space. The kernel must store addresses of shadow
+	  stacks used by other tasks and interrupt handlers in memory, which
+	  means an attacker capable reading and writing arbitrary memory may
+	  be able to locate them and hijack control flow by modifying shadow
+	  stacks that are not currently in use.
+
+config SHADOW_CALL_STACK_VMAP
+	bool "Use virtually mapped shadow call stacks"
+	depends on SHADOW_CALL_STACK
+	help
+	  Use virtually mapped shadow call stacks. Selecting this option
+	  provides better stack exhaustion protection, but increases per-thread
+	  memory consumption as a full page is allocated for each shadow stack.
+
+
 config HAVE_ARCH_WITHIN_STACK_FRAMES
 	bool
 	help
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 333a6695a918..18fc4d29ef27 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -42,3 +42,9 @@
  * compilers, like ICC.
  */
 #define barrier() __asm__ __volatile__("" : : : "memory")
+
+#if __has_feature(shadow_call_stack)
+# define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
+#else
+# define __noscs
+#endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 72393a8c1a6c..be5d5be4b1ae 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -202,6 +202,10 @@ struct ftrace_likely_data {
 # define randomized_struct_fields_end
 #endif
 
+#ifndef __noscs
+# define __noscs
+#endif
+
 #ifndef asm_volatile_goto
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
diff --git a/include/linux/scs.h b/include/linux/scs.h
new file mode 100644
index 000000000000..c5572fd770b0
--- /dev/null
+++ b/include/linux/scs.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Shadow Call Stack support.
+ *
+ * Copyright (C) 2019 Google LLC
+ */
+
+#ifndef _LINUX_SCS_H
+#define _LINUX_SCS_H
+
+#include <linux/gfp.h>
+#include <linux/sched.h>
+#include <asm/page.h>
+
+#ifdef CONFIG_SHADOW_CALL_STACK
+
+/*
+ * In testing, 1 KiB shadow stack size (i.e. 128 stack frames on a 64-bit
+ * architecture) provided ~40% safety margin on stack usage while keeping
+ * memory allocation overhead reasonable.
+ */
+#define SCS_SIZE	1024UL
+#define GFP_SCS		(GFP_KERNEL | __GFP_ZERO)
+
+/*
+ * A random number outside the kernel's virtual address space to mark the
+ * end of the shadow stack.
+ */
+#define SCS_END_MAGIC	0xaf0194819b1635f6UL
+
+#define task_scs(tsk)	(task_thread_info(tsk)->shadow_call_stack)
+
+static inline void task_set_scs(struct task_struct *tsk, void *s)
+{
+	task_scs(tsk) = s;
+}
+
+extern void scs_init(void);
+extern void scs_task_reset(struct task_struct *tsk);
+extern int scs_prepare(struct task_struct *tsk, int node);
+extern bool scs_corrupted(struct task_struct *tsk);
+extern void scs_release(struct task_struct *tsk);
+
+#else /* CONFIG_SHADOW_CALL_STACK */
+
+#define task_scs(tsk)	NULL
+
+static inline void task_set_scs(struct task_struct *tsk, void *s) {}
+static inline void scs_init(void) {}
+static inline void scs_task_reset(struct task_struct *tsk) {}
+static inline int scs_prepare(struct task_struct *tsk, int node) { return 0; }
+static inline bool scs_corrupted(struct task_struct *tsk) { return false; }
+static inline void scs_release(struct task_struct *tsk) {}
+
+#endif /* CONFIG_SHADOW_CALL_STACK */
+
+#endif /* _LINUX_SCS_H */
diff --git a/init/init_task.c b/init/init_task.c
index 9e5cbe5eab7b..cbd40460e903 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/audit.h>
 #include <linux/numa.h>
+#include <linux/scs.h>
 
 #include <asm/pgtable.h>
 #include <linux/uaccess.h>
@@ -184,6 +185,13 @@ struct task_struct init_task
 };
 EXPORT_SYMBOL(init_task);
 
+#ifdef CONFIG_SHADOW_CALL_STACK
+unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)] __init_task_data
+		__aligned(SCS_SIZE) = {
+	[(SCS_SIZE / sizeof(long)) - 1] = SCS_END_MAGIC
+};
+#endif
+
 /*
  * Initial thread structure. Alignment of this is handled by a special
  * linker map entry.
diff --git a/kernel/Makefile b/kernel/Makefile
index f2cc0d118a0b..06231f936a7a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
 obj-$(CONFIG_IRQ_WORK) += irq_work.o
 obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
+obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 2508a4f238a3..bf52528f9b36 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
 #include <linux/kasan.h>
+#include <linux/scs.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -454,6 +455,8 @@ void put_task_stack(struct task_struct *tsk)
 
 void free_task(struct task_struct *tsk)
 {
+	scs_release(tsk);
+
 #ifndef CONFIG_THREAD_INFO_IN_TASK
 	/*
 	 * The task is finally done with both the stack and thread_info,
@@ -837,6 +840,8 @@ void __init fork_init(void)
 			  NULL, free_vm_stack_cache);
 #endif
 
+	scs_init();
+
 	lockdep_init_task(&init_task);
 	uprobes_init();
 }
@@ -896,6 +901,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (err)
 		goto free_stack;
 
+	err = scs_prepare(tsk, node);
+	if (err)
+		goto free_stack;
+
 #ifdef CONFIG_SECCOMP
 	/*
 	 * We must handle setting up seccomp filters once we're under
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..a181c536e12e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11,6 +11,7 @@
 #include <linux/nospec.h>
 
 #include <linux/kcov.h>
+#include <linux/scs.h>
 
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
@@ -6038,6 +6039,7 @@ void init_idle(struct task_struct *idle, int cpu)
 	idle->se.exec_start = sched_clock();
 	idle->flags |= PF_IDLE;
 
+	scs_task_reset(idle);
 	kasan_unpoison_task_stack(idle);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/scs.c b/kernel/scs.c
new file mode 100644
index 000000000000..28abed21950c
--- /dev/null
+++ b/kernel/scs.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Shadow Call Stack support.
+ *
+ * Copyright (C) 2019 Google LLC
+ */
+
+#include <linux/cpuhotplug.h>
+#include <linux/kasan.h>
+#include <linux/mm.h>
+#include <linux/mmzone.h>
+#include <linux/scs.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <asm/scs.h>
+
+static inline void *__scs_base(struct task_struct *tsk)
+{
+	/*
+	 * To minimize risk the of exposure, architectures may clear a
+	 * task's thread_info::shadow_call_stack while that task is
+	 * running, and only save/restore the active shadow call stack
+	 * pointer when the usual register may be clobbered (e.g. across
+	 * context switches).
+	 *
+	 * The shadow call stack is aligned to SCS_SIZE, and grows
+	 * upwards, so we can mask out the low bits to extract the base
+	 * when the task is not running.
+	 */
+	return (void *)((unsigned long)task_scs(tsk) & ~(SCS_SIZE - 1));
+}
+
+static inline unsigned long *scs_magic(void *s)
+{
+	return (unsigned long *)(s + SCS_SIZE) - 1;
+}
+
+static inline void scs_set_magic(void *s)
+{
+	*scs_magic(s) = SCS_END_MAGIC;
+}
+
+#ifdef CONFIG_SHADOW_CALL_STACK_VMAP
+
+/* Matches NR_CACHED_STACKS for VMAP_STACK */
+#define NR_CACHED_SCS 2
+static DEFINE_PER_CPU(void *, scs_cache[NR_CACHED_SCS]);
+
+static void *scs_alloc(int node)
+{
+	int i;
+	void *s;
+
+	for (i = 0; i < NR_CACHED_SCS; i++) {
+		s = this_cpu_xchg(scs_cache[i], NULL);
+		if (s) {
+			memset(s, 0, SCS_SIZE);
+			goto out;
+		}
+	}
+
+	/*
+	 * We allocate a full page for the shadow stack, which should be
+	 * more than we need. Check the assumption nevertheless.
+	 */
+	BUILD_BUG_ON(SCS_SIZE > PAGE_SIZE);
+
+	s = __vmalloc_node_range(PAGE_SIZE, SCS_SIZE,
+				 VMALLOC_START, VMALLOC_END,
+				 GFP_SCS, PAGE_KERNEL, 0,
+				 node, __builtin_return_address(0));
+
+out:
+	if (s)
+		scs_set_magic(s);
+	/* TODO: poison for KASAN, unpoison in scs_free */
+
+	return s;
+}
+
+static void scs_free(void *s)
+{
+	int i;
+
+	for (i = 0; i < NR_CACHED_SCS; i++)
+		if (this_cpu_cmpxchg(scs_cache[i], 0, s) == NULL)
+			return;
+
+	vfree_atomic(s);
+}
+
+static int scs_cleanup(unsigned int cpu)
+{
+	int i;
+	void **cache = per_cpu_ptr(scs_cache, cpu);
+
+	for (i = 0; i < NR_CACHED_SCS; i++) {
+		vfree(cache[i]);
+		cache[i] = NULL;
+	}
+
+	return 0;
+}
+
+void __init scs_init(void)
+{
+	WARN_ON(cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "scs:scs_cache", NULL,
+			scs_cleanup) < 0);
+}
+
+#else /* !CONFIG_SHADOW_CALL_STACK_VMAP */
+
+static struct kmem_cache *scs_cache;
+
+static inline void *scs_alloc(int node)
+{
+	void *s;
+
+	s = kmem_cache_alloc_node(scs_cache, GFP_SCS, node);
+	if (s) {
+		scs_set_magic(s);
+		/*
+		 * Poison the allocation to catch unintentional accesses to
+		 * the shadow stack when KASAN is enabled.
+		 */
+		kasan_poison_object_data(scs_cache, s);
+	}
+
+	return s;
+}
+
+static inline void scs_free(void *s)
+{
+	kasan_unpoison_object_data(scs_cache, s);
+	kmem_cache_free(scs_cache, s);
+}
+
+void __init scs_init(void)
+{
+	scs_cache = kmem_cache_create("scs_cache", SCS_SIZE, SCS_SIZE,
+				0, NULL);
+	WARN_ON(!scs_cache);
+}
+
+#endif /* CONFIG_SHADOW_CALL_STACK_VMAP */
+
+void scs_task_reset(struct task_struct *tsk)
+{
+	/*
+	 * Reset the shadow stack to the base address in case the task
+	 * is reused.
+	 */
+	task_set_scs(tsk, __scs_base(tsk));
+}
+
+int scs_prepare(struct task_struct *tsk, int node)
+{
+	void *s;
+
+	s = scs_alloc(node);
+	if (!s)
+		return -ENOMEM;
+
+	task_set_scs(tsk, s);
+	return 0;
+}
+
+bool scs_corrupted(struct task_struct *tsk)
+{
+	unsigned long *magic = scs_magic(__scs_base(tsk));
+
+	return READ_ONCE_NOCHECK(*magic) != SCS_END_MAGIC;
+}
+
+void scs_release(struct task_struct *tsk)
+{
+	void *s;
+
+	s = __scs_base(tsk);
+	if (!s)
+		return;
+
+	WARN_ON(scs_corrupted(tsk));
+
+	task_set_scs(tsk, NULL);
+	scs_free(s);
+}
-- 
2.24.0.393.g34dc348eaf-goog

