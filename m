Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0CF1A655
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 04:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfEKCpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 22:45:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43490 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfEKCpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 22:45:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so3641053plp.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 19:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CUhieZT0dq5rcd5b29lcRTRSzr7B/fdAZIYRAG+rlxc=;
        b=dTJvZ8PS9v/siftLtfLjQbs/FaE3xhuMDqnw7wS+gx2inhE1SUu55zBvSWG1aGUpss
         Le3KhgSgde33C3uvPvYuoevWaRWl1JsKxUJwdNVUGVH/y5PC8Es4vSyYwPfTYPrFrp5E
         YK6By8TpbHi0bE3rZkqoOEXyfa++0qN7kkYWeAwbn6jW25uol6WUAZa/wIFhhVgR0sHn
         tMniLHk1pFKl5CdzTClF4sD4od+zS4SrIWT+FlSkxJTTHZOuhEgaH5ouKgouTbZKLmPV
         QOUaHINeH12jQi4n00+LNqGb0r6FwVL63pT/JjIw0Oymr8S3E4n0qLuHXg5Es32BwDOH
         fVsQ==
X-Gm-Message-State: APjAAAWzE5WF8hqd1zrFYnraUOOOSOvb8fslLHDhagriMAvbVkvPCl3s
        hTyc3UxG1YJB6kc7Xfd45nI=
X-Google-Smtp-Source: APXvYqxp1K4iU/ON2cJ6j+tKaGWVLHCtTYWfoZCTJvZOQ5tP0tANYRmjMOaNdKB/0ihulqsMK+4LIw==
X-Received: by 2002:a17:902:5acb:: with SMTP id g11mr16470578plm.198.1557542710850;
        Fri, 10 May 2019 19:45:10 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e123sm993191pgc.29.2019.05.10.19.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 19:45:09 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirsky <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>
Subject: [RFC] x86: Speculative execution warnings
Date:   Fri, 10 May 2019 12:25:14 -0700
Message-Id: <20190510192514.19301-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may be useful to check in runtime whether certain assertions are
violated even during speculative execution. This can allow to avoid
adding unnecessary memory fences and at the same time check that no data
leak channels exist.

For example, adding such checks can show that allocating zeroed pages
can return speculatively non-zeroed pages (the first qword is not
zero).  [This might be a problem when the page-fault handler performs
software page-walk, for example.]

Introduce SPEC_WARN_ON(), which checks in runtime whether a certain
condition is violated during speculative execution. The condition should
be computed without branches, e.g., using bitwise operators. The check
will wait for the condition to be realized (i.e., not speculated), and
if the assertion is violated, a warning will be thrown.

Warnings can be provided in one of two modes: precise and imprecise.
Both mode are not perfect. The precise mode does not always make it easy
to understand which assertion was broken, but instead points to a point
in the execution somewhere around the point in which the assertion was
violated.  In addition, it prints a warning for each violation (unlike
WARN_ONCE() like behavior).

The imprecise mode, on the other hand, can sometimes throw the wrong
indication, specifically if the control flow has changed between the
speculative execution and the actual one. Note that it is not a
false-positive, it just means that the output would mislead the user to
think the wrong assertion was broken.

There are some more limitations. Since the mechanism requires an
indirect branch, it should not be used in production systems that are
susceptible for Spectre v2. The mechanism requires TSX and performance
counters that are only available in skylake+. There is a hidden
assumption that TSX is not used in the kernel for anything else, other
than this mechanism.

The basic idea behind the implementation is to use a performance counter
that updates also during speculative execution as an indication for
assertion failure. By using conditional-mov, which is not predicted,
to affect the control flow, the condition is realized before the event
that affects the PMU is triggered.

Enable this feature by setting "spec_warn=on" or "spec_warn=precise"
kernel parameter. I did not run performance numbers but I guess the
overhead should not be too high.

I did not run too many tests, but brief experiments suggest that it does
work. Let me know if I missed anything and whether you think this can be
useful. To be frank, the exact use cases are not super clear, and there
are various possible extensions (e.g., ensuring the speculation window
is long enough by adding data dependencies). I would appreciate your
inputs.

Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/Kconfig                     |   4 +
 arch/x86/include/asm/nospec-branch.h |  30 +++++
 arch/x86/kernel/Makefile             |   1 +
 arch/x86/kernel/nospec.c             | 185 +++++++++++++++++++++++++++
 4 files changed, 220 insertions(+)
 create mode 100644 arch/x86/kernel/nospec.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 62fc3fda1a05..2cc57c2172be 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2887,6 +2887,10 @@ config X86_DMA_REMAP
 config HAVE_GENERIC_GUP
 	def_bool y
 
