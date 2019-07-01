Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7494C608
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 06:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfFTENJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 00:13:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbfFTENJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 00:13:09 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5K4CNSN018659
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 00:13:08 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t81pgsvp5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 00:13:07 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Thu, 20 Jun 2019 05:13:05 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Jun 2019 05:13:01 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5K4D0PO51970296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 04:13:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A58AC4C04E;
        Thu, 20 Jun 2019 04:13:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1342E4C044;
        Thu, 20 Jun 2019 04:13:00 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 04:13:00 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id AECBFA011C;
        Thu, 20 Jun 2019 14:12:57 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ocxl: Allow contexts to be attached with a NULL mm
Date:   Thu, 20 Jun 2019 14:12:01 +1000
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062004-4275-0000-0000-00000343F20B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062004-4276-0000-0000-000038541FDE
Message-Id: <20190620041203.12274-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=500 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

If an OpenCAPI context is to be used directly by a kernel driver, there
may not be a suitable mm to use.

The patch makes the mm parameter to ocxl_context_attach optional.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/mm/book3s64/radix_tlb.c |  5 +++++
 drivers/misc/ocxl/context.c          |  9 ++++++---
 drivers/misc/ocxl/link.c             | 28 ++++++++++++++++++++++++----
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index bb9835681315..ce8a77fae6a7 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -666,6 +666,11 @@ EXPORT_SYMBOL(radix__flush_tlb_page);
 #define radix__flush_all_mm radix__local_flush_all_mm
 #endif /* CONFIG_SMP */
 
+/*
+ * If kernel TLBIs ever become local rather than global, then
+ * drivers/misc/ocxl/link.c:ocxl_link_add_pe will need some work, as it
+ * assumes kernel TLBIs are global.
+ */
 void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 	_tlbie_pid(0, RIC_FLUSH_ALL);
diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index bab9c9364184..994563a078eb 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -69,6 +69,7 @@ static void xsl_fault_error(void *data, u64 addr, u64 dsisr)
 int ocxl_context_attach(struct ocxl_context *ctx, u64 amr, struct mm_struct *mm)
 {
 	int rc;
+	unsigned long pidr = 0;
 
 	// Locks both status & tidr
 	mutex_lock(&ctx->status_mutex);
@@ -77,9 +78,11 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr, struct mm_struct *mm)
 		goto out;
 	}
 
-	rc = ocxl_link_add_pe(ctx->afu->fn->link, ctx->pasid,
-			mm->context.id, ctx->tidr, amr, mm,
-			xsl_fault_error, ctx);
+	if (mm)
+		pidr = mm->context.id;
+
+	rc = ocxl_link_add_pe(ctx->afu->fn->link, ctx->pasid, pidr, ctx->tidr,
+			      amr, mm, xsl_fault_error, ctx);
 	if (rc)
 		goto out;
 
diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index cce5b0d64505..58d111afd9f6 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -224,6 +224,17 @@ static irqreturn_t xsl_fault_handler(int irq, void *data)
 		ack_irq(spa, ADDRESS_ERROR);
 		return IRQ_HANDLED;
 	}
+
+	if (!pe_data->mm) {
+		/*
+		 * translation fault from a kernel context - an OpenCAPI
+		 * device tried to access a bad kernel address
+		 */
+		rcu_read_unlock();
+		pr_warn("Unresolved OpenCAPI xsl fault in kernel context\n");
+		ack_irq(spa, ADDRESS_ERROR);
+		return IRQ_HANDLED;
+	}
 	WARN_ON(pe_data->mm->context.id != pid);
 
 	if (mmget_not_zero(pe_data->mm)) {
@@ -523,7 +534,13 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
 	pe->amr = cpu_to_be64(amr);
 	pe->software_state = cpu_to_be32(SPA_PE_VALID);
 
-	mm_context_add_copro(mm);
+	/*
+	 * For user contexts, register a copro so that TLBIs are seen
+	 * by the nest MMU. If we have a kernel context, TLBIs are
+	 * already global.
+	 */
+	if (mm)
+		mm_context_add_copro(mm);
 	/*
 	 * Barrier is to make sure PE is visible in the SPA before it
 	 * is used by the device. It also helps with the global TLBI
@@ -546,7 +563,8 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
 	 * have a reference on mm_users. Incrementing mm_count solves
 	 * the problem.
 	 */
-	mmgrab(mm);
+	if (mm)
+		mmgrab(mm);
 	trace_ocxl_context_add(current->pid, spa->spa_mem, pasid, pidr, tidr);
 unlock:
 	mutex_unlock(&spa->spa_lock);
@@ -652,8 +670,10 @@ int ocxl_link_remove_pe(void *link_handle, int pasid)
 	if (!pe_data) {
 		WARN(1, "Couldn't find pe data when removing PE\n");
 	} else {
-		mm_context_remove_copro(pe_data->mm);
-		mmdrop(pe_data->mm);
+		if (pe_data->mm) {
+			mm_context_remove_copro(pe_data->mm);
+			mmdrop(pe_data->mm);
+		}
 		kfree_rcu(pe_data, rcu);
 	}
 unlock:
-- 
2.21.0

