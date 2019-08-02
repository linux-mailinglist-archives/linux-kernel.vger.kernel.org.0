Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95F37EEA0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 10:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404023AbfHBIRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 04:17:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403981AbfHBIQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:16:59 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BBAA18BC1AE2A5501E85;
        Fri,  2 Aug 2019 16:16:55 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 2 Aug 2019 16:16:44 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v3 4/7] crypto: hisilicon - add SRIOV support for ZIP
Date:   Fri, 2 Aug 2019 15:57:53 +0800
Message-ID: <1564732676-35987-5-git-send-email-wangzhou1@hisilicon.com>
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

HiSilicon ZIP engine supports PCI SRIOV. This patch enable this feature.
User can enable VFs and pass through them to VM, same ZIP driver can work
in VM to provide ZLIB and GZIP algorithm by crypto acomp interface.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/qm.c           |  97 +++++++++++++++++----
 drivers/crypto/hisilicon/qm.h           |   4 +
 drivers/crypto/hisilicon/zip/zip_main.c | 150 ++++++++++++++++++++++++++++++--
 3 files changed, 226 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index c095d47..4f6bbdd 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -16,6 +16,7 @@
 #define QM_VF_EQ_INT_MASK		0xc
 #define QM_IRQ_NUM_V1			1
 #define QM_IRQ_NUM_PF_V2		4
+#define QM_IRQ_NUM_VF_V2		2
 
 #define QM_EQ_EVENT_IRQ_VECTOR		0
 #define QM_AEQ_EVENT_IRQ_VECTOR		1
@@ -265,6 +266,7 @@ struct qm_doorbell {
 };
 
 struct hisi_qm_hw_ops {
+	int (*get_vft)(struct hisi_qm *qm, u32 *base, u32 *number);
 	void (*qm_db)(struct hisi_qm *qm, u16 qn,
 		      u8 cmd, u16 index, u8 priority);
 	u32 (*get_irq_num)(struct hisi_qm *qm);
@@ -422,7 +424,10 @@ static u32 qm_get_irq_num_v1(struct hisi_qm *qm)
 
 static u32 qm_get_irq_num_v2(struct hisi_qm *qm)
 {
-	return QM_IRQ_NUM_PF_V2;
+	if (qm->fun_type == QM_HW_PF)
+		return QM_IRQ_NUM_PF_V2;
+	else
+		return QM_IRQ_NUM_VF_V2;
 }
 
 static struct hisi_qp *qm_to_hisi_qp(struct hisi_qm *qm, struct qm_eqe *eqe)
@@ -591,12 +596,14 @@ static int qm_irq_register(struct hisi_qm *qm)
 		if (ret)
 			goto err_aeq_irq;
 
-		ret = request_irq(pci_irq_vector(pdev,
-				  QM_ABNORMAL_EVENT_IRQ_VECTOR),
-				  qm_abnormal_irq, IRQF_SHARED,
-				  qm->dev_name, qm);
-		if (ret)
-			goto err_abonormal_irq;
+		if (qm->fun_type == QM_HW_PF) {
+			ret = request_irq(pci_irq_vector(pdev,
+					  QM_ABNORMAL_EVENT_IRQ_VECTOR),
+					  qm_abnormal_irq, IRQF_SHARED,
+					  qm->dev_name, qm);
+			if (ret)
+				goto err_abonormal_irq;
+		}
 	}
 
 	return 0;
@@ -616,8 +623,10 @@ static void qm_irq_unregister(struct hisi_qm *qm)
 
 	if (qm->ver == QM_HW_V2) {
 		free_irq(pci_irq_vector(pdev, QM_AEQ_EVENT_IRQ_VECTOR), qm);
-		free_irq(pci_irq_vector(pdev,
-					QM_ABNORMAL_EVENT_IRQ_VECTOR), qm);
+
+		if (qm->fun_type == QM_HW_PF)
+			free_irq(pci_irq_vector(pdev,
+				 QM_ABNORMAL_EVENT_IRQ_VECTOR), qm);
 	}
 }
 
@@ -717,6 +726,24 @@ static int qm_set_sqc_cqc_vft(struct hisi_qm *qm, u32 fun_num, u32 base,
 	return 0;
 }
 
