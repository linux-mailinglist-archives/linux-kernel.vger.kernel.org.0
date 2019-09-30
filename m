Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E23DC1DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 11:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfI3JX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 05:23:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37956 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730033AbfI3JX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:23:57 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6FBECBB73E85560E322F;
        Mon, 30 Sep 2019 17:23:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Sep 2019 17:23:46 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linuxarm@huawei.com>, <forest.zhouchang@huawei.com>,
        Zaibo Xu <xuzaibo@huawei.com>, Hui Tang <tanghui20@huawei.com>
Subject: [PATCH 4/5] crypto: hisilicon: Add debugfs for HPRE
Date:   Mon, 30 Sep 2019 17:20:08 +0800
Message-ID: <1569835209-44326-5-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1569835209-44326-1-git-send-email-xuzaibo@huawei.com>
References: <1569835209-44326-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiSilicon HPRE engine driver uses debugfs to provide debug information,
the usage can be found in /Documentation/ABI/testing/debugfs-hisi-hpre.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre.h      |  36 ++-
 drivers/crypto/hisilicon/hpre/hpre_main.c | 426 +++++++++++++++++++++++++++++-
 2 files changed, 460 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index bcf825b..ddf13ea 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -9,11 +9,45 @@
 #define HPRE_SQE_SIZE			sizeof(struct hpre_sqe)
 #define HPRE_PF_DEF_Q_NUM		64
 #define HPRE_PF_DEF_Q_BASE		0
-#define HPRE_CLUSTERS_NUM		4
+
+enum {
+	HPRE_CLUSTER0,
+	HPRE_CLUSTER1,
+	HPRE_CLUSTER2,
+	HPRE_CLUSTER3,
+	HPRE_CLUSTERS_NUM,
+};
+
+enum hpre_ctrl_dbgfs_file {
+	HPRE_CURRENT_QM,
+	HPRE_CLEAR_ENABLE,
+	HPRE_CLUSTER_CTRL,
+	HPRE_DEBUG_FILE_NUM,
+};
+
+#define HPRE_DEBUGFS_FILE_NUM    (HPRE_DEBUG_FILE_NUM + HPRE_CLUSTERS_NUM - 1)
+
+struct hpre_debugfs_file {
+	int index;
+	enum hpre_ctrl_dbgfs_file type;
+	spinlock_t lock;
+	struct hpre_debug *debug;
+};
+
+/*
+ * One HPRE controller has one PF and multiple VFs, some global configurations
+ * which PF has need this structure.
+ * Just relevant for PF.
+ */
+struct hpre_debug {
+	struct dentry *debug_root;
+	struct hpre_debugfs_file files[HPRE_DEBUGFS_FILE_NUM];
+};
 
 struct hpre {
 	struct hisi_qm qm;
 	struct list_head list;
+	struct hpre_debug debug;
 	u32 num_vfs;
 	unsigned long status;
 };
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 31d01d3..ca945b2 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -3,6 +3,7 @@
 #include <linux/acpi.h>
 #include <linux/aer.h>
 #include <linux/bitops.h>
+#include <linux/debugfs.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -84,6 +85,7 @@
 static LIST_HEAD(hpre_list);
 static DEFINE_MUTEX(hpre_list_lock);
 static const char hpre_name[] = "hisi_hpre";
+static struct dentry *hpre_debugfs_root;
 static const struct pci_device_id hpre_dev_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HPRE_PCI_DEVICE_ID) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HPRE_PCI_VF_DEVICE_ID) },
@@ -97,6 +99,12 @@ struct hpre_hw_error {
 	const char *msg;
 };
 
