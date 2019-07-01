Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF41621DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 21:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfEQTEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 15:04:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbfEQTEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:04:20 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HJ4Bjw015769
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 15:04:19 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sj1au2x92-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 15:04:15 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Fri, 17 May 2019 20:03:08 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 May 2019 20:03:05 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4HJ34hI52035692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 19:03:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B06B0AE045;
        Fri, 17 May 2019 19:03:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6005AE04D;
        Fri, 17 May 2019 19:03:02 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.199.60.55])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 May 2019 19:03:02 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 4/4] powerpc/ftrace: Additionally nop out the preceding mflr with -mprofile-kernel
Date:   Sat, 18 May 2019 00:32:48 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051719-0008-0000-0000-000002E7CFC0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051719-0009-0000-0000-000022547B5D
Message-Id: <ee2a5457d98850f51bf96eb17389b375e6955bbf.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=927 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With -mprofile-kernel, gcc emits 'mflr r0', followed by 'bl _mcount' to
enable function tracing and profiling. So far, with dynamic ftrace, we
used to only patch out the branch to _mcount(). However, Nick Piggin
points out that "mflr is executed by the branch unit that can only
execute one per cycle on POWER9 and shared with branches, so it would be
nice to avoid it where possible."

We cannot simply nop out the mflr either. Michael Ellerman pointed out
that when enabling function tracing, there can be a race if tracing is
enabled when some thread was interrupted after executing a nop'ed out
mflr. In this case, the thread would execute the now-patched-in branch
to _mcount() without having executed the preceding mflr.

