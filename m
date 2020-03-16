Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6C1186B08
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 13:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbgCPMg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 08:36:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5721 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbgCPMgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:36:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwlQ49rhz9v02n;
        Mon, 16 Mar 2020 13:36:18 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=oCbTKPco; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ucK0wVUAK6Ai; Mon, 16 Mar 2020 13:36:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwlQ38yjz9v02f;
        Mon, 16 Mar 2020 13:36:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362178; bh=VF6BlZ1RE7gj/KiNM0KFVQSAXcvGcPU6s9xNp059YnY=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=oCbTKPco0W5CBZ3hcO5B58qnSA5v+TXKDD60EhsX+yLuqtMA7e3uRwEUK6LIFAwel
         z1lgcIPDfRX9fUEy7qS9gPvRm+QKV5gRvnFbiGeCKhrglCEVegNnXlmCa3FKN4R6No
         TCqMPJ3qz6FlSISAz7oczosRzG6/fuGb0qkKldGE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 688808B7D0;
        Mon, 16 Mar 2020 13:36:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id soBWQyw7giB1; Mon, 16 Mar 2020 13:36:23 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 455478B7CB;
        Mon, 16 Mar 2020 13:36:23 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3888C65595; Mon, 16 Mar 2020 12:36:23 +0000 (UTC)
Message-Id: <68e078b68b9c151ba3683d0de999350c6627af90.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 37/46] powerpc/mm: Don't be too strict with _etext
 alignment on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:36:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to PPC64, accept to map RO data as ROX as a trade off between
between security and memory usage.

Having RO data executable is not a high risk as RO data can't be
modified to forge an exploit.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig              | 26 --------------------------
 arch/powerpc/kernel/vmlinux.lds.S |  3 +--
 2 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f3ea52bcbaf8..66d02667b43d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -774,32 +774,6 @@ config THREAD_SHIFT
 	  Used to define the stack size. The default is almost always what you
 	  want. Only change this if you know what you are doing.
 
-config ETEXT_SHIFT_BOOL
-	bool "Set custom etext alignment" if STRICT_KERNEL_RWX && \
-					     (PPC_BOOK3S_32 || PPC_8xx)
-	depends on ADVANCED_OPTIONS
-	help
-	  This option allows you to set the kernel end of text alignment. When
-	  RAM is mapped by blocks, the alignment needs to fit the size and
-	  number of possible blocks. The default should be OK for most configs.
-
-	  Say N here unless you know what you are doing.
-
-config ETEXT_SHIFT
-	int "_etext shift" if ETEXT_SHIFT_BOOL
-	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
-	range 19 23 if STRICT_KERNEL_RWX && PPC_8xx
-	default 17 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
-	default 19 if STRICT_KERNEL_RWX && PPC_8xx
-	default PPC_PAGE_SHIFT
-	help
-	  On Book3S 32 (603+), IBATs are used to map kernel text.
-	  Smaller is the alignment, greater is the number of necessary IBATs.
-
-	  On 8xx, large pages (512kb or 8M) are used to map kernel linear
-	  memory. Aligning to 8M reduces TLB misses as only 8M pages are used
-	  in that case.
-
 config DATA_SHIFT_BOOL
 	bool "Set custom data alignment" if STRICT_KERNEL_RWX && \
 					    (PPC_BOOK3S_32 || PPC_8xx)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index a32d478a7f41..41bc64880ca1 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -15,7 +15,6 @@
 #include <asm/thread_info.h>
 
 #define STRICT_ALIGN_SIZE	(1 << CONFIG_DATA_SHIFT)
-#define ETEXT_ALIGN_SIZE	(1 << CONFIG_ETEXT_SHIFT)
 
 ENTRY(_stext)
 
@@ -116,7 +115,7 @@ SECTIONS
 
 	} :text
 
-	. = ALIGN(ETEXT_ALIGN_SIZE);
+	. = ALIGN(PAGE_SIZE);
 	_etext = .;
 	PROVIDE32 (etext = .);
 
-- 
2.25.0