+static const char * const hpre_debug_file_name[] = {
+	[HPRE_CURRENT_QM]   = "current_qm",
+	[HPRE_CLEAR_ENABLE] = "rdclr_en",
+	[HPRE_CLUSTER_CTRL] = "cluster_ctrl",
+};
+
 static const struct hpre_hw_error hpre_hw_errors[] = {
 	{ .int_msk = BIT(0), .msg = "hpre_ecc_1bitt_err" },
 	{ .int_msk = BIT(1), .msg = "hpre_ecc_2bit_err" },
@@ -113,6 +121,42 @@ static const struct hpre_hw_error hpre_hw_errors[] = {
 	{ /* sentinel */ }
 };
 
+static const u64 hpre_cluster_offsets[] = {
+	[HPRE_CLUSTER0] =
+		HPRE_CLSTR_BASE + HPRE_CLUSTER0 * HPRE_CLSTR_ADDR_INTRVL,
+	[HPRE_CLUSTER1] =
+		HPRE_CLSTR_BASE + HPRE_CLUSTER1 * HPRE_CLSTR_ADDR_INTRVL,
+	[HPRE_CLUSTER2] =
+		HPRE_CLSTR_BASE + HPRE_CLUSTER2 * HPRE_CLSTR_ADDR_INTRVL,
+	[HPRE_CLUSTER3] =
+		HPRE_CLSTR_BASE + HPRE_CLUSTER3 * HPRE_CLSTR_ADDR_INTRVL,
+};
+
+static struct debugfs_reg32 hpre_cluster_dfx_regs[] = {
+	{"CORES_EN_STATUS          ",  HPRE_CORE_EN_OFFSET},
+	{"CORES_INI_CFG              ",  HPRE_CORE_INI_CFG_OFFSET},
+	{"CORES_INI_STATUS         ",  HPRE_CORE_INI_STATUS_OFFSET},
+	{"CORES_HTBT_WARN         ",  HPRE_CORE_HTBT_WARN_OFFSET},
+	{"CORES_IS_SCHD               ",  HPRE_CORE_IS_SCHD_OFFSET},
+};
+
+static struct debugfs_reg32 hpre_com_dfx_regs[] = {
+	{"READ_CLR_EN          ",  HPRE_CTRL_CNT_CLR_CE},
+	{"AXQOS                   ",  HPRE_VFG_AXQOS},
+	{"AWUSR_CFG              ",  HPRE_AWUSR_FP_CFG},
+	{"QM_ARUSR_MCFG1           ",  QM_ARUSER_M_CFG_1},
+	{"QM_AWUSR_MCFG1           ",  QM_AWUSER_M_CFG_1},
+	{"BD_ENDIAN               ",  HPRE_BD_ENDIAN},
+	{"ECC_CHECK_CTRL       ",  HPRE_ECC_BYPASS},
+	{"RAS_INT_WIDTH       ",  HPRE_RAS_WIDTH_CFG},
+	{"POISON_BYPASS       ",  HPRE_POISON_BYPASS},
+	{"BD_ARUSER               ",  HPRE_BD_ARUSR_CFG},
+	{"BD_AWUSER               ",  HPRE_BD_AWUSR_CFG},
+	{"DATA_ARUSER            ",  HPRE_DATA_RUSER_CFG},
+	{"DATA_AWUSER           ",  HPRE_DATA_WUSER_CFG},
+	{"INT_STATUS               ",  HPRE_INT_STATUS},
+};
+
 static int hpre_pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
 	struct pci_dev *pdev;
@@ -284,6 +328,27 @@ static int hpre_set_user_domain_and_cache(struct hpre *hpre)
 	return ret;
 }
 
+static void hpre_cnt_regs_clear(struct hisi_qm *qm)
+{
+	unsigned long offset;
+	int i;
+
+	/* clear current_qm */
+	writel(0x0, qm->io_base + QM_DFX_MB_CNT_VF);
+	writel(0x0, qm->io_base + QM_DFX_DB_CNT_VF);
+
+	/* clear clusterX/cluster_ctrl */
+	for (i = 0; i < HPRE_CLUSTERS_NUM; i++) {
+		offset = HPRE_CLSTR_BASE + i * HPRE_CLSTR_ADDR_INTRVL;
+		writel(0x0, qm->io_base + offset + HPRE_CLUSTER_INQURY);
+	}
+
+	/* clear rdclr_en */
+	writel(0x0, qm->io_base + HPRE_CTRL_CNT_CLR_CE);
+
+	hisi_qm_debug_regs_clear(qm);
+}
+
 static void hpre_hw_error_disable(struct hpre *hpre)
 {
 	struct hisi_qm *qm = &hpre->qm;
@@ -303,6 +368,335 @@ static void hpre_hw_error_enable(struct hpre *hpre)
 	writel(HPRE_HAC_RAS_FE_ENABLE, qm->io_base + HPRE_RAS_FE_ENB);
 }
 
