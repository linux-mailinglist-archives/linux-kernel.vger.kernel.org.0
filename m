Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2183E12882E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 09:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfLUIcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 03:32:35 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:45061 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfLUIca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:32:30 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47fzPm1XnZz9vBn0;
        Sat, 21 Dec 2019 09:32:28 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=GH8QhU59; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id V64sKJAt0eTT; Sat, 21 Dec 2019 09:32:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47fzPm0WYVz9vBmv;
        Sat, 21 Dec 2019 09:32:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576917148; bh=DQVyB9m2SFlXQ/6NdPBYridG2vEVSsZ5fiPCfT1jDYA=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=GH8QhU596ao3qVRmQVoLd675JOn2TS4f+p6EHnZkDe/e6LfII1+kAgKJwB+KOLIKT
         x73Dj1CLkhuIdFe/d3aWQyJeDkB5XSRrzWpos2Z0Z6XPDDQeI7T9dvCSBXocjcLlNe
         hwy0Ws1Q2SWp/PjOiNpJ32cLhUnKKSI5bz1+pVcg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 083708B77C;
        Sat, 21 Dec 2019 09:32:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id aeRrlaLRdQ6v; Sat, 21 Dec 2019 09:32:28 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BFC7A8B752;
        Sat, 21 Dec 2019 09:32:28 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 88DD0637B6; Sat, 21 Dec 2019 08:32:28 +0000 (UTC)
Message-Id: <60e9ae86b7d2cdcf21468787076d345663648f46.1576916812.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1576916812.git.christophe.leroy@c-s.fr>
References: <cover.1576916812.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 07/17] powerpc: align stack to 2 * THREAD_SIZE with
 VMAP_STACK
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Sat, 21 Dec 2019 08:32:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ease stack overflow detection, align
stack to 2 * THREAD_SIZE when using VMAP_STACK.
This allows overflow detection using a single bit check.

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
index dcffe927f5b9..f014c4f7a337 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -140,7 +140,7 @@ arch_initcall(ppc_init);
 
 static void *__init alloc_stack(void)
 {
-	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
+	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_ALIGN);
 
 	if (!ptr)
 		panic("cannot allocate %d bytes for stack at %pS\n",
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6104917a282d..e05e6dd67ae6 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -633,7 +633,7 @@ static void *__init alloc_stack(unsigned long limit, int cpu)
 
 	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
 
-	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_SIZE,
+	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_ALIGN,
 				     MEMBLOCK_LOW_LIMIT, limit,
 				     early_cpu_to_node(cpu));
 	if (!ptr)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 8834220036a5..b4c89a1acebb 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -323,7 +323,7 @@ SECTIONS
 #endif
 
 	/* The initial task and kernel stack */
-	INIT_TASK_DATA_SECTION(THREAD_SIZE)
+	INIT_TASK_DATA_SECTION(THREAD_ALIGN)
 
 	.data..page_aligned : AT(ADDR(.data..page_aligned) - LOAD_OFFSET) {
 		PAGE_ALIGNED_DATA(PAGE_SIZE)
-- 
2.13.3

