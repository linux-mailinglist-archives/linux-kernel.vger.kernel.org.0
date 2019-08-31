Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B69A43F1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 12:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfHaKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 06:18:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32223 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbfHaKSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:18:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46LC3s31ZCz9v4gS;
        Sat, 31 Aug 2019 12:18:33 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eZZSlZdP; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id deq8ZgDXduOA; Sat, 31 Aug 2019 12:18:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46LC3s1vD3z9v4gL;
        Sat, 31 Aug 2019 12:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567246713; bh=RYjTP7J+hB9IO8EDu3SSSumPjtG9GQx/FRyyaBydiUE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=eZZSlZdPT3if0Ns0zZkRKkQSFtoGHbHJc7RcwcQTV+753VBYQVAUoFx4bs1ITxHQK
         v6BvGxvjPch5U8dJHA2IuIYym0o1/S8qeVW8YLEreuQ5HBlQi23IvAZz9T5dHd7vEj
         pM5JNPV5Y4DInWcaSmc6V+O3xDgJIHx/sZloVuNo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A2BC8B7B9;
        Sat, 31 Aug 2019 12:18:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7c0s5q7ClPS7; Sat, 31 Aug 2019 12:18:34 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 55F038B789;
        Sat, 31 Aug 2019 12:18:34 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1BDA56985C; Sat, 31 Aug 2019 10:18:34 +0000 (UTC)
Message-Id: <ef929144c8fa270fb92eeb1de8b7b0577e1553f1.1567245405.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1567245404.git.christophe.leroy@c-s.fr>
References: <cover.1567245404.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 09/10] powerpc: align stack to 2 * THREAD_SIZE with
 VMAP_STACK
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 31 Aug 2019 10:18:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ease stack overflow detection, align
stack to 2 * THREAD_SIZE when using VMAP_STACK.
This allow overflow detection using a single bit check.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/thread_info.h | 13 +++++++++++++
 arch/powerpc/kernel/setup_32.c         |  2 +-
 arch/powerpc/kernel/setup_64.c         |  2 +-
 arch/powerpc/kernel/vmlinux.lds.S      |  2 +-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 488d5c4670ff..a2270749b282 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -22,6 +22,19 @@
 
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
+/*
+ * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
+ * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
+ * assembly.
+ */
+#ifdef CONFIG_VMAP_STACK
+#define THREAD_ALIGN_SHIFT	(THREAD_SHIFT + 1)
+#else
+#define THREAD_ALIGN_SHIFT	THREAD_SHIFT
+#endif
+
+#define THREAD_ALIGN		(1 << THREAD_ALIGN_SHIFT)
+
 #ifndef __ASSEMBLY__
 #include <linux/cache.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 94517e4a2723..ab0a9d6e3745 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -137,7 +137,7 @@ arch_initcall(ppc_init);
 
 static void *__init alloc_stack(void)
 {
-	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
+	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_ALIGN);
 
 	if (!ptr)
 		panic("cannot allocate %d bytes for stack at %pS\n",
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 44b4c432a273..f630fe4d36a8 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -644,7 +644,7 @@ static void *__init alloc_stack(unsigned long limit, int cpu)
 
 	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
 
-	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_SIZE,
+	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_ALIGN,
 				     MEMBLOCK_LOW_LIMIT, limit,
 				     early_cpu_to_node(cpu));
 	if (!ptr)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 060a1acd7c6d..d38335129c06 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -346,7 +346,7 @@ SECTIONS
 #endif
 
 	/* The initial task and kernel stack */
-	INIT_TASK_DATA_SECTION(THREAD_SIZE)
+	INIT_TASK_DATA_SECTION(THREAD_ALIGN)
 
 	.data..page_aligned : AT(ADDR(.data..page_aligned) - LOAD_OFFSET) {
 		PAGE_ALIGNED_DATA(PAGE_SIZE)
-- 
2.13.3

