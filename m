Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3D418FD18
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 19:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgCWSvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 14:51:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46946 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgCWSva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:51:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGSAZ-0013hH-7M; Mon, 23 Mar 2020 18:51:27 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 1/7] futex: arch_futex_atomic_op_inuser() calling conventions change
Date:   Mon, 23 Mar 2020 18:51:21 +0000
Message-Id: <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200323185057.GE23230@ZenIV.linux.org.uk>
References: <20200323185057.GE23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Move access_ok() in and pagefault_enable()/pagefault_disable() out.
Mechanical conversion only - some instances don't really need
a separate access_ok() at all (e.g. the ones only using
get_user()/put_user(), or architectures where access_ok()
is always true); we'll deal with that in followups.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/futex.h      | 5 ++---
 arch/arc/include/asm/futex.h        | 5 +++--
 arch/arm/include/asm/futex.h        | 5 +++--
 arch/arm64/include/asm/futex.h      | 5 ++---
 arch/hexagon/include/asm/futex.h    | 5 ++---
 arch/ia64/include/asm/futex.h       | 5 ++---
 arch/microblaze/include/asm/futex.h | 5 ++---
 arch/mips/include/asm/futex.h       | 5 ++---
 arch/nds32/include/asm/futex.h      | 6 ++----
 arch/openrisc/include/asm/futex.h   | 5 ++---
 arch/parisc/include/asm/futex.h     | 5 +++--
 arch/powerpc/include/asm/futex.h    | 5 ++---
 arch/riscv/include/asm/futex.h      | 5 ++---
 arch/s390/include/asm/futex.h       | 4 ++--
 arch/sh/include/asm/futex.h         | 5 ++---
 arch/sparc/include/asm/futex_64.h   | 6 ++----
 arch/x86/include/asm/futex.h        | 5 ++---
 arch/xtensa/include/asm/futex.h     | 5 ++---
 include/asm-generic/futex.h         | 4 ++--
 kernel/futex.c                      | 5 ++---
 20 files changed, 43 insertions(+), 57 deletions(-)

diff --git a/arch/alpha/include/asm/futex.h b/arch/alpha/include/asm/futex.h
index bfd3c01038f8..da67afd578fd 100644
--- a/arch/alpha/include/asm/futex.h
+++ b/arch/alpha/include/asm/futex.h
@@ -31,7 +31,8 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -53,8 +54,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/arc/include/asm/futex.h b/arch/arc/include/asm/futex.h
index 9d0d070e6c22..607d1c16d4dd 100644
--- a/arch/arc/include/asm/futex.h
+++ b/arch/arc/include/asm/futex.h
@@ -75,10 +75,12 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
 #ifndef CONFIG_ARC_HAS_LLSC
 	preempt_disable();	/* to guarantee atomic r-m-w of futex op */
 #endif
-	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -101,7 +103,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
 #ifndef CONFIG_ARC_HAS_LLSC
 	preempt_enable();
 #endif
diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 83c391b597d4..e133da303a98 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -134,10 +134,12 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret, tmp;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
 #ifndef CONFIG_SMP
 	preempt_disable();
 #endif
-	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -159,7 +161,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
 #ifndef CONFIG_SMP
 	preempt_enable();
 #endif
diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index 6cc26a127819..97f6a63810ec 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -48,7 +48,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 	int oldval = 0, ret, tmp;
 	u32 __user *uaddr = __uaccess_mask_ptr(_uaddr);
 
