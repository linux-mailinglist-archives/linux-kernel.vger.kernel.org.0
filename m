Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6719E59F73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 17:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfF1PsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 11:48:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18773 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbfF1PsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:48:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45b1PX4crxzB09ZQ;
        Fri, 28 Jun 2019 17:48:00 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=DkjV/RUO; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id n90AzFDzaPc6; Fri, 28 Jun 2019 17:48:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45b1PX3cJNzB09ZN;
        Fri, 28 Jun 2019 17:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561736880; bh=9s4sBVzFPOLHohWD4vqsFQiWSWAQpraugdzO4CPhZD0=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=DkjV/RUORFcCVM23m0eXNdQqvKcVoNPLL/N/UTPp7fByyLhpXkupJa7HoERk5CpNV
         NKspxJ+Dml+EiAuBv0uV6iK+aDsTxEyL3hZQUL664yXYo9tFbFn/16A1GsrPioKDt5
         DNhCGfd0K6yFx+01kRBOoReE1v6j9y9SuYcaEM0c=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CA7148B976;
        Fri, 28 Jun 2019 17:48:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3KVPzvxyFl9j; Fri, 28 Jun 2019 17:48:01 +0200 (CEST)
Received: from localhost.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 23DB08B975;
        Fri, 28 Jun 2019 17:48:01 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 0786568DBC; Fri, 28 Jun 2019 15:48:01 +0000 (UTC)
Message-Id: <b25d2a4c5d6ea848b9b4e434bc4c67833c8e9268.1561735588.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1561735587.git.christophe.leroy@c-s.fr>
References: <cover.1561735587.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 11/12] powerpc/ptrace: create ppc_gethwdinfo()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 28 Jun 2019 15:48:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create ippc_gethwdinfo() to handle PPC_PTRACE_GETHWDBGINFO and
reduce ifdef mess

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/ptrace/ptrace-adv.c   | 15 +++++++++++++++
 arch/powerpc/kernel/ptrace/ptrace-decl.h  |  1 +
 arch/powerpc/kernel/ptrace/ptrace-noadv.c | 20 +++++++++++++++++++
 arch/powerpc/kernel/ptrace/ptrace.c       | 32 +------------------------------
 4 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace-adv.c b/arch/powerpc/kernel/ptrace/ptrace-adv.c
