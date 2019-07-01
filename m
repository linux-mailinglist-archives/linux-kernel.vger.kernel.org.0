Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C3058168
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 13:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfF0LY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 07:24:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbfF0LYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:24:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RBMTr3103733
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 07:24:23 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tcv1ntuwv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 07:24:23 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 12:24:21 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 12:24:18 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RBOHAX49152144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 11:24:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B50AAA4064;
        Thu, 27 Jun 2019 11:24:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B74B5A4054;
        Thu, 27 Jun 2019 11:24:15 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.73.27])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 11:24:15 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/7] ftrace: Update ftrace_location() for powerpc -mprofile-kernel
Date:   Thu, 27 Jun 2019 16:53:53 +0530
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062711-0016-0000-0000-0000028CD921
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062711-0017-0000-0000-000032EA565E
Message-Id: <4b8413033a785fd2fad7da499df03b878d500655.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we are patching the preceding 'mflr r0' instruction with
-mprofile-kernel, we need to update ftrace_location() to recognise that
as being part of ftrace.

To do this, we introduce FTRACE_IP_EXTENSION to denote the length (in
bytes) of the mcount caller. By default, this is set to 0. For powerpc
with CONFIG_MPROFILE_KERNEL, we set this to MCOUNT_INSN_SIZE so that
this works if ftrace_location() is called with the address of the actual
ftrace entry call, or with the address of the preceding 'mflr r0'
instruction.

Note that we do not check if the preceding instruction is indeed the
'mflr r0'. Earlier -mprofile-kernel ABI included a 'std r0,stack'
instruction between the 'mflr r0' and the 'bl _mcount'. This is harmless
as the 'std r0,stack' instruction is inconsequential and is not relied
upon.

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ftrace.h | 8 ++++++++
 include/linux/ftrace.h            | 9 +++++++++
 kernel/trace/ftrace.c             | 2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 3dfb80b86561..510a8ac8ac8d 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -61,6 +61,14 @@ struct dyn_arch_ftrace {
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 #define ARCH_SUPPORTS_FTRACE_OPS 1
+
+#ifdef CONFIG_MPROFILE_KERNEL
+/*
+ * We consider two instructions -- 'mflr r0', 'bl _mcount' -- to be part
+ * of ftrace with -mprofile-kernel
+ */
+#define FTRACE_IP_EXTENSION	MCOUNT_INSN_SIZE
+#endif
 #endif
 #endif /* CONFIG_FUNCTION_TRACER */
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fa653a561da5..310b514438cb 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -29,6 +29,15 @@
 #define ARCH_SUPPORTS_FTRACE_OPS 0
 #endif
 
+/*
+ * This denotes the number of instructions (in bytes) that is used by the
+ * arch mcount caller. All instructions in this range will be owned by
+ * ftrace.
+ */
+#ifndef FTRACE_IP_EXTENSION
+#define FTRACE_IP_EXTENSION 0
+#endif
+
 /*
  * If the arch's mcount caller does not support all of ftrace's
  * features, then it must call an indirect function that
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 21d8e201ee80..308555925b81 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1575,7 +1575,7 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	return ftrace_location_range(ip, ip);
+	return ftrace_location_range(ip, ip + FTRACE_IP_EXTENSION);
 }
 
 /**
-- 
2.22.0

