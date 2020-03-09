Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2FE17DA9D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 09:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgCIIW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 04:22:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33059 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgCIIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:22:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id n7so4504675pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUgPxjUbuZfwtdr/gn2mVzPVC5s6lk1ipDYoBiMhXl8=;
        b=kMXhmKUjjLuTmELTTBo2VSu+j5H+0yCyM/etwFY9KFEyI06KLuI5SOuJF4o0jIyhy1
         E+hNEFryXrxMvEvFIDUIQXKFcPQMBjSKEyu5zVEz9eP/UZTlo02MDIYxxeCjefKf9Mpz
         d2+inu7g+F0IvbvLCpjo82rktXLgY8EKKIHUVVKxVcD4AUemdwohaXfCIxzSy2SPzHb3
         2UfdVbjWLJIOCvJYKPbxBm0z+JW6f58FtkYv2HKU6nSGXvNshfVYz+YhvpN0eI1MowRo
         6eeokIqGQlrlIgCzEzVQJvU9OSrjSs1uK4sui+YQgJPWuRMie/4X9+b7mOYQfakI9MEl
         wzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUgPxjUbuZfwtdr/gn2mVzPVC5s6lk1ipDYoBiMhXl8=;
        b=UuDsSSe2bvtgQJg9J1hmnzm51cUM9Ib7R/ROYPK0I3+5Wd0lJ4CSsqwFRVZKFQTlh5
         F+QB8X+y5TW/hUs+AtKbDfbiDiWC0xaN7KsL8tUv1RrDvMQG+6e+iYToql/05mCaXSha
         s/Y2FwgiOIr6NFitrSWVyV7BpwQp7IsVK2dUDlRAWx+w7v9SmO+OX8lpOA7mATuUBIAk
         983+InSN3kFG5006/hJ5VKQOwasHDSuogsuKAYvaAnNBZrMfsp2D7/SAMq3/P0kqLQhF
         hMHMy9eskW+lqr8ipagSy8DMicAVF+gaOpghbCXlha9yaGI1fsbMhd2Wu15iETVwJnN7
         NINQ==
X-Gm-Message-State: ANhLgQ1m2uQDEchDxOR4ofUEbueqISxL5OzFsUpCS0Tc0KsS67MUqxdQ
        wCLZ2rYMkN5/HaDMul4xrj++Cg==
X-Google-Smtp-Source: ADFU+vvWldbxBUJVZjNo3MZvwwVUc0e56Ke+qyKeIFd/Xff4hPsQhVXqcSZfRxRIgLhE/pts7VP3Ew==
X-Received: by 2002:a63:2c50:: with SMTP id s77mr14822444pgs.182.1583742173481;
        Mon, 09 Mar 2020 01:22:53 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id v5sm18364779pfn.64.2020.03.09.01.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 01:22:52 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 8/9] riscv: introduce interfaces to patch kernel code
Date:   Mon,  9 Mar 2020 16:22:28 +0800
Message-Id: <e2a42afbce47b364bf790b4cf8edf76235e48d53.1583741997.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583741997.git.zong.li@sifive.com>
References: <cover.1583741997.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On strict kernel memory permission, we couldn't patch code without
writable permission. Preserve two holes in fixmap area, so we can map
the kernel code temporarily to fixmap area, then patch the instructions.

We need two pages here because we support the compressed instruction, so
the instruction might be align to 2 bytes. When patching the 32-bit
length instruction which is 2 bytes alignment, it will across two pages.

Introduce two interfaces to patch kernel code:
riscv_patch_text_nosync:
 - patch code without synchronization, it's caller's responsibility to
   synchronize all CPUs if needed.
riscv_patch_text:
 - patch code and always synchronize with stop_machine()

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/include/asm/fixmap.h |   2 +
 arch/riscv/include/asm/patch.h  |  12 ++++
 arch/riscv/kernel/Makefile      |   4 +-
 arch/riscv/kernel/patch.c       | 124 ++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/patch.h
 create mode 100644 arch/riscv/kernel/patch.c

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 42d2c42f3cc9..2368d49eb4ef 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -27,6 +27,8 @@ enum fixed_addresses {
 	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
 	FIX_PTE,
 	FIX_PMD,
+	FIX_TEXT_POKE1,
+	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
 	__end_of_fixed_addresses
 };
diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
new file mode 100644
index 000000000000..b5918a6e0615
--- /dev/null
+++ b/arch/riscv/include/asm/patch.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 SiFive
+ */
+
+#ifndef _ASM_RISCV_PATCH_H
+#define _ASM_RISCV_PATCH_H
+
+int riscv_patch_text_nosync(void *addr, const void *insns, size_t len);
+int riscv_patch_text(void *addr, u32 insn);
+
+#endif /* _ASM_RISCV_PATCH_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f40205cb9a22..d189bd3d8501 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -4,7 +4,8 @@
 #
 
 ifdef CONFIG_FTRACE
-CFLAGS_REMOVE_ftrace.o = -pg
+CFLAGS_REMOVE_ftrace.o	= -pg
+CFLAGS_REMOVE_patch.o	= -pg
 endif
 
 extra-y += head.o
@@ -26,6 +27,7 @@ obj-y	+= traps.o
 obj-y	+= riscv_ksyms.o
 obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
+obj-y	+= patch.o
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_M_MODE)	+= clint.o
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
new file mode 100644
index 000000000000..1c61a8595839
--- /dev/null
+++ b/arch/riscv/kernel/patch.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 SiFive
+ */
+
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/uaccess.h>
+#include <linux/stop_machine.h>
+#include <asm/kprobes.h>
+#include <asm/cacheflush.h>
+#include <asm/fixmap.h>
+
+struct riscv_insn_patch {
+	void *addr;
+	u32 insn;
+	atomic_t cpu_count;
+};
+
+#ifdef CONFIG_MMU
+static DEFINE_RAW_SPINLOCK(patch_lock);
+
+static void __kprobes *patch_map(void *addr, int fixmap)
+{
+	uintptr_t uintaddr = (uintptr_t) addr;
+	struct page *page;
+
+	if (core_kernel_text(uintaddr))
+		page = phys_to_page(__pa_symbol(addr));
+	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		page = vmalloc_to_page(addr);
+	else
+		return addr;
+
+	BUG_ON(!page);
+
+	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
+					 (uintaddr & ~PAGE_MASK));
+}
+
+static void __kprobes patch_unmap(int fixmap)
+{
+	clear_fixmap(fixmap);
+}
+#else
+static void __kprobes *patch_map(void *addr, int fixmap)
+{
+	return addr;
+}
+
+static void __kprobes patch_unmap(int fixmap)
+{
+}
+#endif /* CONFIG_MMU */
+
+static int __kprobes riscv_insn_write(void *addr, const void *insn, size_t len)
+{
+	void *waddr = addr;
+	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
+	unsigned long flags = 0;
+	int ret;
+
+	raw_spin_lock_irqsave(&patch_lock, flags);
+
+	if (across_pages)
+		patch_map(addr + len, FIX_TEXT_POKE1);
+
+	waddr = patch_map(addr, FIX_TEXT_POKE0);
+
+	ret = probe_kernel_write(waddr, insn, len);
+
+	patch_unmap(FIX_TEXT_POKE0);
+
+	if (across_pages)
+		patch_unmap(FIX_TEXT_POKE1);
+
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
+
+	return ret;
+}
+
+int __kprobes riscv_patch_text_nosync(void *addr, const void *insns, size_t len)
+{
+	u32 *tp = addr;
+	int ret;
+
+	ret = riscv_insn_write(tp, insns, len);
+
+	if (!ret)
+		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
+
+	return ret;
+}
+
+static int __kprobes riscv_patch_text_cb(void *data)
+{
+	struct riscv_insn_patch *patch = data;
+	int ret = 0;
+
+	if (atomic_inc_return(&patch->cpu_count) == 1) {
+		ret =
+		    riscv_patch_text_nosync(patch->addr, &patch->insn,
+					    GET_INSN_LENGTH(patch->insn));
+		atomic_inc(&patch->cpu_count);
+	} else {
+		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
+			cpu_relax();
+		smp_mb();
+	}
+
+	return ret;
+}
+
+int __kprobes riscv_patch_text(void *addr, u32 insn)
+{
+	struct riscv_insn_patch patch = {
+		.addr = addr,
+		.insn = insn,
+		.cpu_count = ATOMIC_INIT(0),
+	};
+
+	return stop_machine_cpuslocked(riscv_patch_text_cb,
+				       &patch, cpu_online_mask);
+}
-- 
2.25.1