+config DEBUG_SPECULATIVE_EXECUTION
+	bool "Debug speculative execution"
+	depends on X86_64
+
 source "drivers/firmware/Kconfig"
 
 source "arch/x86/kvm/Kconfig"
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index dad12b767ba0..3f1af6378304 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -290,6 +290,36 @@ static inline void indirect_branch_prediction_barrier(void)
 /* The Intel SPEC CTRL MSR base value cache */
 extern u64 x86_spec_ctrl_base;
 
+#ifdef CONFIG_DEBUG_SPECULATIVE_EXECUTION
+
+extern bool spec_check(unsigned long cond);
+
+DECLARE_STATIC_KEY_FALSE(spec_test_key);
+DECLARE_STATIC_KEY_FALSE(spec_test_precise_key);
+
+#define SPEC_WARN_ON(cond)						\
+do {									\
+	bool _error;							\
+									\
+	if (!static_branch_unlikely(&spec_test_key))			\
+		break;							\
+									\
+	_error = spec_check((unsigned long)(cond));			\
+									\
+	if (static_branch_unlikely(&spec_test_precise_key))		\
+		break;							\
+									\
+	WARN_ONCE(_error,						\
+		"Speculative execution assertion failed: (%s)\n",	\
+		__stringify(cond));					\
+} while (0)
+
+#else
+
+#define SPEC_BUG_ON(cond)	BUILD_BUG_ON_INVALID(cond)
+
+#endif
+
 /*
  * With retpoline, we must use IBRS to restrict branch prediction
  * before calling into firmware.
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 00b7e27bc2b7..63a3a1420f8e 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -139,6 +139,7 @@ obj-$(CONFIG_X86_INTEL_UMIP)		+= umip.o
 obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
+obj-y					+= nospec.o
 
 ###
 # 64 bit specific files
diff --git a/arch/x86/kernel/nospec.c b/arch/x86/kernel/nospec.c
new file mode 100644
index 000000000000..9e0711d34543
--- /dev/null
+++ b/arch/x86/kernel/nospec.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+#include <linux/perf_event.h>
+
+#include <asm/cmdline.h>
+
+#include "../events/perf_event.h"
+
+#ifdef CONFIG_DEBUG_SPECULATIVE_EXECUTION
+
+static struct perf_event_attr spec_event_attr = {
+	.type			= PERF_TYPE_RAW,
+	.size			= sizeof(struct perf_event_attr),
+	.config			= 0x15d,
+	.sample_freq		= 1,
+	.pinned			= 1,
+	.freq			= 1,
+	.exclude_user		= 1,
+};
+
+static DEFINE_PER_CPU(unsigned int, spec_warn_irq_count);
+
+DEFINE_STATIC_KEY_FALSE(spec_test_key);
+EXPORT_SYMBOL(spec_test_key);
+
+DEFINE_STATIC_KEY_FALSE(spec_test_precise_key);
+EXPORT_SYMBOL(spec_test_precise_key);
+
+static void spec_event_handler(struct perf_event *evt,
+		struct perf_sample_data *data, struct pt_regs *regs)
+{
+	unsigned int cnt;
+
+	/*
+	 * We need a barrier to prevent the xabort from being executed
+	 * speculatively.
+	 */
+
+	indirect_branch_prediction_barrier();
+
+	/*
+	 * Avoid false positives or wrong indications in the wrong spot due to
+	 * IRQs.
+	 */
+	cnt = this_cpu_read(irq_count);
+	this_cpu_write(spec_warn_irq_count, cnt);
+	if (!static_branch_unlikely(&spec_test_precise_key))
+		return;
+
+	WARN(1, "Speculative execution detected at ip=%lx\n", regs->ip);
+}
+
+static DEFINE_PER_CPU(struct perf_event *, spec_perf_event);
+
+void nop_func(void)
+{
+}
+
+void xabort_func(void)
+{
+	asm volatile ("xabort $1");
+}
+
+bool spec_check(unsigned long cond)
+{
+	bool error = false;
+
+	/*
+	 * Avoid mistakenly triggering more events inside the NMI handler. We
+	 * will assume that this condition can be resolved with speculation.
+	 */
+	if (in_nmi())
+		return 0;
+
+	preempt_disable();
+
+	/*
+	 * Run a transaction which would only trigger xabort if the condition
+	 * is true. This xabort is counted by the PMU and  will trigger an
+	 * interrupt. The conditional move prevents speculative evaluation of
+	 * the condition. The branch would not mistakenly be mispredicted later
+	 * to run xabort again, since we run IBPB in the nmi handler.
+	 *
+	 * The implementation is based on the assumption cmov's are not going
+	 * through prediction, which is a common assumption. It is based on
+	 * Intel SDM saying "Use the SETCC and CMOV instructions to eliminate
+	 * unpredictable conditional branches where possible".
+	 *
+	 * This code is susceptible to Spectre v2 attacks.
+	 */
+	asm volatile ("xbegin 1f\n\t"
+		      "movq nop_func, %%rax\n\t"
+		      "testq %[cond], %[cond]\n\t"
+		      "cmovnzq %[xabort_func], %%rax\n\t"
+		      ANNOTATE_RETPOLINE_SAFE
+		      "call *%%rax\n\t"
+		      "xend\n\t"
+		      "1:" : : [cond]"r"((u64)(cond)), [xabort_func]"r"(xabort_func) :
+				"memory", "rax");
+
+	/*
+	 * Prevent wrong alerts due to speculative events that happened in the
+	 * IRQ handler.
+	 */
+	if (likely(__this_cpu_read(spec_warn_irq_count) != __this_cpu_read(irq_count)))
+		goto out;
+
+	/* Check again with IRQs disabled to be sure we get a stable read. */
+	this_cpu_write(spec_warn_irq_count, -2);
+	error = true;
+out:
+	preempt_enable();
+	return error;
+}
+EXPORT_SYMBOL(spec_check);
+
+static int __init nospec_init(void)
+{
+	int cpu, len;
+	char buf[20];
+	bool precise, enable;
+
+	/* Check the TSX and PMU are supported */
+	if (!boot_cpu_has(X86_FEATURE_RTM) || !boot_cpu_has(X86_FEATURE_SPEC_CTRL)) {
+		pr_err("Speculative checks are not supported on this CPU");
+		return 0;
+	}
+
+	/*
+	 * Unlike their name indicates, precise warnings are actually
+	 * imprecise, in the sense that they do not provide the exact code that
+	 * caused the speculation failure. They are precise in the sense that
+	 * they are prevent scenarios that the wrong assertion will be assumed
+	 * to fail.  This might happen if speculatively a certain assertion
+	 * fails, but on the actual execution, this assertion does not fail.
+	 */
+	len = cmdline_find_option(boot_command_line, "spec_warn",  buf, sizeof(buf));
+
+	if (len < 0)
+		return 0;
+
+	precise = (len == 7 && !strncmp(buf, "precise", 7));
+	enable = (len == 2 && !strncmp(buf, "on", 2)) || precise;
+
+	if (!enable) {
+		pr_err("Invalid spec_warn argument (spec_warn=%s)", buf);
+		return 0;
+	}
+
+	/* Set impossible value in order not to trigger a warning */
+	for_each_online_cpu(cpu)
+		per_cpu(spec_warn_irq_count, cpu) = (unsigned int)-2;
+
+	if (precise)
+		static_key_enable(&spec_test_precise_key.key);
+
+	pr_info("Enabling %s speculative execution checks",
+			precise ? "precise" : "imprecise");
+
+	/*
+	 * For each CPU, set a performance counter to trigger a PMU interrupt
+	 * whenever an instruction that causes a transaction abort is executed.
+	 * These instruction will only be counted within a transaction.
+	 */
+	for_each_online_cpu(cpu) {
+		struct perf_event *evt =
+			perf_event_create_kernel_counter(&spec_event_attr, cpu,
+					NULL, &spec_event_handler, NULL);
+
+		if (!evt) {
+			pr_err("Failed to enable speculative checks");
+			break;
+		}
+
+		per_cpu(spec_perf_event, cpu) = evt;
+	}
+
+	static_key_enable(&spec_test_key.key);
+
+	return 0;
+}
+arch_initcall(nospec_init);
+
+#endif
-- 
2.19.1

