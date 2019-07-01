Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E860658165
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfF0LYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 07:24:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbfF0LYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:24:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RBN04M189026
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 07:24:18 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcuaccxun-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 07:24:18 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 12:24:17 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 12:24:13 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RBOD0V40829260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 11:24:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDA0AA405B;
        Thu, 27 Jun 2019 11:24:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F013CA405F;
        Thu, 27 Jun 2019 11:24:10 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.73.27])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 11:24:10 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/7] ftrace: Expose __ftrace_replace_code()
Date:   Thu, 27 Jun 2019 16:53:51 +0530
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062711-0020-0000-0000-0000034DDFC2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062711-0021-0000-0000-000021A15A1D
Message-Id: <0d09c94f19332b13707109f41cd15b6e0c45d120.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
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

While over-riding ftrace_replace_code(), we still want to reuse the
existing __ftrace_replace_code() function. Rename the function and
make it available for other kernel code.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 include/linux/ftrace.h | 1 +
 kernel/trace/ftrace.c  | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e97789c95c4e..fa653a561da5 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -456,6 +456,7 @@ ftrace_set_early_filter(struct ftrace_ops *ops, char *buf, int enable);
 /* defined in arch */
 extern int ftrace_ip_converted(unsigned long ip);
 extern int ftrace_dyn_arch_init(void);
+extern int ftrace_replace_code_rec(struct dyn_ftrace *rec, int enable);
 extern void ftrace_replace_code(int enable);
 extern int ftrace_update_ftrace_func(ftrace_func_t func);
 extern void ftrace_caller(void);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5710a6b3edc1..21d8e201ee80 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2351,8 +2351,8 @@ unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec)
 		return (unsigned long)FTRACE_ADDR;
 }
 
-static int
-__ftrace_replace_code(struct dyn_ftrace *rec, int enable)
+int
+ftrace_replace_code_rec(struct dyn_ftrace *rec, int enable)
 {
 	unsigned long ftrace_old_addr;
 	unsigned long ftrace_addr;
@@ -2403,7 +2403,7 @@ void __weak ftrace_replace_code(int mod_flags)
 		if (rec->flags & FTRACE_FL_DISABLED)
 			continue;
 
-		failed = __ftrace_replace_code(rec, enable);
+		failed = ftrace_replace_code_rec(rec, enable);
 		if (failed) {
 			ftrace_bug(failed, rec);
 			/* Stop processing */
@@ -5827,7 +5827,7 @@ void ftrace_module_enable(struct module *mod)
 		rec->flags = cnt;
 
 		if (ftrace_start_up && cnt) {
-			int failed = __ftrace_replace_code(rec, 1);
+			int failed = ftrace_replace_code_rec(rec, 1);
 			if (failed) {
 				ftrace_bug(failed, rec);
 				goto out_loop;
-- 
2.22.0

