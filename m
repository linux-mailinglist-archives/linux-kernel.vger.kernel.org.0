Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E1FE693
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 21:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKOUtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 15:49:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbfKOUtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:49:23 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFKlnee043375
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 15:49:22 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9jtttbhd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 15:49:22 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Fri, 15 Nov 2019 20:49:20 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Nov 2019 20:49:15 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAFKnELH45941086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 20:49:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5132042042;
        Fri, 15 Nov 2019 20:49:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D91B34203F;
        Fri, 15 Nov 2019 20:49:10 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.85.181.122])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Nov 2019 20:49:10 +0000 (GMT)
From:   Ram Pai <linuxram@us.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        paulus@ozlabs.org, mdroth@linux.vnet.ibm.com, hch@lst.de,
        linuxram@us.ibm.com, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        aik@ozlabs.ru, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com
Subject: [v3 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page with the hypervisor.
Date:   Fri, 15 Nov 2019 12:48:30 -0800
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573850911-19590-1-git-send-email-linuxram@us.ibm.com>
References: <1573850911-19590-1-git-send-email-linuxram@us.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19111520-0016-0000-0000-000002C439E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111520-0017-0000-0000-00003325E349
Message-Id: <1573850911-19590-2-git-send-email-linuxram@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_06:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=303 impostorscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 suspectscore=2 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H_PUT_TCE_INDIRECT hcall uses a page filled with TCE entries, as one of
its parameters. One page is dedicated per cpu, for the lifetime of the
kernel for this purpose. On secure VMs, contents of this page, when
accessed by the hypervisor, retrieves encrypted TCE entries.  Hypervisor
needs to know the unencrypted entries, to update the TCE table
accordingly.  There is nothing secret or sensitive about these entries.
Hence share the page with the hypervisor.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 6ba081d..0720831 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -37,6 +37,7 @@
 #include <asm/mmzone.h>
 #include <asm/plpar_wrappers.h>
 #include <asm/svm.h>
+#include <asm/ultravisor.h>
 
 #include "pseries.h"
 
@@ -179,6 +180,23 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 
 static DEFINE_PER_CPU(__be64 *, tce_page);
 
+/*
+ * Allocate a tce page.  If secure VM, share the page with the hypervisor.
+ *
+ * NOTE: the TCE page is shared with the hypervisor explicitly and remains
+ * shared for the lifetime of the kernel. It is implicitly unshared at kernel
+ * shutdown through a UV_UNSHARE_ALL_PAGES ucall.
+ */
+static __be64 *alloc_tce_page(void)
+{
+	__be64 *tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
+
+	if (tcep && is_secure_guest())
+		uv_share_page(PHYS_PFN(__pa(tcep)), 1);
+
+	return tcep;
+}
+
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
 				     enum dma_data_direction direction,
@@ -206,8 +224,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	 * from iommu_alloc{,_sg}()
 	 */
 	if (!tcep) {
-		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
-		/* If allocation fails, fall back to the loop implementation */
+		tcep = alloc_tce_page();
 		if (!tcep) {
 			local_irq_restore(flags);
 			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
@@ -405,7 +422,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 	tcep = __this_cpu_read(tce_page);
 
 	if (!tcep) {
-		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
+		tcep = alloc_tce_page();
 		if (!tcep) {
 			local_irq_enable();
 			return -ENOMEM;
-- 
1.8.3.1

