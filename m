Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2DB7EEA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 10:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404039AbfHBIRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 04:17:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403969AbfHBIQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:16:57 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85486FCA03BCEE2FA397;
        Fri,  2 Aug 2019 16:16:55 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 2 Aug 2019 16:16:45 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v3 6/7] crypto: hisilicon - add debugfs for ZIP and QM
Date:   Fri, 2 Aug 2019 15:57:55 +0800
Message-ID: <1564732676-35987-7-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1564732676-35987-1-git-send-email-wangzhou1@hisilicon.com>
References: <1564732676-35987-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiSilicon ZIP engine driver uses debugfs to provide debug information,
the usage can be found in /Documentation/ABI/testing/debugfs-hisi-zip.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/qm.c           | 301 +++++++++++++++++++++++++
 drivers/crypto/hisilicon/qm.h           |  29 +++
 drivers/crypto/hisilicon/zip/zip_main.c | 375 +++++++++++++++++++++++++++++++-
 3 files changed, 704 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 4f6bbdd..363f71b 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -2,10 +2,12 @@
 /* Copyright (c) 2019 HiSilicon Limited. */
 #include <asm/page.h>
 #include <linux/bitmap.h>
+#include <linux/debugfs.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/irqreturn.h>
 #include <linux/log2.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include "qm.h"
 
@@ -114,6 +116,7 @@
 #define QM_SQC_VFT_NUM_SHIFT_V2		45
 #define QM_SQC_VFT_NUM_MASK_v2		GENMASK(9, 0)
 
+#define QM_DFX_CNT_CLR_CE		0x100118
 
 #define QM_ABNORMAL_INT_SOURCE		0x100000
 #define QM_ABNORMAL_INT_MASK		0x100004
@@ -141,6 +144,7 @@
 #define QM_SQE_DATA_ALIGN_MASK		GENMASK(6, 0)
 #define QMC_ALIGN(sz)			ALIGN(sz, 32)
 
