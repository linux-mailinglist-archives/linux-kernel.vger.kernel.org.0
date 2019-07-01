Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 468C32471F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 06:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfEUEyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 00:54:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727484AbfEUEyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:54:20 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L4qOq2022447
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:54:19 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sm97wtsdr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:54:18 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 21 May 2019 05:54:18 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 May 2019 05:54:15 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4L4sDpE57737302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 04:54:13 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 926E2C6057;
        Tue, 21 May 2019 04:54:13 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CE42C605A;
        Tue, 21 May 2019 04:53:51 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.80.203.157])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 May 2019 04:53:48 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 11/12] powerpc/pseries/svm: Force SWIOTLB for secure guests
Date:   Tue, 21 May 2019 01:49:11 -0300
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521044912.1375-1-bauerman@linux.ibm.com>
References: <20190521044912.1375-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052104-0004-0000-0000-000015120A57
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011134; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01206343; UDB=6.00633450; IPR=6.00987310;
 MB=3.00026980; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-21 04:54:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052104-0005-0000-0000-00008BBE4CE6
Message-Id: <20190521044912.1375-12-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

SWIOTLB checks range of incoming CPU addresses to be bounced and sees if
the device can access it through its DMA window without requiring bouncing.
In such cases it just chooses to skip bouncing. But for cases like secure
guests on powerpc platform all addresses need to be bounced into the shared
pool of memory because the host cannot access it otherwise. Hence the need
to do the bouncing is not related to device's DMA window and use of bounce
buffers is forced by setting swiotlb_force.

Also, connect the shared memory conversion functions into the
ARCH_HAS_MEM_ENCRYPT hooks and call swiotlb_update_mem_attributes() to
convert SWIOTLB's memory pool to shared memory.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
[ Use ARCH_HAS_MEM_ENCRYPT hooks to share swiotlb memory pool. ]
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/mem_encrypt.h | 19 +++++++++++
 arch/powerpc/platforms/pseries/Kconfig |  5 +++
 arch/powerpc/platforms/pseries/svm.c   | 45 ++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/arch/powerpc/include/asm/mem_encrypt.h b/arch/powerpc/include/asm/mem_encrypt.h
new file mode 100644
index 000000000000..45d5e4d0e6e0
--- /dev/null
+++ b/arch/powerpc/include/asm/mem_encrypt.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SVM helper functions
+ *
+ * Copyright 2019 IBM Corporation
+ */
+
+#ifndef _ASM_POWERPC_MEM_ENCRYPT_H
+#define _ASM_POWERPC_MEM_ENCRYPT_H
+
+#define sme_me_mask	0ULL
+
+static inline bool sme_active(void) { return false; }
+static inline bool sev_active(void) { return false; }
+
+int set_memory_encrypted(unsigned long addr, int numpages);
+int set_memory_decrypted(unsigned long addr, int numpages);
+
+#endif /* _ASM_POWERPC_MEM_ENCRYPT_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 82c16aa4f1ce..41b10f3bc729 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -145,9 +145,14 @@ config PAPR_SCM
 	help
 	  Enable access to hypervisor provided storage class memory.
 
+config ARCH_HAS_MEM_ENCRYPT
+	def_bool n
+
 config PPC_SVM
 	bool "Secure virtual machine (SVM) support for POWER"
 	depends on PPC_PSERIES
+	select SWIOTLB
+	select ARCH_HAS_MEM_ENCRYPT
 	default n
 	help
 	 Support secure guests on POWER. There are certain POWER platforms which
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index c508196f7c83..618622d636d5 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -7,8 +7,53 @@
  */
 
 #include <linux/mm.h>
+#include <asm/machdep.h>
+#include <asm/svm.h>
+#include <asm/swiotlb.h>
 #include <asm/ultravisor.h>
 
+static int __init init_svm(void)
+{
+	if (!is_secure_guest())
+		return 0;
+
+	/* Don't release the SWIOTLB buffer. */
+	ppc_swiotlb_enable = 1;
+
+	/*
+	 * Since the guest memory is inaccessible to the host, devices always
+	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
+	 * otherwise.
+	 */
+	swiotlb_force = SWIOTLB_FORCE;
+
+	/* Share the SWIOTLB buffer with the host. */
+	swiotlb_update_mem_attributes();
+
+	return 0;
+}
+machine_early_initcall(pseries, init_svm);
+
+int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	uv_unshare_page(PHYS_PFN(__pa(addr)), numpages);
+
+	return 0;
+}
+
+int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	uv_share_page(PHYS_PFN(__pa(addr)), numpages);
+
+	return 0;
+}
+
 /* There's one dispatch log per CPU. */
 #define NR_DTL_PAGE (DISPATCH_LOG_BYTES * CONFIG_NR_CPUS / PAGE_SIZE)
 

