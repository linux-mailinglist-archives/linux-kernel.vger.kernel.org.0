Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAD090402
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 16:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfHPOcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 10:32:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727245AbfHPOcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:32:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GEUQFW046935;
        Fri, 16 Aug 2019 10:31:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2udx190u1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 10:31:10 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7GEUaMi047879;
        Fri, 16 Aug 2019 10:31:10 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2udx190u16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 10:31:10 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7GEUPFY015415;
        Fri, 16 Aug 2019 14:31:09 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 2u9nj66bq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 14:31:09 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7GEV7in58392940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 14:31:07 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02BFBBE056;
        Fri, 16 Aug 2019 14:31:07 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 781A9BE081;
        Fri, 16 Aug 2019 14:31:06 +0000 (GMT)
Received: from localhost (unknown [9.85.178.67])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 14:31:06 +0000 (GMT)
From:   Gustavo Walbon <gwalbon@linux.ibm.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     diana.craciun@nxp.com, tglx@linutronix.de, jkosina@suse.cz,
        mikey@neuling.org, jpoimboe@redhat.com, leitao@debian.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        gustavowalbon@gmail.com
Subject: [PATCH] powerpc: Set right value of Speculation_Store_Bypass in /proc/<pid>/status
Date:   Fri, 16 Aug 2019 11:30:48 -0300
Message-Id: <20190816143048.11458-1-gwalbon@linux.ibm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue has showed the value of status of Speculation_Store_Bypass in the
/proc/<pid>/status as `unknown` for PowerPC systems.

The patch fix the checking of the mitigation status of Speculation, and
can be reported as "not vulnerable", "globally mitigated" or "vulnerable".

Link: https://github.com/linuxppc/issues/issues/255

Signed-off-by: Gustavo Walbon <gwalbon@linux.ibm.com>
---
 arch/powerpc/kernel/security.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index e1c9cf079503..754ae4238d4e 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -14,7 +14,7 @@
 #include <asm/debugfs.h>
 #include <asm/security_features.h>
 #include <asm/setup.h>
-
+#include <linux/prctl.h>
 
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
@@ -339,6 +339,29 @@ ssize_t cpu_show_spec_store_bypass(struct device *dev, struct device_attribute *
 	return sprintf(buf, "Vulnerable\n");
 }
 
+static int ssb_prctl_get(struct task_struct *task)
+{
+	if (stf_barrier) {
+		if (stf_enabled_flush_types == STF_BARRIER_NONE)
+			return PR_SPEC_NOT_AFFECTED;
+		else
+			return PR_SPEC_DISABLE;
+	} else
+		return PR_SPEC_DISABLE_NOEXEC;
+
+	return -EINVAL;
+}
+
+int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
+{
+	switch (which) {
+	case PR_SPEC_STORE_BYPASS:
+		return ssb_prctl_get(task);
+	default:
+		return -ENODEV;
+	}
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int stf_barrier_set(void *data, u64 val)
 {
-- 
2.19.1