+#define QM_DBG_TMP_BUF_LEN		22
 
 #define QM_MK_CQC_DW3_V1(hop_num, pg_sz, buf_sz, cqe_sz) \
 	(((hop_num) << QM_CQ_HOP_NUM_SHIFT)	| \
@@ -270,11 +274,17 @@ struct hisi_qm_hw_ops {
 	void (*qm_db)(struct hisi_qm *qm, u16 qn,
 		      u8 cmd, u16 index, u8 priority);
 	u32 (*get_irq_num)(struct hisi_qm *qm);
+	int (*debug_init)(struct hisi_qm *qm);
 	void (*hw_error_init)(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe,
 			      u32 msi);
 	pci_ers_result_t (*hw_error_handle)(struct hisi_qm *qm);
 };
 
+static const char * const qm_debug_file_name[] = {
+	[CURRENT_Q]    = "current_q",
+	[CLEAR_ENABLE] = "clear_enable",
+};
+
 struct hisi_qm_hw_error {
 	u32 int_msk;
 	const char *msg;
@@ -744,6 +754,229 @@ static int qm_get_vft_v2(struct hisi_qm *qm, u32 *base, u32 *number)
 	return 0;
 }
 
+static struct hisi_qm *file_to_qm(struct debugfs_file *file)
+{
+	struct qm_debug *debug = file->debug;
+
+	return container_of(debug, struct hisi_qm, debug);
+}
+
+static u32 current_q_read(struct debugfs_file *file)
+{
+	struct hisi_qm *qm = file_to_qm(file);
+
+	return readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) >> QM_DFX_QN_SHIFT;
+}
+
+static int current_q_write(struct debugfs_file *file, u32 val)
+{
+	struct hisi_qm *qm = file_to_qm(file);
+	u32 tmp;
+
+	if (val >= qm->debug.curr_qm_qp_num)
+		return -EINVAL;
+
+	tmp = val << QM_DFX_QN_SHIFT |
+	      (readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) & CURRENT_FUN_MASK);
+	writel(tmp, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
+
+	tmp = val << QM_DFX_QN_SHIFT |
+	      (readl(qm->io_base + QM_DFX_CQE_CNT_VF_CQN) & CURRENT_FUN_MASK);
+	writel(tmp, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
+
+	return 0;
+}
+
+static u32 clear_enable_read(struct debugfs_file *file)
+{
+	struct hisi_qm *qm = file_to_qm(file);
+
+	return readl(qm->io_base + QM_DFX_CNT_CLR_CE);
+}
+
+/* rd_clr_ctrl 1 enable read clear, otherwise 0 disable it */
+static int clear_enable_write(struct debugfs_file *file, u32 rd_clr_ctrl)
+{
+	struct hisi_qm *qm = file_to_qm(file);
+
+	if (rd_clr_ctrl > 1)
+		return -EINVAL;
+
+	writel(rd_clr_ctrl, qm->io_base + QM_DFX_CNT_CLR_CE);
+
+	return 0;
+}
+
+static ssize_t qm_debug_read(struct file *filp, char __user *buf,
+			     size_t count, loff_t *pos)
+{
+	struct debugfs_file *file = filp->private_data;
+	enum qm_debug_file index = file->index;
+	char tbuf[QM_DBG_TMP_BUF_LEN];
+	u32 val;
+	int ret;
+
+	mutex_lock(&file->lock);
+	switch (index) {
+	case CURRENT_Q:
+		val = current_q_read(file);
+		break;
+	case CLEAR_ENABLE:
+		val = clear_enable_read(file);
+		break;
+	default:
+		mutex_unlock(&file->lock);
+		return -EINVAL;
+	}
+	mutex_unlock(&file->lock);
+	ret = sprintf(tbuf, "%u\n", val);
+	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+}
+
+static ssize_t qm_debug_write(struct file *filp, const char __user *buf,
+			      size_t count, loff_t *pos)
+{
+	struct debugfs_file *file = filp->private_data;
+	enum qm_debug_file index = file->index;
+	unsigned long val;
+	char tbuf[QM_DBG_TMP_BUF_LEN];
+	int len, ret;
+
+	if (*pos != 0)
+		return 0;
+
+	if (count >= QM_DBG_TMP_BUF_LEN)
+		return -ENOSPC;
+
+	len = simple_write_to_buffer(tbuf, QM_DBG_TMP_BUF_LEN - 1, pos, buf,
+				     count);
+	if (len < 0)
+		return len;
+
+	tbuf[len] = '\0';
+	if (kstrtoul(tbuf, 0, &val))
+		return -EFAULT;
+
+	mutex_lock(&file->lock);
+	switch (index) {
+	case CURRENT_Q:
+		ret = current_q_write(file, val);
+		if (ret)
+			goto err_input;
+		break;
+	case CLEAR_ENABLE:
+		ret = clear_enable_write(file, val);
+		if (ret)
+			goto err_input;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_input;
+	}
+	mutex_unlock(&file->lock);
+
+	return count;
+
+err_input:
+	mutex_unlock(&file->lock);
+	return ret;
+}
+
+static const struct file_operations qm_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = qm_debug_read,
+	.write = qm_debug_write,
+};
+
+struct qm_dfx_registers {
+	char  *reg_name;
+	u64   reg_offset;
+};
+
+#define CNT_CYC_REGS_NUM		10
+static struct qm_dfx_registers qm_dfx_regs[] = {
+	/* XXX_CNT are reading clear register */
+	{"QM_ECC_1BIT_CNT               ",  0x104000ull},
+	{"QM_ECC_MBIT_CNT               ",  0x104008ull},
+	{"QM_DFX_MB_CNT                 ",  0x104018ull},
+	{"QM_DFX_DB_CNT                 ",  0x104028ull},
+	{"QM_DFX_SQE_CNT                ",  0x104038ull},
+	{"QM_DFX_CQE_CNT                ",  0x104048ull},
+	{"QM_DFX_SEND_SQE_TO_ACC_CNT    ",  0x104050ull},
+	{"QM_DFX_WB_SQE_FROM_ACC_CNT    ",  0x104058ull},
+	{"QM_DFX_ACC_FINISH_CNT         ",  0x104060ull},
+	{"QM_DFX_CQE_ERR_CNT            ",  0x1040b4ull},
+	{"QM_DFX_FUNS_ACTIVE_ST         ",  0x200ull},
+	{"QM_ECC_1BIT_INF               ",  0x104004ull},
+	{"QM_ECC_MBIT_INF               ",  0x10400cull},
+	{"QM_DFX_ACC_RDY_VLD0           ",  0x1040a0ull},
+	{"QM_DFX_ACC_RDY_VLD1           ",  0x1040a4ull},
+	{"QM_DFX_AXI_RDY_VLD            ",  0x1040a8ull},
+	{"QM_DFX_FF_ST0                 ",  0x1040c8ull},
+	{"QM_DFX_FF_ST1                 ",  0x1040ccull},
+	{"QM_DFX_FF_ST2                 ",  0x1040d0ull},
+	{"QM_DFX_FF_ST3                 ",  0x1040d4ull},
+	{"QM_DFX_FF_ST4                 ",  0x1040d8ull},
+	{"QM_DFX_FF_ST5                 ",  0x1040dcull},
+	{"QM_DFX_FF_ST6                 ",  0x1040e0ull},
+	{"QM_IN_IDLE_ST                 ",  0x1040e4ull},
+	{ NULL, 0}
+};
+
+static struct qm_dfx_registers qm_vf_dfx_regs[] = {
+	{"QM_DFX_FUNS_ACTIVE_ST         ",  0x200ull},
+	{ NULL, 0}
+};
+
+static int qm_regs_show(struct seq_file *s, void *unused)
+{
+	struct hisi_qm *qm = s->private;
+	struct qm_dfx_registers *regs;
+	u32 val;
+
+	if (qm->fun_type == QM_HW_PF)
+		regs = qm_dfx_regs;
+	else
+		regs = qm_vf_dfx_regs;
+
+	while (regs->reg_name) {
+		val = readl(qm->io_base + regs->reg_offset);
+		seq_printf(s, "%s= 0x%08x\n", regs->reg_name, val);
+		regs++;
+	}
+
+	return 0;
+}
+
+static int qm_regs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, qm_regs_show, inode->i_private);
+}
+
+static const struct file_operations qm_regs_fops = {
+	.owner = THIS_MODULE,
+	.open = qm_regs_open,
+	.read = seq_read,
+};
+
+static int qm_create_debugfs_file(struct hisi_qm *qm, enum qm_debug_file index)
+{
+	struct dentry *qm_d = qm->debug.qm_d, *tmp;
+	struct debugfs_file *file = qm->debug.files + index;
+
+	tmp = debugfs_create_file(qm_debug_file_name[index], 0600, qm_d, file,
+				  &qm_debug_fops);
+	if (IS_ERR(tmp))
+		return -ENOENT;
+
+	file->index = index;
+	mutex_init(&file->lock);
+	file->debug = &qm->debug;
+
+	return 0;
+}
+
 static void qm_hw_error_init_v1(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe,
 				u32 msi)
 {
@@ -1539,6 +1772,74 @@ int hisi_qm_stop(struct hisi_qm *qm)
 EXPORT_SYMBOL_GPL(hisi_qm_stop);
 
 /**
+ * hisi_qm_debug_init() - Initialize qm related debugfs files.
+ * @qm: The qm for which we want to add debugfs files.
+ *
+ * Create qm related debugfs files.
+ */
+int hisi_qm_debug_init(struct hisi_qm *qm)
+{
+	struct dentry *qm_d, *qm_regs;
+	int i, ret;
+
+	qm_d = debugfs_create_dir("qm", qm->debug.debug_root);
+	if (IS_ERR(qm_d))
+		return -ENOENT;
+	qm->debug.qm_d = qm_d;
+
+	/* only show this in PF */
+	if (qm->fun_type == QM_HW_PF)
+		for (i = CURRENT_Q; i < DEBUG_FILE_NUM; i++)
+			if (qm_create_debugfs_file(qm, i)) {
+				ret = -ENOENT;
+				goto failed_to_create;
+			}
+
+	qm_regs = debugfs_create_file("qm_regs", 0444, qm->debug.qm_d, qm,
+				      &qm_regs_fops);
+	if (IS_ERR(qm_regs)) {
+		ret = -ENOENT;
+		goto failed_to_create;
+	}
+
+	return 0;
+
+failed_to_create:
+	debugfs_remove_recursive(qm_d);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_qm_debug_init);
+
+/**
+ * hisi_qm_debug_regs_clear() - clear qm debug related registers.
+ * @qm: The qm for which we want to clear its debug registers.
+ */
+void hisi_qm_debug_regs_clear(struct hisi_qm *qm)
+{
+	struct qm_dfx_registers *regs;
+	int i;
+
+	/* clear current_q */
+	writel(0x0, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
+	writel(0x0, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
+
+	/*
+	 * these registers are reading and clearing, so clear them after
+	 * reading them.
+	 */
+	writel(0x1, qm->io_base + QM_DFX_CNT_CLR_CE);
+
+	regs = qm_dfx_regs;
+	for (i = 0; i < CNT_CYC_REGS_NUM; i++) {
+		readl(qm->io_base + regs->reg_offset);
+		regs++;
+	}
+
+	writel(0x0, qm->io_base + QM_DFX_CNT_CLR_CE);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_debug_regs_clear);
+
+/**
  * hisi_qm_hw_error_init() - Configure qm hardware error report method.
  * @qm: The qm which we want to configure.
  * @ce: Bit mask of correctable error configure.
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 8b3cb69..70e672ae 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -46,6 +46,13 @@
 #define PEH_AXUSER_CFG			0x401001
 #define PEH_AXUSER_CFG_ENABLE		0xffffffff
 
+#define QM_DFX_MB_CNT_VF		0x104010
+#define QM_DFX_DB_CNT_VF		0x104020
+#define QM_DFX_SQE_CNT_VF_SQN		0x104030
+#define QM_DFX_CQE_CNT_VF_CQN		0x104040
+#define QM_DFX_QN_SHIFT			16
+#define CURRENT_FUN_MASK		GENMASK(5, 0)
+#define CURRENT_Q_MASK			GENMASK(31, 16)
 
 #define QM_AXI_RRESP			BIT(0)
 #define QM_AXI_BRESP			BIT(1)
@@ -83,6 +90,25 @@ enum qm_fun_type {
 	QM_HW_VF,
 };
 
+enum qm_debug_file {
+	CURRENT_Q,
+	CLEAR_ENABLE,
+	DEBUG_FILE_NUM,
+};
+
+struct debugfs_file {
+	enum qm_debug_file index;
+	struct mutex lock;
+	struct qm_debug *debug;
+};
+
+struct qm_debug {
+	u32 curr_qm_qp_num;
+	struct dentry *debug_root;
+	struct dentry *qm_d;
+	struct debugfs_file files[DEBUG_FILE_NUM];
+};
+
 struct qm_dma {
 	void *va;
 	dma_addr_t dma;
@@ -128,6 +154,8 @@ struct hisi_qm {
 
 	const struct hisi_qm_hw_ops *ops;
 
+	struct qm_debug debug;
+
 	u32 error_mask;
 	u32 msi_mask;
 
@@ -183,4 +211,5 @@ void hisi_qm_hw_error_init(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe,
 			   u32 msi);
 int hisi_qm_hw_error_handle(struct hisi_qm *qm);
 enum qm_hw_ver hisi_qm_get_hw_version(struct pci_dev *pdev);
+void hisi_qm_debug_regs_clear(struct hisi_qm *qm);
 #endif
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index b3e4f1a..6e0ca75 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -3,11 +3,13 @@
 #include <linux/acpi.h>
 #include <linux/aer.h>
 #include <linux/bitops.h>
+#include <linux/debugfs.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/seq_file.h>
 #include <linux/topology.h>
 #include "zip.h"
 
@@ -32,6 +34,7 @@
 					 DECOMP2_ENABLE | DECOMP3_ENABLE | \
 					 DECOMP4_ENABLE | DECOMP5_ENABLE)
 #define DECOMP_CHECK_ENABLE		BIT(16)
+#define HZIP_FSM_MAX_CNT		0x301008
 
 #define HZIP_PORT_ARCA_CHE_0		0x301040
 #define HZIP_PORT_ARCA_CHE_1		0x301044
@@ -45,7 +48,16 @@
 #define HZIP_DATA_WUSER_32_63		0x301134
 #define HZIP_BD_WUSER_32_63		0x301140
 
+#define HZIP_QM_IDEL_STATUS		0x3040e4
 
+#define HZIP_CORE_DEBUG_COMP_0		0x302000
+#define HZIP_CORE_DEBUG_COMP_1		0x303000
+#define HZIP_CORE_DEBUG_DECOMP_0	0x304000
+#define HZIP_CORE_DEBUG_DECOMP_1	0x305000
+#define HZIP_CORE_DEBUG_DECOMP_2	0x306000
+#define HZIP_CORE_DEBUG_DECOMP_3	0x307000
+#define HZIP_CORE_DEBUG_DECOMP_4	0x308000
+#define HZIP_CORE_DEBUG_DECOMP_5	0x309000
 
 #define HZIP_CORE_INT_SOURCE		0x3010A0
 #define HZIP_CORE_INT_MASK		0x3010A4
@@ -55,14 +67,23 @@
 #define SRAM_ECC_ERR_NUM_SHIFT		16
 #define SRAM_ECC_ERR_ADDR_SHIFT		24
 #define HZIP_CORE_INT_DISABLE		0x000007FF
+#define HZIP_COMP_CORE_NUM		2
+#define HZIP_DECOMP_CORE_NUM		6
+#define HZIP_CORE_NUM			(HZIP_COMP_CORE_NUM + \
+					 HZIP_DECOMP_CORE_NUM)
 #define HZIP_SQE_SIZE			128
+#define HZIP_SQ_SIZE			(HZIP_SQE_SIZE * QM_Q_DEPTH)
 #define HZIP_PF_DEF_Q_NUM		64
 #define HZIP_PF_DEF_Q_BASE		0
 
+#define HZIP_SOFT_CTRL_CNT_CLR_CE	0x301000
+#define SOFT_CTRL_CNT_CLR_CE_BIT	BIT(0)
 
 #define HZIP_NUMA_DISTANCE		100
+#define HZIP_BUF_SIZE			22
 
 static const char hisi_zip_name[] = "hisi_zip";
+static struct dentry *hzip_debugfs_root;
 LIST_HEAD(hisi_zip_list);
 DEFINE_MUTEX(hisi_zip_list_lock);
 
@@ -121,6 +142,23 @@ static const struct hisi_zip_hw_error zip_hw_error[] = {
 	{ /* sentinel */ }
 };
 
+enum ctrl_debug_file_index {
+	HZIP_CURRENT_QM,
+	HZIP_CLEAR_ENABLE,
+	HZIP_DEBUG_FILE_NUM,
+};
+
+static const char * const ctrl_debug_file_name[] = {
+	[HZIP_CURRENT_QM]   = "current_qm",
+	[HZIP_CLEAR_ENABLE] = "clear_enable",
+};
+
+struct ctrl_debug_file {
+	enum ctrl_debug_file_index index;
+	spinlock_t lock;
+	struct hisi_zip_ctrl *ctrl;
+};
+
 /*
  * One ZIP controller has one PF and multiple VFs, some global configurations
  * which PF has need this structure.
@@ -130,6 +168,55 @@ static const struct hisi_zip_hw_error zip_hw_error[] = {
 struct hisi_zip_ctrl {
 	u32 num_vfs;
 	struct hisi_zip *hisi_zip;
+	struct dentry *debug_root;
+	struct ctrl_debug_file files[HZIP_DEBUG_FILE_NUM];
+};
+
+enum {
+	HZIP_COMP_CORE0,
+	HZIP_COMP_CORE1,
+	HZIP_DECOMP_CORE0,
+	HZIP_DECOMP_CORE1,
+	HZIP_DECOMP_CORE2,
+	HZIP_DECOMP_CORE3,
+	HZIP_DECOMP_CORE4,
+	HZIP_DECOMP_CORE5,
+};
+
+static const u64 core_offsets[] = {
+	[HZIP_COMP_CORE0]   = 0x302000,
+	[HZIP_COMP_CORE1]   = 0x303000,
+	[HZIP_DECOMP_CORE0] = 0x304000,
+	[HZIP_DECOMP_CORE1] = 0x305000,
+	[HZIP_DECOMP_CORE2] = 0x306000,
+	[HZIP_DECOMP_CORE3] = 0x307000,
+	[HZIP_DECOMP_CORE4] = 0x308000,
+	[HZIP_DECOMP_CORE5] = 0x309000,
+};
+
+static struct debugfs_reg32 hzip_dfx_regs[] = {
+	{"HZIP_GET_BD_NUM                ",  0x00ull},
+	{"HZIP_GET_RIGHT_BD              ",  0x04ull},
+	{"HZIP_GET_ERROR_BD              ",  0x08ull},
+	{"HZIP_DONE_BD_NUM               ",  0x0cull},
+	{"HZIP_WORK_CYCLE                ",  0x10ull},
+	{"HZIP_IDLE_CYCLE                ",  0x18ull},
+	{"HZIP_MAX_DELAY                 ",  0x20ull},
+	{"HZIP_MIN_DELAY                 ",  0x24ull},
+	{"HZIP_AVG_DELAY                 ",  0x28ull},
+	{"HZIP_MEM_VISIBLE_DATA          ",  0x30ull},
+	{"HZIP_MEM_VISIBLE_ADDR          ",  0x34ull},
+	{"HZIP_COMSUMED_BYTE             ",  0x38ull},
+	{"HZIP_PRODUCED_BYTE             ",  0x40ull},
+	{"HZIP_COMP_INF                  ",  0x70ull},
+	{"HZIP_PRE_OUT                   ",  0x78ull},
+	{"HZIP_BD_RD                     ",  0x7cull},
+	{"HZIP_BD_WR                     ",  0x80ull},
+	{"HZIP_GET_BD_AXI_ERR_NUM        ",  0x84ull},
+	{"HZIP_GET_BD_PARSE_ERR_NUM      ",  0x88ull},
+	{"HZIP_ADD_BD_AXI_ERR_NUM        ",  0x8cull},
+	{"HZIP_DECOMP_STF_RELOAD_CURR_ST ",  0x94ull},
+	{"HZIP_DECOMP_LZ77_CURR_ST       ",  0x9cull},
 };
 
 static int pf_q_num_set(const char *val, const struct kernel_param *kp)
@@ -266,6 +353,265 @@ static void hisi_zip_hw_error_set_state(struct hisi_zip *hisi_zip, bool state)
 	}
 }
 
+static inline struct hisi_qm *file_to_qm(struct ctrl_debug_file *file)
+{
+	struct hisi_zip *hisi_zip = file->ctrl->hisi_zip;
+
+	return &hisi_zip->qm;
+}
+
+static u32 current_qm_read(struct ctrl_debug_file *file)
+{
+	struct hisi_qm *qm = file_to_qm(file);
+
+	return readl(qm->io_base + QM_DFX_MB_CNT_VF);
+}
+
+static int current_qm_write(struct ctrl_debug_file *file, u32 val)
+{
+	struct hisi_qm *qm = file_to_qm(file);
+	struct hisi_zip_ctrl *ctrl = file->ctrl;
+	u32 vfq_num;
+	u32 tmp;
+
+	if (val > ctrl->num_vfs)
+		return -EINVAL;
+
+	/* Calculate curr_qm_qp_num and store */
+	if (val == 0) {
+		qm->debug.curr_qm_qp_num = qm->qp_num;
+	} else {
+		vfq_num = (qm->ctrl_qp_num - qm->qp_num) / ctrl->num_vfs;
+		if (val == ctrl->num_vfs)
+			qm->debug.curr_qm_qp_num = qm->ctrl_qp_num -
+				qm->qp_num - (ctrl->num_vfs - 1) * vfq_num;
+		else
+			qm->debug.curr_qm_qp_num = vfq_num;
+	}
+
+	writel(val, qm->io_base + QM_DFX_MB_CNT_VF);
+	writel(val, qm->io_base + QM_DFX_DB_CNT_VF);
+
+	tmp = val |
+	      (readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) & CURRENT_Q_MASK);
+	writel(tmp, qm->io_base + QM_DFX_SQE_CNT_VF_SQN);
+
+	tmp = val |
+	      (readl(qm->io_base + QM_DFX_CQE_CNT_VF_CQN) & CURRENT_Q_MASK);
+	writel(tmp, qm->io_base + QM_DFX_CQE_CNT_VF_CQN);
+
+	return  0;
+}
+
+static u32 clear_enable_read(struct ctrl_debug_file *file)
+{
+	struct hisi_qm *qm = file_to_qm(file);
+
+	return readl(qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE) &
+	       SOFT_CTRL_CNT_CLR_CE_BIT;
+}
+
+static int clear_enable_write(struct ctrl_debug_file *file, u32 val)
+{
+	struct hisi_qm *qm = file_to_qm(file);
+	u32 tmp;
+
+	if (val != 1 && val != 0)
+		return -EINVAL;
+
+	tmp = (readl(qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE) &
+	       ~SOFT_CTRL_CNT_CLR_CE_BIT) | val;
+	writel(tmp, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);
+
+	return  0;
+}
+
+static ssize_t ctrl_debug_read(struct file *filp, char __user *buf,
+			       size_t count, loff_t *pos)
+{
+	struct ctrl_debug_file *file = filp->private_data;
+	char tbuf[HZIP_BUF_SIZE];
+	u32 val;
+	int ret;
+
+	spin_lock_irq(&file->lock);
+	switch (file->index) {
+	case HZIP_CURRENT_QM:
+		val = current_qm_read(file);
+		break;
+	case HZIP_CLEAR_ENABLE:
+		val = clear_enable_read(file);
+		break;
+	default:
+		spin_unlock_irq(&file->lock);
+		return -EINVAL;
+	}
+	spin_unlock_irq(&file->lock);
+	ret = sprintf(tbuf, "%u\n", val);
+	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+}
+
+static ssize_t ctrl_debug_write(struct file *filp, const char __user *buf,
+				size_t count, loff_t *pos)
+{
+	struct ctrl_debug_file *file = filp->private_data;
+	char tbuf[HZIP_BUF_SIZE];
+	unsigned long val;
+	int len, ret;
+
+	if (*pos != 0)
+		return 0;
+
+	if (count >= HZIP_BUF_SIZE)
+		return -ENOSPC;
+
+	len = simple_write_to_buffer(tbuf, HZIP_BUF_SIZE - 1, pos, buf, count);
+	if (len < 0)
+		return len;
+
+	tbuf[len] = '\0';
+	if (kstrtoul(tbuf, 0, &val))
+		return -EFAULT;
+
+	spin_lock_irq(&file->lock);
+	switch (file->index) {
+	case HZIP_CURRENT_QM:
+		ret = current_qm_write(file, val);
+		if (ret)
+			goto err_input;
+		break;
+	case HZIP_CLEAR_ENABLE:
+		ret = clear_enable_write(file, val);
+		if (ret)
+			goto err_input;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_input;
+	}
+	spin_unlock_irq(&file->lock);
+
+	return count;
+
+err_input:
+	spin_unlock_irq(&file->lock);
+	return ret;
+}
+
+static const struct file_operations ctrl_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = ctrl_debug_read,
+	.write = ctrl_debug_write,
+};
+
+static int hisi_zip_core_debug_init(struct hisi_zip_ctrl *ctrl)
+{
+	struct hisi_zip *hisi_zip = ctrl->hisi_zip;
+	struct hisi_qm *qm = &hisi_zip->qm;
+	struct device *dev = &qm->pdev->dev;
+	struct debugfs_regset32 *regset;
+	struct dentry *tmp_d, *tmp;
+	char buf[HZIP_BUF_SIZE];
+	int i;
+
+	for (i = 0; i < HZIP_CORE_NUM; i++) {
+		if (i < HZIP_COMP_CORE_NUM)
+			sprintf(buf, "comp_core%d", i);
+		else
+			sprintf(buf, "decomp_core%d", i - HZIP_COMP_CORE_NUM);
+
+		tmp_d = debugfs_create_dir(buf, ctrl->debug_root);
+		if (!tmp_d)
+			return -ENOENT;
+
+		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
+		if (!regset)
+			return -ENOENT;
+
+		regset->regs = hzip_dfx_regs;
+		regset->nregs = ARRAY_SIZE(hzip_dfx_regs);
+		regset->base = qm->io_base + core_offsets[i];
+
+		tmp = debugfs_create_regset32("regs", 0444, tmp_d, regset);
+		if (!tmp)
+			return -ENOENT;
+	}
+
+	return 0;
+}
+
+static int hisi_zip_ctrl_debug_init(struct hisi_zip_ctrl *ctrl)
+{
+	struct dentry *tmp;
+	int i;
+
+	for (i = HZIP_CURRENT_QM; i < HZIP_DEBUG_FILE_NUM; i++) {
+		spin_lock_init(&ctrl->files[i].lock);
+		ctrl->files[i].ctrl = ctrl;
+		ctrl->files[i].index = i;
+
+		tmp = debugfs_create_file(ctrl_debug_file_name[i], 0600,
+					  ctrl->debug_root, ctrl->files + i,
+					  &ctrl_debug_fops);
+		if (!tmp)
+			return -ENOENT;
+	}
+
+	return hisi_zip_core_debug_init(ctrl);
+}
+
+static int hisi_zip_debugfs_init(struct hisi_zip *hisi_zip)
+{
+	struct hisi_qm *qm = &hisi_zip->qm;
+	struct device *dev = &qm->pdev->dev;
+	struct dentry *dev_d;
+	int ret;
+
+	dev_d = debugfs_create_dir(dev_name(dev), hzip_debugfs_root);
+	if (!dev_d)
+		return -ENOENT;
+
+	qm->debug.debug_root = dev_d;
+	ret = hisi_qm_debug_init(qm);
+	if (ret)
+		goto failed_to_create;
+
+	if (qm->fun_type == QM_HW_PF) {
+		hisi_zip->ctrl->debug_root = dev_d;
+		ret = hisi_zip_ctrl_debug_init(hisi_zip->ctrl);
+		if (ret)
+			goto failed_to_create;
+	}
+
+	return 0;
+
+failed_to_create:
+	debugfs_remove_recursive(hzip_debugfs_root);
+	return ret;
+}
+
+static void hisi_zip_debug_regs_clear(struct hisi_zip *hisi_zip)
+{
+	struct hisi_qm *qm = &hisi_zip->qm;
+
+	writel(0x0, qm->io_base + QM_DFX_MB_CNT_VF);
+	writel(0x0, qm->io_base + QM_DFX_DB_CNT_VF);
+	writel(0x0, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);
+
+	hisi_qm_debug_regs_clear(qm);
+}
+
+static void hisi_zip_debugfs_exit(struct hisi_zip *hisi_zip)
+{
+	struct hisi_qm *qm = &hisi_zip->qm;
+
+	debugfs_remove_recursive(qm->debug.debug_root);
+
+	if (qm->fun_type == QM_HW_PF)
+		hisi_zip_debug_regs_clear(hisi_zip);
+}
+
 static void hisi_zip_hw_error_init(struct hisi_zip *hisi_zip)
 {
 	hisi_qm_hw_error_init(&hisi_zip->qm, QM_BASE_CE,
@@ -301,6 +647,7 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 
 	hisi_zip_set_user_domain_and_cache(hisi_zip);
 	hisi_zip_hw_error_init(hisi_zip);
+	hisi_zip_debug_regs_clear(hisi_zip);
 
 	return 0;
 }
@@ -376,6 +723,10 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto err_qm_uninit;
 
+	ret = hisi_zip_debugfs_init(hisi_zip);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to init debugfs (%d)!\n", ret);
+
 	hisi_zip_add_to_list(hisi_zip);
 
 	return 0;
@@ -501,6 +852,7 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 	if (qm->fun_type == QM_HW_PF && hisi_zip->ctrl->num_vfs != 0)
 		hisi_zip_sriov_disable(pdev);
 
+	hisi_zip_debugfs_exit(hisi_zip);
 	hisi_qm_stop(qm);
 
 	if (qm->fun_type == QM_HW_PF)
@@ -600,14 +952,31 @@ static struct pci_driver hisi_zip_pci_driver = {
 	.err_handler		= &hisi_zip_err_handler,
 };
 
+static void hisi_zip_register_debugfs(void)
+{
+	if (!debugfs_initialized())
+		return;
+
+	hzip_debugfs_root = debugfs_create_dir("hisi_zip", NULL);
+	if (IS_ERR_OR_NULL(hzip_debugfs_root))
+		hzip_debugfs_root = NULL;
+}
+
+static void hisi_zip_unregister_debugfs(void)
+{
+	debugfs_remove_recursive(hzip_debugfs_root);
+}
+
 static int __init hisi_zip_init(void)
 {
 	int ret;
 
+	hisi_zip_register_debugfs();
+
 	ret = pci_register_driver(&hisi_zip_pci_driver);
 	if (ret < 0) {
 		pr_err("Failed to register pci driver.\n");
-		return ret;
+		goto err_pci;
 	}
 
 	if (uacce_mode == 0 || uacce_mode == 2) {
@@ -622,6 +991,9 @@ static int __init hisi_zip_init(void)
 
 err_crypto:
 	pci_unregister_driver(&hisi_zip_pci_driver);
+err_pci:
+	hisi_zip_unregister_debugfs();
+
 	return ret;
 }
 
@@ -630,6 +1002,7 @@ static void __exit hisi_zip_exit(void)
 	if (uacce_mode == 0 || uacce_mode == 2)
 		hisi_zip_unregister_from_crypto();
 	pci_unregister_driver(&hisi_zip_pci_driver);
+	hisi_zip_unregister_debugfs();
 }
 
 module_init(hisi_zip_init);
-- 
2.8.1

