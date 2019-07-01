Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133E859F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 17:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfF1PtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 11:49:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40434 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbfF1Prx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:47:53 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45b1PL2y79zB09ZQ;
        Fri, 28 Jun 2019 17:47:50 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eLbff2yA; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iiL7FYjKr6zA; Fri, 28 Jun 2019 17:47:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45b1PL1qN4zB09ZN;
        Fri, 28 Jun 2019 17:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561736870; bh=WmP4bKhnfBYlSSGQ//frf/dAVmCAzNuL14conWVzh18=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=eLbff2yAwf4Sx2EDT4g7EvkoEDZQWJWVYdRgj+nDDJuZg0Zd8MCOiBSOuJjjo2GZG
         lrHs2lCejz93KhHbBg4OBzjrvL93ErU3tVimaMWEMZFpnREahoPvegUT/mBgphJfBB
         scdGGZMJpky1lJ75/DgcJrI8TZG1q2sShnz8LdS0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 715CE8B955;
        Fri, 28 Jun 2019 17:47:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HkwAnLYF9rVD; Fri, 28 Jun 2019 17:47:51 +0200 (CEST)
Received: from localhost.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E3FE98B976;
        Fri, 28 Jun 2019 17:47:50 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id A6EE668DBC; Fri, 28 Jun 2019 15:47:50 +0000 (UTC)
Message-Id: <4b371c54e2c15cab57585ad538d9fcb33bcf2725.1561735587.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1561735587.git.christophe.leroy@c-s.fr>
References: <cover.1561735587.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 01/12] powerpc: move ptrace into a subdirectory.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 28 Jun 2019 15:47:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow splitting of ptrace depending on the
different CONFIG_ options, create a subdirectory dedicated to
ptrace and move ptrace.c and ptrace32.c into it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/Makefile                | 7 +++----
 arch/powerpc/kernel/ptrace/Makefile         | 9 +++++++++
 arch/powerpc/kernel/{ => ptrace}/ptrace.c   | 0
 arch/powerpc/kernel/{ => ptrace}/ptrace32.c | 0
 4 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/kernel/ptrace/Makefile
 rename arch/powerpc/kernel/{ => ptrace}/ptrace.c (100%)
 rename arch/powerpc/kernel/{ => ptrace}/ptrace32.c (100%)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 0ea6c4aa3a20..c522464fa56a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -3,8 +3,6 @@
 # Makefile for the linux kernel.
 #
 
-CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
-
 # Disable clang warning for using setjmp without setjmp.h header
 CFLAGS_crash.o		+= $(call cc-disable-warning, builtin-requires-header)
 
@@ -43,15 +41,16 @@ CFLAGS_prom_init.o += -DDISABLE_BRANCH_PROFILING
 CFLAGS_btext.o += -DDISABLE_BRANCH_PROFILING
 endif
 
-obj-y				:= cputable.o ptrace.o syscalls.o \
+obj-y				:= cputable.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
 				   process.o systbl.o idle.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
 				   of_platform.o prom_parse.o
+obj-y				+= ptrace/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
-				   signal_64.o ptrace32.o \
+				   signal_64.o \
 				   paca.o nvram_64.o firmware.o
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
diff --git a/arch/powerpc/kernel/ptrace/Makefile b/arch/powerpc/kernel/ptrace/Makefile
new file mode 100644
index 000000000000..02fb28eb3b55
--- /dev/null
+++ b/arch/powerpc/kernel/ptrace/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux kernel.
+#
+
+CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
+
+obj-y				+= ptrace.o
+obj-$(CONFIG_PPC64)		+= ptrace32.o
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
similarity index 100%
rename from arch/powerpc/kernel/ptrace.c
rename to arch/powerpc/kernel/ptrace/ptrace.c
diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace/ptrace32.c
similarity index 100%
rename from arch/powerpc/kernel/ptrace32.c
rename to arch/powerpc/kernel/ptrace/ptrace32.c
-- 
2.13.3

