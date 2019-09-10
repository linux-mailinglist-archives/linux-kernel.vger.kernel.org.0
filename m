Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D8EAE30B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 06:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393032AbfIJEb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 00:31:26 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:47812 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393008AbfIJEbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 00:31:25 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8A4UsfT022332;
        Tue, 10 Sep 2019 04:30:54 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 2uwnda6qqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 04:30:54 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 5030D6A;
        Tue, 10 Sep 2019 04:30:19 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 344F8201FCE7A; Mon,  9 Sep 2019 23:30:18 -0500 (CDT)
Message-Id: <20190910042452.246598518@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910042451.795793945@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Mon, 09 Sep 2019 23:24:56 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Mike Travis <mike.travis@hpe.com>
Subject: [PATCH V2 5/8] x86/platform/uv: Add UV Hubbed/Hubless Proc FS Files
Content-Disposition: inline; filename=add-procfs-files
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_04:2019-09-09,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indicate to UV user utilities that UV hubless support is available on
this system via the existing /proc infterface.  The current interface is
maintained with the addition of new /proc leaves ("hubbed", "hubless",
and "oemid") that contain the specific type of UV arch this one is.

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
V2: Remove is_uv_hubbed define
    Remove leading '_' from _is_uv_hubbed
---
 arch/x86/include/asm/uv/uv.h       |    4 +
 arch/x86/kernel/apic/x2apic_uv_x.c |   93 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 1 deletion(-)

--- linux.orig/arch/x86/include/asm/uv/uv.h
+++ linux/arch/x86/include/asm/uv/uv.h
@@ -12,6 +12,8 @@ struct mm_struct;
 #ifdef CONFIG_X86_UV
 #include <linux/efi.h>
 
+#define	UV_PROC_NODE	"sgi_uv"
+
 static inline int uv(int uvtype)
 {
 	/* uv(0) is "any" */
@@ -28,6 +30,7 @@ static inline bool is_early_uv_system(vo
 	return uv_systab_phys && uv_systab_phys != EFI_INVALID_TABLE_ADDR;
 }
 extern int is_uv_system(void);
+extern int is_uv_hubbed(int uvtype);
 extern int is_uv_hubless(int uvtype);
 extern void uv_cpu_init(void);
 extern void uv_nmi_init(void);
@@ -40,6 +43,7 @@ extern const struct cpumask *uv_flush_tl
 static inline enum uv_system_type get_uv_system_type(void) { return UV_NONE; }
 static inline bool is_early_uv_system(void)	{ return 0; }
 static inline int is_uv_system(void)	{ return 0; }
+static inline int is_uv_hubbed(int uv)	{ return 0; }
 static inline int is_uv_hubless(int uv) { return 0; }
 static inline void uv_cpu_init(void)	{ }
 static inline void uv_system_init(void)	{ }
--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -26,6 +26,7 @@
 static DEFINE_PER_CPU(int, x2apic_extra_bits);
 
 static enum uv_system_type	uv_system_type;
+static int			uv_hubbed_system;
 static int			uv_hubless_system;
 static u64			gru_start_paddr, gru_end_paddr;
 static u64			gru_dist_base, gru_first_node_paddr = -1LL, gru_last_node_paddr;
@@ -309,6 +310,24 @@ static int __init uv_acpi_madt_oem_check
 	if (uv_hub_info->hub_revision == 0)
 		goto badbios;
 
+	switch (uv_hub_info->hub_revision) {
+	case UV4_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x11;
+		break;
+
+	case UV3_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x9;
+		break;
+
+	case UV2_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x5;
+		break;
+
+	case UV1_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x3;
+		break;
+	}
+
 	pnodeid = early_get_pnodeid();
 	early_get_apic_socketid_shift();
 
@@ -359,6 +378,12 @@ int is_uv_system(void)
 }
 EXPORT_SYMBOL_GPL(is_uv_system);
 
+int is_uv_hubbed(int uvtype)
+{
+	return (uv_hubbed_system & uvtype);
+}
+EXPORT_SYMBOL_GPL(is_uv_hubbed);
+
 int is_uv_hubless(int uvtype)
 {
 	return (uv_hubless_system & uvtype);
@@ -1457,6 +1482,68 @@ static void __init build_socket_tables(v
 	}
 }
 
+/* Setup user proc fs files */
+static int proc_hubbed_show(struct seq_file *file, void *data)
+{
+	seq_printf(file, "0x%x\n", uv_hubbed_system);
+	return 0;
+}
+
+static int proc_hubless_show(struct seq_file *file, void *data)
+{
+	seq_printf(file, "0x%x\n", uv_hubless_system);
+	return 0;
+}
+
+static int proc_oemid_show(struct seq_file *file, void *data)
+{
+	seq_printf(file, "%s/%s\n", oem_id, oem_table_id);
+	return 0;
+}
+
+static int proc_hubbed_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_hubbed_show, (void *)NULL);
+}
+
+static int proc_hubless_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_hubless_show, (void *)NULL);
+}
+
+static int proc_oemid_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_oemid_show, (void *)NULL);
+}
+
+/* (struct is "non-const" as open function is set at runtime) */
+static struct file_operations proc_version_fops = {
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_oemid_fops = {
+	.open		= proc_oemid_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static __init void uv_setup_proc_files(int hubless)
+{
+	struct proc_dir_entry *pde;
+	char *name = hubless ? "hubless" : "hubbed";
+
+	pde = proc_mkdir(UV_PROC_NODE, NULL);
+	proc_create("oemid", 0, pde, &proc_oemid_fops);
+	proc_create(name, 0, pde, &proc_version_fops);
+	if (hubless)
+		proc_version_fops.open = proc_hubless_open;
+	else
+		proc_version_fops.open = proc_hubbed_open;
+}
+
 /* Initialize UV hubless systems */
 static __init int uv_system_init_hubless(void)
 {
@@ -1468,6 +1555,10 @@ static __init int uv_system_init_hubless
 	/* Init kernel/BIOS interface */
 	rc = uv_bios_init();
 
+	/* Create user access node if UVsystab available */
+	if (rc >= 0)
+		uv_setup_proc_files(1);
+
 	return rc;
 }
 
@@ -1596,7 +1687,7 @@ static void __init uv_system_init_hub(vo
 	uv_nmi_setup();
 	uv_cpu_init();
 	uv_scir_register_cpu_notifier();
-	proc_mkdir("sgi_uv", NULL);
+	uv_setup_proc_files(0);
 
 	/* Register Legacy VGA I/O redirection handler: */
 	pci_register_set_vga_state(uv_set_vga_state);

-- 