index dcc765940344..f5f334484ebc 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-adv.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-adv.c
@@ -83,6 +83,21 @@ void user_disable_single_step(struct task_struct *task)
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
+void ppc_gethwdinfo(struct ppc_debug_info *dbginfo)
+{
+	dbginfo->version = 1;
+	dbginfo->num_instruction_bps = CONFIG_PPC_ADV_DEBUG_IACS;
+	dbginfo->num_data_bps = CONFIG_PPC_ADV_DEBUG_DACS;
+	dbginfo->num_condition_regs = CONFIG_PPC_ADV_DEBUG_DVCS;
+	dbginfo->data_bp_alignment = 4;
+	dbginfo->sizeof_condition = 4;
+	dbginfo->features = PPC_DEBUG_FEATURE_INSN_BP_RANGE |
+			    PPC_DEBUG_FEATURE_INSN_BP_MASK;
+	if (IS_ENABLED(CONFIG_PPC_ADV_DEBUG_DAC_RANGE))
+		dbginfo->features |= PPC_DEBUG_FEATURE_DATA_BP_RANGE |
+				     PPC_DEBUG_FEATURE_DATA_BP_MASK;
+}
+
 int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
 			unsigned long __user *datalp)
 {
diff --git a/arch/powerpc/kernel/ptrace/ptrace-decl.h b/arch/powerpc/kernel/ptrace/ptrace-decl.h
index 4b4b6a1d508a..3c8a81999292 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-decl.h
+++ b/arch/powerpc/kernel/ptrace/ptrace-decl.h
@@ -176,6 +176,7 @@ int tm_cgpr32_set(struct task_struct *target, const struct user_regset *regset,
 extern const struct user_regset_view user_ppc_native_view;
 
 /* ptrace-(no)adv */
+void ppc_gethwdinfo(struct ppc_debug_info *dbginfo);
 int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
 			unsigned long __user *datalp);
 int ptrace_set_debugreg(struct task_struct *task, unsigned long addr, unsigned long data);
diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
index 985cca136f85..426fedd7ab6c 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
@@ -64,6 +64,26 @@ void user_disable_single_step(struct task_struct *task)
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
+void ppc_gethwdinfo(struct ppc_debug_info *dbginfo)
+{
+	dbginfo->version = 1;
+	dbginfo->num_instruction_bps = 0;
+	if (ppc_breakpoint_available())
+		dbginfo->num_data_bps = 1;
+	else
+		dbginfo->num_data_bps = 0;
+	dbginfo->num_condition_regs = 0;
+	dbginfo->data_bp_alignment = sizeof(long);
+	dbginfo->sizeof_condition = 0;
+	if (IS_ENABLED(CONFIG_HAVE_HW_BREAKPOINT)) {
+		dbginfo->features = PPC_DEBUG_FEATURE_DATA_BP_RANGE;
+		if (dawr_enabled())
+			dbginfo->features |= PPC_DEBUG_FEATURE_DATA_BP_DAWR;
+	} else {
+		dbginfo->features = 0;
+	}
+}
+
 int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
 			unsigned long __user *datalp)
 {
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index e789afae6f56..31e8c5a9171e 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -159,37 +159,7 @@ long arch_ptrace(struct task_struct *child, long request,
 	case PPC_PTRACE_GETHWDBGINFO: {
 		struct ppc_debug_info dbginfo;
 
-		dbginfo.version = 1;
-#ifdef CONFIG_PPC_ADV_DEBUG_REGS
-		dbginfo.num_instruction_bps = CONFIG_PPC_ADV_DEBUG_IACS;
-		dbginfo.num_data_bps = CONFIG_PPC_ADV_DEBUG_DACS;
-		dbginfo.num_condition_regs = CONFIG_PPC_ADV_DEBUG_DVCS;
-		dbginfo.data_bp_alignment = 4;
-		dbginfo.sizeof_condition = 4;
-		dbginfo.features = PPC_DEBUG_FEATURE_INSN_BP_RANGE |
-				   PPC_DEBUG_FEATURE_INSN_BP_MASK;
-#ifdef CONFIG_PPC_ADV_DEBUG_DAC_RANGE
-		dbginfo.features |=
-				   PPC_DEBUG_FEATURE_DATA_BP_RANGE |
-				   PPC_DEBUG_FEATURE_DATA_BP_MASK;
-#endif
-#else /* !CONFIG_PPC_ADV_DEBUG_REGS */
-		dbginfo.num_instruction_bps = 0;
-		if (ppc_breakpoint_available())
-			dbginfo.num_data_bps = 1;
-		else
-			dbginfo.num_data_bps = 0;
-		dbginfo.num_condition_regs = 0;
-		dbginfo.data_bp_alignment = sizeof(long);
-		dbginfo.sizeof_condition = 0;
-#ifdef CONFIG_HAVE_HW_BREAKPOINT
-		dbginfo.features = PPC_DEBUG_FEATURE_DATA_BP_RANGE;
-		if (dawr_enabled())
-			dbginfo.features |= PPC_DEBUG_FEATURE_DATA_BP_DAWR;
-#else
-		dbginfo.features = 0;
-#endif /* CONFIG_HAVE_HW_BREAKPOINT */
-#endif /* CONFIG_PPC_ADV_DEBUG_REGS */
+		ppc_gethwdinfo(&dbginfo);
 
 		if (copy_to_user(datavp, &dbginfo,
 				 sizeof(struct ppc_debug_info)))
-- 
2.13.3