+static int qm_get_vft_v2(struct hisi_qm *qm, u32 *base, u32 *number)
+{
+	u64 sqc_vft;
+	int ret;
+
+	ret = qm_mb(qm, QM_MB_CMD_SQC_VFT_V2, 0, 0, 1);
+	if (ret)
+		return ret;
+
+	sqc_vft = readl(qm->io_base + QM_MB_CMD_DATA_ADDR_L) |
+		  ((u64)readl(qm->io_base + QM_MB_CMD_DATA_ADDR_H) << 32);
+	*base = QM_SQC_VFT_BASE_MASK_V2 & (sqc_vft >> QM_SQC_VFT_BASE_SHIFT_V2);
+	*number = (QM_SQC_VFT_NUM_MASK_v2 &
+		   (sqc_vft >> QM_SQC_VFT_NUM_SHIFT_V2)) + 1;
+
+	return 0;
+}
+
 static void qm_hw_error_init_v1(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe,
 				u32 msi)
 {
@@ -815,6 +842,7 @@ static const struct hisi_qm_hw_ops qm_hw_ops_v1 = {
 };
 
 static const struct hisi_qm_hw_ops qm_hw_ops_v2 = {
+	.get_vft = qm_get_vft_v2,
 	.qm_db = qm_db_v2,
 	.get_irq_num = qm_get_irq_num_v2,
 	.hw_error_init = qm_hw_error_init_v2,
@@ -1195,6 +1223,9 @@ int hisi_qm_init(struct hisi_qm *qm)
 	mutex_init(&qm->mailbox_lock);
 	rwlock_init(&qm->qps_lock);
 
+	dev_dbg(dev, "init qm %s with %s\n", pdev->is_physfn ? "pf" : "vf",
+		qm->use_dma_api ? "dma api" : "iommu api");
+
 	return 0;
 
 err_free_irq_vectors:
@@ -1237,6 +1268,32 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 EXPORT_SYMBOL_GPL(hisi_qm_uninit);
 
 /**
+ * hisi_qm_get_vft() - Get vft from a qm.
+ * @qm: The qm we want to get its vft.
+ * @base: The base number of queue in vft.
+ * @number: The number of queues in vft.
+ *
+ * We can allocate multiple queues to a qm by configuring virtual function
+ * table. We get related configures by this function. Normally, we call this
+ * function in VF driver to get the queue information.
+ *
+ * qm hw v1 does not support this interface.
+ */
+int hisi_qm_get_vft(struct hisi_qm *qm, u32 *base, u32 *number)
+{
+	if (!base || !number)
+		return -EINVAL;
+
+	if (!qm->ops->get_vft) {
+		dev_err(&qm->pdev->dev, "Don't support vft read!\n");
+		return -EINVAL;
+	}
+
+	return qm->ops->get_vft(qm, base, number);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_get_vft);
+
+/**
  * hisi_qm_set_vft() - Set "virtual function table" for a qm.
  * @fun_num: Number of operated function.
  * @qm: The qm in which to set vft, alway in a PF.
@@ -1344,13 +1401,15 @@ static int __hisi_qm_start(struct hisi_qm *qm)
 	if (qm->qp_num == 0)
 		return -EINVAL;
 
-	ret = qm_dev_mem_reset(qm);
-	if (ret)
-		return ret;
+	if (qm->fun_type == QM_HW_PF) {
+		ret = qm_dev_mem_reset(qm);
+		if (ret)
+			return ret;
 
-	ret = hisi_qm_set_vft(qm, 0, qm->qp_base, qm->qp_num);
-	if (ret)
-		return ret;
+		ret = hisi_qm_set_vft(qm, 0, qm->qp_base, qm->qp_num);
+		if (ret)
+			return ret;
+	}
 
 	QM_INIT_BUF(qm, eqe, QM_Q_DEPTH);
 	QM_INIT_BUF(qm, aeqe, QM_Q_DEPTH);
@@ -1469,9 +1528,11 @@ int hisi_qm_stop(struct hisi_qm *qm)
 		}
 	}
 
-	ret = hisi_qm_set_vft(qm, 0, 0, 0);
-	if (ret < 0)
-		dev_err(dev, "Failed to set vft!\n");
+	if (qm->fun_type == QM_HW_PF) {
+		ret = hisi_qm_set_vft(qm, 0, 0, 0);
+		if (ret < 0)
+			dev_err(dev, "Failed to set vft!\n");
+	}
 
 	return ret;
 }
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index a5849db..8b3cb69 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -80,6 +80,7 @@ enum qm_hw_ver {
 
 enum qm_fun_type {
 	QM_HW_PF,
+	QM_HW_VF,
 };
 
 struct qm_dma {
@@ -98,6 +99,7 @@ struct hisi_qm_status {
 
 struct hisi_qm {
 	enum qm_hw_ver ver;
+	enum qm_fun_type fun_type;
 	const char *dev_name;
 	struct pci_dev *pdev;
 	void __iomem *io_base;
@@ -174,7 +176,9 @@ int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg);
 int hisi_qm_stop_qp(struct hisi_qp *qp);
 void hisi_qm_release_qp(struct hisi_qp *qp);
 int hisi_qp_send(struct hisi_qp *qp, const void *msg);
+int hisi_qm_get_vft(struct hisi_qm *qm, u32 *base, u32 *number);
 int hisi_qm_set_vft(struct hisi_qm *qm, u32 fun_num, u32 base, u32 number);
+int hisi_qm_debug_init(struct hisi_qm *qm);
 void hisi_qm_hw_error_init(struct hisi_qm *qm, u32 ce, u32 nfe, u32 fe,
 			   u32 msi);
 int hisi_qm_hw_error_handle(struct hisi_qm *qm);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index ee4e20e..b3e4f1a 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -12,6 +12,7 @@
 #include "zip.h"
 
 #define PCI_DEVICE_ID_ZIP_PF		0xa250
+#define PCI_DEVICE_ID_ZIP_VF		0xa251
 
 #define HZIP_VF_NUM			63
 #define HZIP_QUEUE_NUM_V1		4096
@@ -127,6 +128,7 @@ static const struct hisi_zip_hw_error zip_hw_error[] = {
  * Just relevant for PF.
  */
 struct hisi_zip_ctrl {
+	u32 num_vfs;
 	struct hisi_zip *hisi_zip;
 };
 
@@ -180,6 +182,7 @@ module_param(uacce_mode, int, 0);
 
 static const struct pci_device_id hisi_zip_dev_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_ZIP_PF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_ZIP_VF) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, hisi_zip_dev_ids);