To solve this, we now enable function tracing in 2 steps: patch in the
mflr instruction, use synchronize_rcu_tasks() to ensure all existing
threads make progress, and then patch in the branch to _mcount(). We
override ftrace_replace_code() with a powerpc64 variant for this
purpose.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/trace/ftrace.c | 188 +++++++++++++++++++++++++----
 1 file changed, 166 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 517662a56bdc..5c3523c3b259 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -125,7 +125,7 @@ __ftrace_make_nop(struct module *mod,
 {
 	unsigned long entry, ptr, tramp;
 	unsigned long ip = rec->ip;
-	unsigned int op, pop;
+	unsigned int op;
 
 	/* read where this goes */
 	if (probe_kernel_read(&op, (void *)ip, sizeof(int))) {
@@ -160,8 +160,6 @@ __ftrace_make_nop(struct module *mod,
 
 #ifdef CONFIG_MPROFILE_KERNEL
 	/* When using -mkernel_profile there is no load to jump over */
-	pop = PPC_INST_NOP;
-
 	if (probe_kernel_read(&op, (void *)(ip - 4), 4)) {
 		pr_err("Fetching instruction at %lx failed.\n", ip - 4);
 		return -EFAULT;
@@ -169,26 +167,22 @@ __ftrace_make_nop(struct module *mod,
 
 	/* We expect either a mflr r0, or a std r0, LRSAVE(r1) */
 	if (op != PPC_INST_MFLR && op != PPC_INST_STD_LR) {
-		pr_err("Unexpected instruction %08x around bl _mcount\n", op);
+		pr_err("Unexpected instruction %08x before bl _mcount\n", op);
 		return -EINVAL;
 	}
-#else
-	/*
-	 * Our original call site looks like:
-	 *
-	 * bl <tramp>
-	 * ld r2,XX(r1)
-	 *
-	 * Milton Miller pointed out that we can not simply nop the branch.
-	 * If a task was preempted when calling a trace function, the nops
-	 * will remove the way to restore the TOC in r2 and the r2 TOC will
-	 * get corrupted.
-	 *
-	 * Use a b +8 to jump over the load.
-	 */
 
-	pop = PPC_INST_BRANCH | 8;	/* b +8 */
+	/* We should patch out the bl to _mcount first */
+	if (patch_instruction((unsigned int *)ip, PPC_INST_NOP)) {
+		pr_err("Patching NOP failed.\n");
+		return -EPERM;
+	}
 
+	if (op == PPC_INST_MFLR &&
+		patch_instruction((unsigned int *)(ip - 4), PPC_INST_NOP)) {
+		pr_err("Patching NOP failed.\n");
+		return -EPERM;
+	}
+#else
 	/*
 	 * Check what is in the next instruction. We can see ld r2,40(r1), but
 	 * on first pass after boot we will see mflr r0.
@@ -202,12 +196,25 @@ __ftrace_make_nop(struct module *mod,
 		pr_err("Expected %08x found %08x\n", PPC_INST_LD_TOC, op);
 		return -EINVAL;
 	}
-#endif /* CONFIG_MPROFILE_KERNEL */
 
-	if (patch_instruction((unsigned int *)ip, pop)) {
+	/*
+	 * Our original call site looks like:
+	 *
+	 * bl <tramp>
+	 * ld r2,XX(r1)
+	 *
+	 * Milton Miller pointed out that we can not simply nop the branch.
+	 * If a task was preempted when calling a trace function, the nops
+	 * will remove the way to restore the TOC in r2 and the r2 TOC will
+	 * get corrupted.
+	 *
+	 * Use a b +8 to jump over the load.
+	 */
+	if (patch_instruction((unsigned int *)ip, PPC_INST_BRANCH | 8)) {
 		pr_err("Patching NOP failed.\n");
 		return -EPERM;
 	}
+#endif /* CONFIG_MPROFILE_KERNEL */
 
 	return 0;
 }
@@ -421,6 +428,25 @@ static int __ftrace_make_nop_kernel(struct dyn_ftrace *rec, unsigned long addr)
 		return -EPERM;
 	}
 
+#ifdef CONFIG_MPROFILE_KERNEL
+	if (probe_kernel_read(&op, (void *)(ip - 4), 4)) {
+		pr_err("Fetching instruction at %lx failed.\n", ip - 4);
+		return -EFAULT;
+	}
+
+	/* We expect either a mflr r0, or a std r0, LRSAVE(r1) */
+	if (op != PPC_INST_MFLR && op != PPC_INST_STD_LR) {
+		pr_err("Unexpected instruction %08x before bl _mcount\n", op);
+		return -EINVAL;
+	}
+
+	if (op == PPC_INST_MFLR &&
+		patch_instruction((unsigned int *)(ip - 4), PPC_INST_NOP)) {
+		pr_err("Patching NOP failed.\n");
+		return -EPERM;
+	}
+#endif
+
 	return 0;
 }
 
@@ -429,6 +455,7 @@ int ftrace_make_nop(struct module *mod,
 {
 	unsigned long ip = rec->ip;
 	unsigned int old, new;
+	int rc;
 
 	/*
 	 * If the calling address is more that 24 bits away,
@@ -439,7 +466,27 @@ int ftrace_make_nop(struct module *mod,
 		/* within range */
 		old = ftrace_call_replace(ip, addr, 1);
 		new = PPC_INST_NOP;
-		return ftrace_modify_code(ip, old, new);
+		rc = ftrace_modify_code(ip, old, new);
+#ifdef CONFIG_MPROFILE_KERNEL
+		if (rc)
+			return rc;
+
+		if (probe_kernel_read(&old, (void *)(ip - 4), 4)) {
+			pr_err("Fetching instruction at %lx failed.\n", ip - 4);
+			return -EFAULT;
+		}
+
+		/* We expect either a mflr r0, or a std r0, LRSAVE(r1) */
+		if (old != PPC_INST_MFLR && old != PPC_INST_STD_LR) {
+			pr_err("Unexpected instruction %08x before bl _mcount\n", old);
+			return -EINVAL;
+		}
+
+		if (old == PPC_INST_MFLR)
+			rc = patch_instruction((unsigned int *)(ip - 4),
+					PPC_INST_NOP);
+#endif
+		return rc;
 	} else if (core_kernel_text(ip))
 		return __ftrace_make_nop_kernel(rec, addr);
 
@@ -863,6 +910,103 @@ void arch_ftrace_update_code(int command)
 	ftrace_modify_all_code(command);
 }
 
+#ifdef CONFIG_MPROFILE_KERNEL
+static int
+__ftrace_make_call_prep(struct dyn_ftrace *rec)
+{
+	void *ip = (void *)rec->ip - MCOUNT_INSN_SIZE;
+	unsigned int op[2], pop;
+
+	/* read where this goes */
+	if (probe_kernel_read(op, ip, sizeof(op)))
+		return -EFAULT;
+
+	if (op[1] != PPC_INST_NOP) {
+		pr_err("Unexpected call sequence at %p: %x %x\n",
+							ip, op[0], op[1]);
+		return -EINVAL;
+	}
+
+	/*
+	 * nothing to do if this is using the older -mprofile-kernel
+	 * instruction sequence
+	 */
+	if (op[0] != PPC_INST_NOP)
+		return 0;
+
+	pop = PPC_INST_MFLR;
+
+	if (patch_instruction((unsigned int *)ip, pop)) {
+		pr_err("Patching MFLR failed.\n");
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+void ftrace_replace_code(int mod_flags)
+{
+	int enable = mod_flags & FTRACE_MODIFY_ENABLE_FL;
+	int schedulable = mod_flags & FTRACE_MODIFY_MAY_SLEEP_FL;
+	int ret, failed, make_call = 0;
+	struct ftrace_rec_iter *iter;
+	struct dyn_ftrace *rec;
+
+	if (unlikely(!ftrace_enabled))
+		return;
+
+	for_ftrace_rec_iter(iter) {
+		rec = ftrace_rec_iter_record(iter);
+
+		if (rec->flags & FTRACE_FL_DISABLED)
+			continue;
+
+		ret = ftrace_test_record(rec, enable);
+		if (ret == FTRACE_UPDATE_MAKE_CALL) {
+			make_call++;
+			failed = __ftrace_make_call_prep(rec);
+		} else {
+			failed = ftrace_do_replace_code(rec, enable);
+		}
+
+		if (failed) {
+			ftrace_bug(failed, rec);
+			/* Stop processing */
+			return;
+		}
+
+		if (schedulable)
+			cond_resched();
+	}
+
+	if (!make_call)
+		return;
+
+	synchronize_rcu_tasks();
+
+	for_ftrace_rec_iter(iter) {
+		rec = ftrace_rec_iter_record(iter);
+
+		if (rec->flags & FTRACE_FL_DISABLED)
+			continue;
+
+		ret = ftrace_test_record(rec, enable);
+		if (ret == FTRACE_UPDATE_MAKE_CALL)
+			failed = ftrace_do_replace_code(rec, enable);
+
+		if (failed) {
+			ftrace_bug(failed, rec);
+			/* Stop processing */
+			return;
+		}
+
+		if (schedulable)
+			cond_resched();
+	}
+
+}
+#endif
+
 #ifdef CONFIG_PPC64
 #define PACATOC offsetof(struct paca_struct, kernel_toc)
 
-- 
2.21.0

