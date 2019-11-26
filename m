Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1787F10A552
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 21:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfKZUQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 15:16:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:45838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbfKZUOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:14:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D950EB1DE;
        Tue, 26 Nov 2019 20:14:12 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Breno Leitao <leitao@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/35] powerpc/64s/exception: Add ISIDE option
Date:   Tue, 26 Nov 2019 21:13:23 +0100
Message-Id: <a35d660e15806f9dce239f69897d6bd439b208d4.1574798487.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574798487.git.msuchanek@suse.de>
References: <cover.1574798487.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

Rather than using DAR=2 to select the i-side registers, add an
explicit option.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index bef0c2eee7dc..b8588618cdc3 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -199,6 +199,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define IVEC		.L_IVEC_\name\()
 #define IHSRR		.L_IHSRR_\name\()
 #define IAREA		.L_IAREA_\name\()
+#define IISIDE		.L_IISIDE_\name\()
 #define IDAR		.L_IDAR_\name\()
 #define IDSISR		.L_IDSISR_\name\()
 #define ISET_RI		.L_ISET_RI_\name\()
@@ -231,6 +232,9 @@ do_define_int n
 	.ifndef IAREA
 		IAREA=PACA_EXGEN
 	.endif
+	.ifndef IISIDE
+		IISIDE=0
+	.endif
 	.ifndef IDAR
 		IDAR=0
 	.endif
@@ -542,7 +546,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	 */
 	GET_SCRATCH0(r10)
 	std	r10,IAREA+EX_R13(r13)
-	.if IDAR == 1
+	.if IDAR && !IISIDE
 	.if IHSRR
 	mfspr	r10,SPRN_HDAR
 	.else
@@ -550,7 +554,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	.endif
 	std	r10,IAREA+EX_DAR(r13)
 	.endif
-	.if IDSISR == 1
+	.if IDSISR && !IISIDE
 	.if IHSRR
 	mfspr	r10,SPRN_HDSISR
 	.else
@@ -625,16 +629,18 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	std	r9,GPR11(r1)
 	std	r10,GPR12(r1)
 	std	r11,GPR13(r1)
+
 	.if IDAR
-	.if IDAR == 2
+	.if IISIDE
 	ld	r10,_NIP(r1)
 	.else
 	ld	r10,IAREA+EX_DAR(r13)
 	.endif
 	std	r10,_DAR(r1)
 	.endif
+
 	.if IDSISR
-	.if IDSISR == 2
+	.if IISIDE
 	ld	r10,_MSR(r1)
 	lis	r11,DSISR_SRR1_MATCH_64S@h
 	and	r10,r10,r11
@@ -643,6 +649,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	.endif
 	std	r10,_DSISR(r1)
 	.endif
+
 BEGIN_FTR_SECTION_NESTED(66)
 	ld	r10,IAREA+EX_CFAR(r13)
 	std	r10,ORIG_GPR3(r1)
@@ -1311,8 +1318,9 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 INT_DEFINE_BEGIN(instruction_access)
 	IVEC=0x400
-	IDAR=2
-	IDSISR=2
+	IISIDE=1
+	IDAR=1
+	IDSISR=1
 	IKVM_REAL=1
 INT_DEFINE_END(instruction_access)
 
@@ -1341,7 +1349,8 @@ INT_DEFINE_BEGIN(instruction_access_slb)
 	IVEC=0x480
 	IAREA=PACA_EXSLB
 	IRECONCILE=0
-	IDAR=2
+	IISIDE=1
+	IDAR=1
 	IKVM_REAL=1
 INT_DEFINE_END(instruction_access_slb)
 
-- 
2.23.0

