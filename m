Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9123FD6345
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbfJNNEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 09:04:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727948AbfJNNEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:04:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9ED2q3u090645
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:04:07 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vmqnbcxk3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:04:05 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 14 Oct 2019 14:04:03 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Oct 2019 14:04:00 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9ED3xX446858688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 13:03:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 006AF4C046;
        Mon, 14 Oct 2019 13:03:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 073654C040;
        Mon, 14 Oct 2019 13:03:56 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.59.28])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Oct 2019 13:03:55 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     christophe.leroy@c-s.fr, mpe@ellerman.id.au, mikey@neuling.org
Cc:     npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v5 1/7] Powerpc/Watchpoint: Introduce macros for watchpoint length
Date:   Mon, 14 Oct 2019 18:33:40 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191014130346.22660-1-ravi.bangoria@linux.ibm.com>
References: <20191014130346.22660-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101413-0012-0000-0000-00000357EF6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101413-0013-0000-0000-000021930187
Message-Id: <20191014130346.22660-2-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910140126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are hadrcoding length everywhere in the watchpoint code.
Introduce macros for the length and use them.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h | 3 +++
 arch/powerpc/kernel/hw_breakpoint.c      | 4 ++--
 arch/powerpc/kernel/ptrace.c             | 6 +++---
 arch/powerpc/xmon/xmon.c                 | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 67e2da195eae..4a887e85a5f4 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -33,6 +33,9 @@ struct arch_hw_breakpoint {
 #define HW_BRK_TYPE_PRIV_ALL	(HW_BRK_TYPE_USER | HW_BRK_TYPE_KERNEL | \
 				 HW_BRK_TYPE_HYP)
 
+#define DABR_MAX_LEN	8
+#define DAWR_MAX_LEN	512
+
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 #include <linux/kdebug.h>
 #include <asm/reg.h>
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 1007ec36b4cb..677041cb3c3e 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -163,9 +163,9 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	 */
 	if (!ppc_breakpoint_available())
 		return -ENODEV;
-	length_max = 8; /* DABR */
+	length_max = DABR_MAX_LEN; /* DABR */
 	if (dawr_enabled()) {
-		length_max = 512 ; /* 64 doublewords */
+		length_max = DAWR_MAX_LEN; /* 64 doublewords */
 		/* DAWR region can't cross 512 boundary */
 		if ((attr->bp_addr >> 9) !=
 		    ((attr->bp_addr + attr->bp_len - 1) >> 9))
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 8c92febf5f44..f22e773a416a 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2425,7 +2425,7 @@ static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 		return -EIO;
 	hw_brk.address = data & (~HW_BRK_TYPE_DABR);
 	hw_brk.type = (data & HW_BRK_TYPE_DABR) | HW_BRK_TYPE_PRIV_ALL;
-	hw_brk.len = 8;
+	hw_brk.len = DABR_MAX_LEN;
 	set_bp = (data) && (hw_brk.type & HW_BRK_TYPE_RDWR);
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	bp = thread->ptrace_bps[0];
@@ -2456,7 +2456,7 @@ static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	/* Create a new breakpoint request if one doesn't exist already */
 	hw_breakpoint_init(&attr);
 	attr.bp_addr = hw_brk.address;
-	attr.bp_len = 8;
+	attr.bp_len = DABR_MAX_LEN;
 	arch_bp_generic_fields(hw_brk.type,
 			       &attr.bp_type);
 
@@ -2882,7 +2882,7 @@ static long ppc_set_hwdebug(struct task_struct *child,
 
 	brk.address = bp_info->addr & ~7UL;
 	brk.type = HW_BRK_TYPE_TRANSLATE;
-	brk.len = 8;
+	brk.len = DABR_MAX_LEN;
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
 		brk.type |= HW_BRK_TYPE_READ;
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index d83364ebc5c5..d547e540c230 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -884,7 +884,7 @@ static void insert_cpu_bpts(void)
 	if (dabr.enabled) {
 		brk.address = dabr.address;
 		brk.type = (dabr.enabled & HW_BRK_TYPE_DABR) | HW_BRK_TYPE_PRIV_ALL;
-		brk.len = 8;
+		brk.len = DABR_MAX_LEN;
 		__set_breakpoint(&brk);
 	}
 
-- 
2.21.0