@@ -324,6 +327,8 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	qm->sqe_size = HZIP_SQE_SIZE;
 	qm->dev_name = hisi_zip_name;
+	qm->fun_type = (pdev->device == PCI_DEVICE_ID_ZIP_PF) ? QM_HW_PF :
+								QM_HW_VF;
 	switch (uacce_mode) {
 	case 0:
 		qm->use_dma_api = true;
@@ -344,12 +349,28 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = hisi_zip_pf_probe_init(hisi_zip);
-	if (ret)
-		goto err_qm_uninit;
-
-	qm->qp_base = HZIP_PF_DEF_Q_BASE;
-	qm->qp_num = pf_q_num;
+	if (qm->fun_type == QM_HW_PF) {
+		ret = hisi_zip_pf_probe_init(hisi_zip);
+		if (ret)
+			return ret;
+
+		qm->qp_base = HZIP_PF_DEF_Q_BASE;
+		qm->qp_num = pf_q_num;
+	} else if (qm->fun_type == QM_HW_VF) {
+		/*
+		 * have no way to get qm configure in VM in v1 hardware,
+		 * so currently force PF to uses HZIP_PF_DEF_Q_NUM, and force
+		 * to trigger only one VF in v1 hardware.
+		 *
+		 * v2 hardware has no such problem.
+		 */
+		if (qm->ver == QM_HW_V1) {
+			qm->qp_base = HZIP_PF_DEF_Q_NUM;
+			qm->qp_num = HZIP_QUEUE_NUM_V1 - HZIP_PF_DEF_Q_NUM;
+		} else if (qm->ver == QM_HW_V2)
+			/* v2 starts to support get vft by mailbox */
+			hisi_qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
+	}
 
 	ret = hisi_qm_start(qm);
 	if (ret)
@@ -364,13 +385,127 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ret;
 }
 
