Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE1AAED9D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 16:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404674AbfIJOqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 10:46:49 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:56788 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393646AbfIJOql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:46:41 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AEfPNl006462;
        Tue, 10 Sep 2019 14:46:22 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uxbxdsuf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 14:46:22 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 7EAE84E;
        Tue, 10 Sep 2019 14:46:21 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 333FC201FCF21; Tue, 10 Sep 2019 09:46:21 -0500 (CDT)
Message-Id: <20190910144610.181956960@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910144609.909602978@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Tue, 10 Sep 2019 09:46:11 -0500
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
Subject: [PATCH V2 2/8] x86/platform/uv: Return UV Hubless System Type
Content-Disposition: inline; filename=mod-is_uv_hubless
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=827
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return the type of UV hubless system for UV specific code that depends
on that.  Add a function to convert UV system type to bit pattern needed
for is_uv_hubless().

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
V2: Remove is_uv_hubless define
    Remove leading '_' from _is_uv_hubless
---
 arch/x86/include/asm/uv/uv.h       |   12 ++++++++++--
 arch/x86/kernel/apic/x2apic_uv_x.c |   27 ++++++++++++++++++---------
 2 files changed, 28 insertions(+), 11 deletions(-)

--- linux.orig/arch/x86/include/asm/uv/uv.h
+++ linux/arch/x86/include/asm/uv/uv.h
@@ -12,6 +12,14 @@ struct mm_struct;
 #ifdef CONFIG_X86_UV
 #include <linux/efi.h>
 
+static inline int uv(int uvtype)
+{
+	/* uv(0) is "any" */
+	if (uvtype >= 0 && uvtype <= 30)
+		return 1 << uvtype;
+	return 1;
+}
+
 extern unsigned long uv_systab_phys;
 
 extern enum uv_system_type get_uv_system_type(void);
@@ -20,7 +28,7 @@ static inline bool is_early_uv_system(vo
 	return uv_systab_phys && uv_systab_phys != EFI_INVALID_TABLE_ADDR;
 }
 extern int is_uv_system(void);
-extern int is_uv_hubless(void);
+extern int is_uv_hubless(int uvtype);
 extern void uv_cpu_init(void);
 extern void uv_nmi_init(void);
 extern void uv_system_init(void);
@@ -32,7 +40,7 @@ extern const struct cpumask *uv_flush_tl
 static inline enum uv_system_type get_uv_system_type(void) { return UV_NONE; }
 static inline bool is_early_uv_system(void)	{ return 0; }
 static inline int is_uv_system(void)	{ return 0; }
-static inline int is_uv_hubless(void)	{ return 0; }
+static inline int is_uv_hubless(int uv) { return 0; }
 static inline void uv_cpu_init(void)	{ }
 static inline void uv_system_init(void)	{ }
 static inline const struct cpumask *
--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -26,7 +26,7 @@
 static DEFINE_PER_CPU(int, x2apic_extra_bits);
 
 static enum uv_system_type	uv_system_type;
-static bool			uv_hubless_system;
+static int			uv_hubless_system;
 static u64			gru_start_paddr, gru_end_paddr;
 static u64			gru_dist_base, gru_first_node_paddr = -1LL, gru_last_node_paddr;
 static u64			gru_dist_lmask, gru_dist_umask;
@@ -268,11 +268,20 @@ static int __init uv_acpi_madt_oem_check
 	uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
 
 	if (strncmp(oem_id, "SGI", 3) != 0) {
-		if (strncmp(oem_id, "NSGI", 4) == 0) {
-			uv_hubless_system = true;
-			pr_info("UV: OEM IDs %s/%s, HUBLESS\n",
-				oem_id, oem_table_id);
-		}
+		if (strncmp(oem_id, "NSGI", 4) != 0)
+			return 0;
+
+		/* UV4 Hubless, CH, (0x11:UV4+Any) */
+		if (strncmp(oem_id, "NSGI4", 5) == 0)
+			uv_hubless_system = 0x11;
+
+		/* UV3 Hubless, UV300/MC990X w/o hub (0x9:UV3+Any) */
+		else
+			uv_hubless_system = 0x9;
+
+		pr_info("UV: OEM IDs %s/%s, HUBLESS(0x%x)\n",
+			oem_id, oem_table_id, uv_hubless_system);
+
 		return 0;
 	}
 
@@ -350,9 +359,9 @@ int is_uv_system(void)
 }
 EXPORT_SYMBOL_GPL(is_uv_system);
 
-int is_uv_hubless(void)
+int is_uv_hubless(int uvtype)
 {
-	return uv_hubless_system;
+	return (uv_hubless_system & uvtype);
 }
 EXPORT_SYMBOL_GPL(is_uv_hubless);
 
@@ -1592,7 +1601,7 @@ static void __init uv_system_init_hub(vo
  */
 void __init uv_system_init(void)
 {
-	if (likely(!is_uv_system() && !is_uv_hubless()))
+	if (likely(!is_uv_system() && !is_uv_hubless(1)))
 		return;
 
 	if (is_uv_system())

-- 

