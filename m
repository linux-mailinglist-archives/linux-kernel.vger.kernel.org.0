Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC63AE30F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 06:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393102AbfIJEbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 00:31:42 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:35650 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393024AbfIJEb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 00:31:27 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8A4UqoW024374;
        Tue, 10 Sep 2019 04:30:52 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uwnk2epk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 04:30:52 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 8378C89;
        Tue, 10 Sep 2019 04:30:18 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 28072201FCE6F; Mon,  9 Sep 2019 23:30:18 -0500 (CDT)
Message-Id: <20190910042452.082196340@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910042451.795793945@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Mon, 09 Sep 2019 23:24:54 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Mike Travis <mike.travis@hpe.com>
Subject: [PATCH 3/8] x86/platform/uv: Add return code to UV BIOS Init function
Content-Disposition: inline; filename=add-bios_init-rc
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_04:2019-09-09,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a return code to the UV BIOS init function that indicates the 
successful initialization of the kernel/BIOS callback interface.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>
To: H. Peter Anvin <hpa@zytor.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Borislav Petkov <bp@alien8.de>
To: Christoph Hellwig <hch@infradead.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Hedi Berriche <hedi.berriche@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Justin Ernst <justin.ernst@hpe.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/uv/bios.h |    2 +-
 arch/x86/platform/uv/bios_uv.c |    9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

--- linux.orig/arch/x86/include/asm/uv/bios.h
+++ linux/arch/x86/include/asm/uv/bios.h
@@ -138,7 +138,7 @@ extern s64 uv_bios_change_memprotect(u64
 extern s64 uv_bios_reserved_page_pa(u64, u64 *, u64 *, u64 *);
 extern int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus);
 
-extern void uv_bios_init(void);
+extern int uv_bios_init(void);
 
 extern unsigned long sn_rtc_cycles_per_second;
 extern int uv_type;
--- linux.orig/arch/x86/platform/uv/bios_uv.c
+++ linux/arch/x86/platform/uv/bios_uv.c
@@ -184,20 +184,20 @@ int uv_bios_set_legacy_vga_target(bool d
 }
 EXPORT_SYMBOL_GPL(uv_bios_set_legacy_vga_target);
 
-void uv_bios_init(void)
+int uv_bios_init(void)
 {
 	uv_systab = NULL;
 	if ((uv_systab_phys == EFI_INVALID_TABLE_ADDR) ||
 	    !uv_systab_phys || efi_runtime_disabled()) {
 		pr_crit("UV: UVsystab: missing\n");
-		return;
+		return -EEXIST;
 	}
 
 	uv_systab = ioremap(uv_systab_phys, sizeof(struct uv_systab));
 	if (!uv_systab || strncmp(uv_systab->signature, UV_SYSTAB_SIG, 4)) {
 		pr_err("UV: UVsystab: bad signature!\n");
 		iounmap(uv_systab);
-		return;
+		return -EINVAL;
 	}
 
 	/* Starting with UV4 the UV systab size is variable */
@@ -208,8 +208,9 @@ void uv_bios_init(void)
 		uv_systab = ioremap(uv_systab_phys, size);
 		if (!uv_systab) {
 			pr_err("UV: UVsystab: ioremap(%d) failed!\n", size);
-			return;
+			return -EFAULT;
 		}
 	}
 	pr_info("UV: UVsystab: Revision:%x\n", uv_systab->revision);
+	return 0;
 }

-- 