+/* Currently we only support equal assignment */
+static int hisi_zip_vf_q_assign(struct hisi_zip *hisi_zip, int num_vfs)
+{
+	struct hisi_qm *qm = &hisi_zip->qm;
+	u32 qp_num = qm->qp_num;
+	u32 q_base = qp_num;
+	u32 q_num, remain_q_num, i;
+	int ret;
+
+	if (!num_vfs)
+		return -EINVAL;
+
+	remain_q_num = qm->ctrl_qp_num - qp_num;
+	if (remain_q_num < num_vfs)
+		return -EINVAL;
+
+	q_num = remain_q_num / num_vfs;
+	for (i = 1; i <= num_vfs; i++) {
+		if (i == num_vfs)
+			q_num += remain_q_num % num_vfs;
+		ret = hisi_qm_set_vft(qm, i, q_base, q_num);
+		if (ret)
+			return ret;
+		q_base += q_num;
+	}
+
+	return 0;
+}
+
+static int hisi_zip_clear_vft_config(struct hisi_zip *hisi_zip)
+{
+	struct hisi_zip_ctrl *ctrl = hisi_zip->ctrl;
+	struct hisi_qm *qm = &hisi_zip->qm;
+	u32 i, num_vfs = ctrl->num_vfs;
+	int ret;
+
+	for (i = 1; i <= num_vfs; i++) {
+		ret = hisi_qm_set_vft(qm, i, 0, 0);
+		if (ret)
+			return ret;
+	}
+
+	ctrl->num_vfs = 0;
+
+	return 0;
+}
+
+static int hisi_zip_sriov_enable(struct pci_dev *pdev, int max_vfs)
+{
+#ifdef CONFIG_PCI_IOV
+	struct hisi_zip *hisi_zip = pci_get_drvdata(pdev);
+	int pre_existing_vfs, num_vfs, ret;
+
+	pre_existing_vfs = pci_num_vf(pdev);
+
+	if (pre_existing_vfs) {
+		dev_err(&pdev->dev,
+			"Can't enable VF. Please disable pre-enabled VFs!\n");
+		return 0;
+	}
+
+	num_vfs = min_t(int, max_vfs, HZIP_VF_NUM);
+
+	ret = hisi_zip_vf_q_assign(hisi_zip, num_vfs);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't assign queues for VF!\n");
+		return ret;
+	}
+
+	hisi_zip->ctrl->num_vfs = num_vfs;
+
+	ret = pci_enable_sriov(pdev, num_vfs);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't enable VF!\n");
+		hisi_zip_clear_vft_config(hisi_zip);
+		return ret;
+	}
+
+	return num_vfs;
+#else
+	return 0;
+#endif
+}
+
+static int hisi_zip_sriov_disable(struct pci_dev *pdev)
+{
+	struct hisi_zip *hisi_zip = pci_get_drvdata(pdev);
+
+	if (pci_vfs_assigned(pdev)) {
+		dev_err(&pdev->dev,
+			"Can't disable VFs while VFs are assigned!\n");
+		return -EPERM;
+	}
+
+	/* remove in hisi_zip_pci_driver will be called to free VF resources */
+	pci_disable_sriov(pdev);
+
+	return hisi_zip_clear_vft_config(hisi_zip);
+}
+
+static int hisi_zip_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	if (num_vfs == 0)
+		return hisi_zip_sriov_disable(pdev);
+	else
+		return hisi_zip_sriov_enable(pdev, num_vfs);
+}
+
 static void hisi_zip_remove(struct pci_dev *pdev)
 {
 	struct hisi_zip *hisi_zip = pci_get_drvdata(pdev);
 	struct hisi_qm *qm = &hisi_zip->qm;
 
+	if (qm->fun_type == QM_HW_PF && hisi_zip->ctrl->num_vfs != 0)
+		hisi_zip_sriov_disable(pdev);
+
 	hisi_qm_stop(qm);
-	hisi_zip_hw_error_set_state(hisi_zip, false);
+
+	if (qm->fun_type == QM_HW_PF)
+		hisi_zip_hw_error_set_state(hisi_zip, false);
+
 	hisi_qm_uninit(qm);
 	hisi_zip_remove_from_list(hisi_zip);
 }
@@ -461,6 +596,7 @@ static struct pci_driver hisi_zip_pci_driver = {
 	.id_table		= hisi_zip_dev_ids,
 	.probe			= hisi_zip_probe,
 	.remove			= hisi_zip_remove,
+	.sriov_configure	= hisi_zip_sriov_configure,
 	.err_handler		= &hisi_zip_err_handler,
 };
 
-- 
2.8.1

