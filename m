Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28429B01B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfIKQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 12:35:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728828AbfIKQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:35:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8BGWPbE008827;
        Wed, 11 Sep 2019 12:34:53 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uy4351360-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 12:34:53 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8BGTSmU023056;
        Wed, 11 Sep 2019 16:34:52 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 2uv467cjdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 16:34:52 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8BGYpIU13632112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 16:34:52 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3663112061;
        Wed, 11 Sep 2019 16:34:51 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4A87112063;
        Wed, 11 Sep 2019 16:34:49 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.164.37])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Sep 2019 16:34:49 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH] powerpc/prom_init: Undo relocation before entering secure mode
Date:   Wed, 11 Sep 2019 13:34:33 -0300
Message-Id: <20190911163433.12822-1-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=982 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909110152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ultravisor will do an integrity check of the kernel image but we
relocated it so the check will fail. Restore the original image by
relocating it back to the kernel virtual base address.

This works because during build vmlinux is linked with an expected virtual
runtime address of KERNELBASE.

Fixes: 6a9c930bd775 ("powerpc/prom_init: Add the ESM call to prom_init")
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/elf.h         |  3 +++
 arch/powerpc/kernel/prom_init.c        | 11 +++++++++++
 arch/powerpc/kernel/prom_init_check.sh |  3 ++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 409c9bfb43d9..57c229a86f08 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -175,4 +175,7 @@ do {									\
 	ARCH_DLINFO_CACHE_GEOMETRY;					\
 } while (0)
 
+/* Relocate the kernel image to @final_address */
+void relocate(unsigned long final_address);
+
 #endif /* _ASM_POWERPC_ELF_H */
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 74f70f90eff0..44b1d404250e 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -3249,7 +3249,18 @@ static void setup_secure_guest(unsigned long kbase, unsigned long fdt)
 	/* Switch to secure mode. */
 	prom_printf("Switching to secure mode.\n");
 
+	/*
+	 * The ultravisor will do an integrity check of the kernel image but we
+	 * relocated it so the check will fail. Restore the original image by
+	 * relocating it back to the kernel virtual base address.
+	 */
+	relocate(KERNELBASE);
+
 	ret = enter_secure_mode(kbase, fdt);
+
+	/* Relocate the kernel again. */
+	relocate(kbase);
+
 	if (ret != U_SUCCESS) {
 		prom_printf("Returned %d from switching to secure mode.\n", ret);
 		prom_rtas_os_term("Switch to secure mode failed.\n");
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 160bef0d553d..16535ccc0fa0 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -26,7 +26,8 @@ _end enter_prom $MEM_FUNCS reloc_offset __secondary_hold
 __secondary_hold_acknowledge __secondary_hold_spinloop __start
 logo_linux_clut224 btext_prepare_BAT
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
-__prom_init_toc_start __prom_init_toc_end btext_setup_display TOC."
+__prom_init_toc_start __prom_init_toc_end btext_setup_display TOC.
+relocate"
 
 NM="$1"
 OBJ="$2"
