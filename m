Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1960082AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 07:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbfHFFZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 01:25:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726036AbfHFFZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:25:47 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x765MM5f005338;
        Tue, 6 Aug 2019 01:23:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u70rb590e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 01:23:27 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x765Mmho006942;
        Tue, 6 Aug 2019 01:23:26 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u70rb5901-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 01:23:26 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x765KIPJ025255;
        Tue, 6 Aug 2019 05:23:25 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 2u51w6wy8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 05:23:25 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x765NOdQ46596514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Aug 2019 05:23:24 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBE79112062;
        Tue,  6 Aug 2019 05:23:24 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8EB2112061;
        Tue,  6 Aug 2019 05:23:22 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.207.254])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Aug 2019 05:23:22 +0000 (GMT)
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
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v3 10/16] powerpc/pseries/svm: Unshare all pages before kexecing a new kernel
Date:   Tue,  6 Aug 2019 02:22:31 -0300
Message-Id: <20190806052237.12525-11-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806052237.12525-1-bauerman@linux.ibm.com>
References: <20190806052237.12525-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

A new kernel deserves a clean slate. Any pages shared with the hypervisor
is unshared before invoking the new kernel. However there are exceptions.
If the new kernel is invoked to dump the current kernel, or if there is a
explicit request to preserve the state of the current kernel, unsharing
of pages is skipped.

NOTE: While testing crashkernel, make sure at least 256M is reserved for
crashkernel. Otherwise SWIOTLB allocation will fail and crash kernel will
fail to boot.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/ultravisor-api.h | 1 +
 arch/powerpc/include/asm/ultravisor.h     | 5 +++++
 arch/powerpc/kernel/machine_kexec_64.c    | 9 +++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/powerpc/include/asm/ultravisor-api.h b/arch/powerpc/include/asm/ultravisor-api.h
index 142b0576b89f..7e69c364bde0 100644
--- a/arch/powerpc/include/asm/ultravisor-api.h
+++ b/arch/powerpc/include/asm/ultravisor-api.h
@@ -24,5 +24,6 @@
 #define UV_ESM				0xF110
 #define UV_SHARE_PAGE			0xF130
 #define UV_UNSHARE_PAGE			0xF134
+#define UV_UNSHARE_ALL_PAGES		0xF140
 
 #endif /* _ASM_POWERPC_ULTRAVISOR_API_H */
diff --git a/arch/powerpc/include/asm/ultravisor.h b/arch/powerpc/include/asm/ultravisor.h
index a930aec8c1e3..e6f8a2b96694 100644
--- a/arch/powerpc/include/asm/ultravisor.h
+++ b/arch/powerpc/include/asm/ultravisor.h
@@ -21,4 +21,9 @@ static inline int uv_unshare_page(u64 pfn, u64 npages)
 	return ucall_norets(UV_UNSHARE_PAGE, pfn, npages);
 }
 
+static inline int uv_unshare_all_pages(void)
+{
+	return ucall_norets(UV_UNSHARE_ALL_PAGES);
+}
+
 #endif	/* _ASM_POWERPC_ULTRAVISOR_H */
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 18481b0e2788..04a7cba58eff 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -29,6 +29,8 @@
 #include <asm/smp.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/asm-prototypes.h>
+#include <asm/svm.h>
+#include <asm/ultravisor.h>
 
 int default_machine_kexec_prepare(struct kimage *image)
 {
@@ -327,6 +329,13 @@ void default_machine_kexec(struct kimage *image)
 #ifdef CONFIG_PPC_PSERIES
 	kexec_paca.lppaca_ptr = NULL;
 #endif
+
+	if (is_secure_guest() && !(image->preserve_context ||
+				   image->type == KEXEC_TYPE_CRASH)) {
+		uv_unshare_all_pages();
+		printk("kexec: Unshared all shared pages.\n");
+	}
+
 	paca_ptrs[kexec_paca.paca_index] = &kexec_paca;
 
 	setup_paca(&kexec_paca);
