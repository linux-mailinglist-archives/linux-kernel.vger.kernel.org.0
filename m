Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B914AECFD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 16:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbfIJOcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 10:32:01 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:43138 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfIJOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:32:01 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AER5AB013430;
        Tue, 10 Sep 2019 14:31:47 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ux1w0r181-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 14:31:47 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 1F58863;
        Tue, 10 Sep 2019 14:31:47 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 2AC3E201FCF1D; Tue, 10 Sep 2019 09:31:46 -0500 (CDT)
Message-Id: <20190910143101.582045154@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910143100.962781883@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Tue, 10 Sep 2019 09:31:07 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] x86/platform/uv: Check EFI Boot to set reboot type
Content-Disposition: inline; filename=check-efi-boot
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to checking for EFI Boot type from previous check on if this
is a KDUMP kernel.  This allows for KDUMP kernels that can handle
EFI reboots.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -15,6 +15,7 @@
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <linux/efi.h>
 
 #include <asm/e820/api.h>
 #include <asm/uv/uv_mmrs.h>
@@ -1483,6 +1484,14 @@ static void __init build_socket_tables(v
 	}
 }
 
+/* Check which reboot to use */
+static void check_efi_reboot(void)
+{
+	/* If EFI reboot not available, use ACPI reboot */
+	if (!efi_enabled(EFI_BOOT))
+		reboot_type = BOOT_ACPI;
+}
+
 /* Setup user proc fs files */
 static int proc_hubbed_show(struct seq_file *file, void *data)
 {
@@ -1571,6 +1580,8 @@ static __init int uv_system_init_hubless
 	if (rc >= 0)
 		uv_setup_proc_files(1);
 
+	check_efi_reboot();
+
 	return rc;
 }
 
@@ -1704,12 +1715,7 @@ static void __init uv_system_init_hub(vo
 	/* Register Legacy VGA I/O redirection handler: */
 	pci_register_set_vga_state(uv_set_vga_state);
 
-	/*
-	 * For a kdump kernel the reset must be BOOT_ACPI, not BOOT_EFI, as
-	 * EFI is not enabled in the kdump kernel:
-	 */
-	if (is_kdump_kernel())
-		reboot_type = BOOT_ACPI;
+	check_efi_reboot();
 }
 
 /*

-- 