-	pagefault_disable();
+	if (!access_ok(_uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -75,8 +76,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/hexagon/include/asm/futex.h b/arch/hexagon/include/asm/futex.h
index 0191f7c7193e..6b9c554aee78 100644
--- a/arch/hexagon/include/asm/futex.h
+++ b/arch/hexagon/include/asm/futex.h
@@ -36,7 +36,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -62,8 +63,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/ia64/include/asm/futex.h b/arch/ia64/include/asm/futex.h
index 2e106d462196..1db26b432d8c 100644
--- a/arch/ia64/include/asm/futex.h
+++ b/arch/ia64/include/asm/futex.h
@@ -50,7 +50,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -74,8 +75,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/microblaze/include/asm/futex.h b/arch/microblaze/include/asm/futex.h
index 8c90357e5983..86131ed84c9a 100644
--- a/arch/microblaze/include/asm/futex.h
+++ b/arch/microblaze/include/asm/futex.h
@@ -34,7 +34,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -56,8 +57,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index 110220705e97..2bf8f6014579 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -89,7 +89,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -116,8 +117,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/nds32/include/asm/futex.h b/arch/nds32/include/asm/futex.h
index 5213c65c2e0b..4223f473bd36 100644
--- a/arch/nds32/include/asm/futex.h
+++ b/arch/nds32/include/asm/futex.h
@@ -66,8 +66,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 	switch (op) {
 	case FUTEX_OP_SET:
 		__futex_atomic_op("move	%0, %3", ret, oldval, tmp, uaddr,
@@ -93,8 +93,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/openrisc/include/asm/futex.h b/arch/openrisc/include/asm/futex.h
index fe894e6331ae..865e9cd0d97b 100644
--- a/arch/openrisc/include/asm/futex.h
+++ b/arch/openrisc/include/asm/futex.h
@@ -35,7 +35,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -57,8 +58,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/parisc/include/asm/futex.h b/arch/parisc/include/asm/futex.h
index d2c3e4106851..c10cc9010cc1 100644
--- a/arch/parisc/include/asm/futex.h
+++ b/arch/parisc/include/asm/futex.h
@@ -39,8 +39,10 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 	int oldval, ret;
 	u32 tmp;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
 	_futex_spin_lock_irqsave(uaddr, &flags);
-	pagefault_disable();
 
 	ret = -EFAULT;
 	if (unlikely(get_user(oldval, uaddr) != 0))
@@ -73,7 +75,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -EFAULT;
 
 out_pagefault_enable:
-	pagefault_enable();
 	_futex_spin_unlock_irqrestore(uaddr, &flags);
 
 	if (!ret)
diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index bc7d9d06a6d9..f187bb5e524e 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -35,8 +35,9 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 	allow_read_write_user(uaddr, uaddr, sizeof(*uaddr));
-	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -58,8 +59,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	*oval = oldval;
 
 	prevent_read_write_user(uaddr, uaddr, sizeof(*uaddr));
diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
index fdfaf7f3df7c..1b00badb9f87 100644
--- a/arch/riscv/include/asm/futex.h
+++ b/arch/riscv/include/asm/futex.h
@@ -46,7 +46,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret = 0;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -73,8 +74,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/s390/include/asm/futex.h b/arch/s390/include/asm/futex.h
index 5e97a4353147..ed965c3ecd5b 100644
--- a/arch/s390/include/asm/futex.h
+++ b/arch/s390/include/asm/futex.h
@@ -28,8 +28,9 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	int oldval = 0, newval, ret;
 	mm_segment_t old_fs;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 	old_fs = enable_sacf_uaccess();
-	pagefault_disable();
 	switch (op) {
 	case FUTEX_OP_SET:
 		__futex_atomic_op("lr %2,%5\n",
@@ -54,7 +55,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	default:
 		ret = -ENOSYS;
 	}
-	pagefault_enable();
 	disable_sacf_uaccess(old_fs);
 
 	if (!ret)
diff --git a/arch/sh/include/asm/futex.h b/arch/sh/include/asm/futex.h
index 3190ec89df81..324fa680b13d 100644
--- a/arch/sh/include/asm/futex.h
+++ b/arch/sh/include/asm/futex.h
@@ -34,7 +34,8 @@ static inline int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval,
 	u32 oldval, newval, prev;
 	int ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	do {
 		ret = get_user(oldval, uaddr);
@@ -67,8 +68,6 @@ static inline int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval,
 		ret = futex_atomic_cmpxchg_inatomic(&prev, uaddr, oldval, newval);
 	} while (!ret && prev != oldval);
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/sparc/include/asm/futex_64.h b/arch/sparc/include/asm/futex_64.h
index 0865ce77ec00..84fffaaf59d3 100644
--- a/arch/sparc/include/asm/futex_64.h
+++ b/arch/sparc/include/asm/futex_64.h
@@ -35,11 +35,11 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret, tem;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 	if (unlikely((((unsigned long) uaddr) & 0x3UL)))
 		return -EINVAL;
 
-	pagefault_disable();
-
 	switch (op) {
 	case FUTEX_OP_SET:
 		__futex_cas_op("mov\t%4, %1", ret, oldval, uaddr, oparg);
@@ -60,8 +60,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 13c83fe97988..6bcd1c1486d9 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -47,7 +47,8 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret, tem;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -70,8 +71,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/xtensa/include/asm/futex.h b/arch/xtensa/include/asm/futex.h
index 964611083224..a1a27b2ea460 100644
--- a/arch/xtensa/include/asm/futex.h
+++ b/arch/xtensa/include/asm/futex.h
@@ -72,7 +72,8 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 #if XCHAL_HAVE_S32C1I || XCHAL_HAVE_EXCLUSIVE
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -99,8 +100,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 02970b11f71f..3eab7ba912fc 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -33,8 +33,9 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 	int oldval, ret;
 	u32 tmp;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 	preempt_disable();
-	pagefault_disable();
 
 	ret = -EFAULT;
 	if (unlikely(get_user(oldval, uaddr) != 0))
@@ -67,7 +68,6 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 		ret = -EFAULT;
 
 out_pagefault_enable:
-	pagefault_enable();
 	preempt_enable();
 
 	if (ret == 0)
diff --git a/kernel/futex.c b/kernel/futex.c
index 0cf84c8664f2..7fdd2c949487 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1723,10 +1723,9 @@ static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 		oparg = 1 << oparg;
 	}
 
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
-
+	pagefault_disable();
 	ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
+	pagefault_enable();
 	if (ret)
 		return ret;
 
-- 
2.11.0