+static inline struct hisi_qm *hpre_file_to_qm(struct hpre_debugfs_file *file)
+{
+	struct hpre *hpre = container_of(file->debug, struct hpre, debug);
+
+	return &hpre->qm;
+}
+
+static u32 hpre_current_qm_read(struct hpre_debugfs_file *file)
+{
+	struct hisi_qm *qm = hpre_file_to_qm(file);
+
+	return readl(qm->io_base + QM_DFX_MB_CNT_VF);
+}
+
+static int hpre_current_qm_write(struct hpre_debugfs_file *file, u32 val)
+{
+	struct hisi_qm *qm = hpre_file_to_qm(file);
+	struct hpre_debug *debug = file->debug;
+	struct hpre *hpre = container_of(debug, struct hpre, debug);
+	u32 num_vfs = hpre->num_vfs;
+	u32 vfq_num, tmp;
+
+
+	if (val > num_vfs)
+		return -EINVAL;
+
+	/* According PF or VF Dev ID to calculation curr_qm_qp_num and store */
+	if (val == 0) {
+		qm->debug.curr_qm_qp_num = qm->qp_num;
+	} else {
+		vfq_num = (qm->ctrl_qp_num - qm->qp_num) / num_vfs;
+		if (val == num_vfs) {
+			qm->debug.curr_qm_qp_num =
+			qm->ctrl_qp_num - qm->qp_num - (num_vfs - 1) * vfq_num;
+		} else {
+			qm->debug.curr_qm_qp_num = vfq_num;
+		}
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
+static u32 hpre_clear_enable_read(struct hpre_debugfs_file *file)
+{
+	struct hisi_qm *qm = hpre_file_to_qm(file);
+
+	return readl(qm->io_base + HPRE_CTRL_CNT_CLR_CE) &
+	       HPRE_CTRL_CNT_CLR_CE_BIT;
+}
+
+static int hpre_clear_enable_write(struct hpre_debugfs_file *file, u32 val)
+{
+	struct hisi_qm *qm = hpre_file_to_qm(file);
+	u32 tmp;
+
+	if (val != 1 && val != 0)
+		return -EINVAL;
+
+	tmp = (readl(qm->io_base + HPRE_CTRL_CNT_CLR_CE) &
+	       ~HPRE_CTRL_CNT_CLR_CE_BIT) | val;
+	writel(tmp, qm->io_base + HPRE_CTRL_CNT_CLR_CE);
+
+	return  0;
+}
+
+static u32 hpre_cluster_inqry_read(struct hpre_debugfs_file *file)
+{
+	struct hisi_qm *qm = hpre_file_to_qm(file);
+	int cluster_index = file->index - HPRE_CLUSTER_CTRL;
+	unsigned long offset = HPRE_CLSTR_BASE +
+			       cluster_index * HPRE_CLSTR_ADDR_INTRVL;
+
+	return readl(qm->io_base + offset + HPRE_CLSTR_ADDR_INQRY_RSLT);
+}
+
+static int hpre_cluster_inqry_write(struct hpre_debugfs_file *file, u32 val)
+{
+	struct hisi_qm *qm = hpre_file_to_qm(file);
+	int cluster_index = file->index - HPRE_CLUSTER_CTRL;
+	unsigned long offset = HPRE_CLSTR_BASE + cluster_index *
+			       HPRE_CLSTR_ADDR_INTRVL;
+
+	writel(val, qm->io_base + offset + HPRE_CLUSTER_INQURY);
+
+	return  0;
+}
+
+static ssize_t hpre_ctrl_debug_read(struct file *filp, char __user *buf,
+			       size_t count, loff_t *pos)
+{
+	struct hpre_debugfs_file *file = filp->private_data;
+	char tbuf[HPRE_DBGFS_VAL_MAX_LEN];
+	u32 val;
+	int ret;
+
+	spin_lock_irq(&file->lock);
+	switch (file->type) {
+	case HPRE_CURRENT_QM:
+		val = hpre_current_qm_read(file);
+		break;
+	case HPRE_CLEAR_ENABLE:
+		val = hpre_clear_enable_read(file);
+		break;
+	case HPRE_CLUSTER_CTRL:
+		val = hpre_cluster_inqry_read(file);
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
+static ssize_t hpre_ctrl_debug_write(struct file *filp, const char __user *buf,
+				size_t count, loff_t *pos)
+{
+	struct hpre_debugfs_file *file = filp->private_data;
+	char tbuf[HPRE_DBGFS_VAL_MAX_LEN];
+	unsigned long val;
+	int len, ret;
+
+	if (*pos != 0)
+		return 0;
+
+	if (count >= HPRE_DBGFS_VAL_MAX_LEN)
+		return -ENOSPC;
+
+	len = simple_write_to_buffer(tbuf, HPRE_DBGFS_VAL_MAX_LEN - 1,
+				     pos, buf, count);
+	if (len < 0)
+		return len;
+
+	tbuf[len] = '\0';
+	if (kstrtoul(tbuf, 0, &val))
+		return -EFAULT;
+
+	spin_lock_irq(&file->lock);
+	switch (file->type) {
+	case HPRE_CURRENT_QM:
+		ret = hpre_current_qm_write(file, val);
+		if (ret)
+			goto err_input;
+		break;
+	case HPRE_CLEAR_ENABLE:
+		ret = hpre_clear_enable_write(file, val);
+		if (ret)
+			goto err_input;
+		break;
+	case HPRE_CLUSTER_CTRL:
+		ret = hpre_cluster_inqry_write(file, val);
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
+static const struct file_operations hpre_ctrl_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = hpre_ctrl_debug_read,
+	.write = hpre_ctrl_debug_write,
+};
+
+static int hpre_create_debugfs_file(struct hpre_debug *dbg, struct dentry *dir,
+				    enum hpre_ctrl_dbgfs_file type, int indx)
+{
+	struct dentry *tmp, *file_dir;
+
+	if (dir)
+		file_dir = dir;
+	else
+		file_dir = dbg->debug_root;
+
+	if (type >= HPRE_DEBUG_FILE_NUM)
+		return -EINVAL;
+
+	spin_lock_init(&dbg->files[indx].lock);
+	dbg->files[indx].debug = dbg;
+	dbg->files[indx].type = type;
+	dbg->files[indx].index = indx;
+	tmp = debugfs_create_file(hpre_debug_file_name[type], 0600, file_dir,
+				  dbg->files + indx, &hpre_ctrl_debug_fops);
+	if (!tmp)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int hpre_pf_comm_regs_debugfs_init(struct hpre_debug *debug)
+{
+	struct hpre *hpre = container_of(debug, struct hpre, debug);
+	struct hisi_qm *qm = &hpre->qm;
+	struct device *dev = &qm->pdev->dev;
+	struct debugfs_regset32 *regset;
+	struct dentry *tmp;
+
+	regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return -ENOMEM;
+
+	regset->regs = hpre_com_dfx_regs;
+	regset->nregs = ARRAY_SIZE(hpre_com_dfx_regs);
+	regset->base = qm->io_base;
+
+	tmp = debugfs_create_regset32("regs", 0444,  debug->debug_root, regset);
+	if (!tmp)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int hpre_cluster_debugfs_init(struct hpre_debug *debug)
+{
+	struct hpre *hpre = container_of(debug, struct hpre, debug);
+	struct hisi_qm *qm = &hpre->qm;
+	struct device *dev = &qm->pdev->dev;
+	char buf[HPRE_DBGFS_VAL_MAX_LEN];
+	struct debugfs_regset32 *regset;
+	struct dentry *tmp_d, *tmp;
+	int i, ret;
+
+	for (i = 0; i < HPRE_CLUSTERS_NUM; i++) {
+		sprintf(buf, "cluster%d", i);
+
+		tmp_d = debugfs_create_dir(buf, debug->debug_root);
+		if (!tmp_d)
+			return -ENOENT;
+
+		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
+		if (!regset)
+			return -ENOMEM;
+
+		regset->regs = hpre_cluster_dfx_regs;
+		regset->nregs = ARRAY_SIZE(hpre_cluster_dfx_regs);
+		regset->base = qm->io_base + hpre_cluster_offsets[i];
+
+		tmp = debugfs_create_regset32("regs", 0444, tmp_d, regset);
+		if (!tmp)
+			return -ENOENT;
+		ret = hpre_create_debugfs_file(debug, tmp_d, HPRE_CLUSTER_CTRL,
+					       i + HPRE_CLUSTER_CTRL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int hpre_ctrl_debug_init(struct hpre_debug *debug)
+{
+	int ret;
+
+	ret = hpre_create_debugfs_file(debug, NULL, HPRE_CURRENT_QM,
+				       HPRE_CURRENT_QM);
+	if (ret)
+		return ret;
+
+	ret = hpre_create_debugfs_file(debug, NULL, HPRE_CLEAR_ENABLE,
+				       HPRE_CLEAR_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = hpre_pf_comm_regs_debugfs_init(debug);
+	if (ret)
+		return ret;
+
+	return hpre_cluster_debugfs_init(debug);
+}
+
+static int hpre_debugfs_init(struct hpre *hpre)
+{
+	struct hisi_qm *qm = &hpre->qm;
+	struct device *dev = &qm->pdev->dev;
+	struct dentry *dir;
+	int ret;
+
+	dir = debugfs_create_dir(dev_name(dev), hpre_debugfs_root);
+	if (!dir)
+		return -ENOENT;
+
+	qm->debug.debug_root = dir;
+
+	ret = hisi_qm_debug_init(qm);
+	if (ret)
+		goto failed_to_create;
+
+	if (qm->pdev->device == HPRE_PCI_DEVICE_ID) {
+		hpre->debug.debug_root = dir;
+		ret = hpre_ctrl_debug_init(&hpre->debug);
+		if (ret)
+			goto failed_to_create;
+	}
+	return 0;
+
+failed_to_create:
+	debugfs_remove_recursive(qm->debug.debug_root);
+	return ret;
+}
+
+static void hpre_debugfs_exit(struct hpre *hpre)
+{
+	struct hisi_qm *qm = &hpre->qm;
+
+	debugfs_remove_recursive(qm->debug.debug_root);
+}
+
 static int hpre_qm_pre_init(struct hisi_qm *qm, struct pci_dev *pdev)
 {
 	enum qm_hw_ver rev_id;
@@ -390,6 +784,10 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto err_with_err_init;
 
+	ret = hpre_debugfs_init(hpre);
+	if (ret)
+		dev_warn(&pdev->dev, "init debugfs fail!\n");
+
 	hpre_add_to_list(hpre);
 
 	ret = hpre_algs_register();
@@ -529,6 +927,12 @@ static void hpre_remove(struct pci_dev *pdev)
 			return;
 		}
 	}
+	if (qm->fun_type == QM_HW_PF) {
+		hpre_cnt_regs_clear(qm);
+		qm->debug.curr_qm_qp_num = 0;
+	}
+
+	hpre_debugfs_exit(hpre);
 	hisi_qm_stop(qm);
 	if (qm->fun_type == QM_HW_PF)
 		hpre_hw_error_disable(hpre);
@@ -604,13 +1008,32 @@ static struct pci_driver hpre_pci_driver = {
 	.err_handler		= &hpre_err_handler,
 };
 
+static void hpre_register_debugfs(void)
+{
+	if (!debugfs_initialized())
+		return;
+
+	hpre_debugfs_root = debugfs_create_dir(hpre_name, NULL);
+	if (IS_ERR_OR_NULL(hpre_debugfs_root))
+		hpre_debugfs_root = NULL;
+}
+
+static void hpre_unregister_debugfs(void)
+{
+	debugfs_remove_recursive(hpre_debugfs_root);
+}
+
 static int __init hpre_init(void)
 {
 	int ret;
 
+	hpre_register_debugfs();
+
 	ret = pci_register_driver(&hpre_pci_driver);
-	if (ret)
+	if (ret) {
+		hpre_unregister_debugfs();
 		pr_err("hpre: can't register hisi hpre driver.\n");
+	}
 
 	return ret;
 }
@@ -618,6 +1041,7 @@ static int __init hpre_init(void)
 static void __exit hpre_exit(void)
 {
 	pci_unregister_driver(&hpre_pci_driver);
+	hpre_unregister_debugfs();
 }
 
 module_init(hpre_init);
-- 
2.8.1

