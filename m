Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D35C1DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 11:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfI3JYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 05:24:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37954 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730000AbfI3JX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:23:56 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6AB2A9E785368D6E3BF1;
        Mon, 30 Sep 2019 17:23:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Sep 2019 17:23:46 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linuxarm@huawei.com>, <forest.zhouchang@huawei.com>,
        Zaibo Xu <xuzaibo@huawei.com>, Hui tang <tanghui20@huawei.com>
Subject: [PATCH 2/5] crypto: hisilicon - add SRIOV support for HPRE
Date:   Mon, 30 Sep 2019 17:20:06 +0800
Message-ID: <1569835209-44326-3-git-send-email-xuzaibo@huawei.com>
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

HiSilicon HPRE engine supports PCI SRIOV. This patch enable
this feature. User can enable VFs and pass through them to VM,
same HPRE driver can work in VM to provide RSA and DH algorithms
by crypto akcipher and kpp interfaces.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Hui tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre.h      |   1 +
 drivers/crypto/hisilicon/hpre/hpre_main.c | 139 ++++++++++++++++++++++++++++--
 2 files changed, 133 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index d219599..bcf825b 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -14,6 +14,7 @@
 struct hpre {
 	struct hisi_qm qm;
 	struct list_head list;
+	u32 num_vfs;
 	unsigned long status;
 };
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 9cf46e4..31d01d3 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -71,6 +71,7 @@
 #define HPRE_REG_RD_TMOUT_US		1000
 #define HPRE_DBGFS_VAL_MAX_LEN		20
 #define HPRE_PCI_DEVICE_ID		0xa258
+#define HPRE_PCI_VF_DEVICE_ID		0xa259
 #define HPRE_ADDR(qm, offset)		(qm->io_base + (offset))
 #define HPRE_QM_USR_CFG_MASK		0xfffffffe
 #define HPRE_QM_AXI_CFG_MASK		0xffff
@@ -85,6 +86,7 @@ static DEFINE_MUTEX(hpre_list_lock);
 static const char hpre_name[] = "hisi_hpre";
 static const struct pci_device_id hpre_dev_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HPRE_PCI_DEVICE_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HPRE_PCI_VF_DEVICE_ID) },
 	{ 0, }
 };
 
@@ -318,8 +320,12 @@ static int hpre_qm_pre_init(struct hisi_qm *qm, struct pci_dev *pdev)
 	qm->ver = rev_id;
 	qm->sqe_size = HPRE_SQE_SIZE;
 	qm->dev_name = hpre_name;
-	qm->qp_base = HPRE_PF_DEF_Q_BASE;
-	qm->qp_num = hpre_pf_q_num;
+	qm->fun_type = (pdev->device == HPRE_PCI_DEVICE_ID) ?
+		       QM_HW_PF : QM_HW_VF;
+	if (pdev->is_physfn) {
+		qm->qp_base = HPRE_PF_DEF_Q_BASE;
+		qm->qp_num = hpre_pf_q_num;
+	}
 	qm->use_dma_api = true;
 
 	return 0;
@@ -369,9 +375,16 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
-	ret = hpre_pf_probe_init(hpre);
-	if (ret)
-		goto err_with_qm_init;
+	if (pdev->is_physfn) {
+		ret = hpre_pf_probe_init(hpre);
+		if (ret)
+			goto err_with_qm_init;
+	} else if (qm->fun_type == QM_HW_VF && qm->ver == QM_HW_V2) {
+		/* v2 starts to support get vft by mailbox */
+		ret = hisi_qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
+		if (ret)
+			goto err_with_qm_init;
+	}
 
 	ret = hisi_qm_start(qm);
 	if (ret)
@@ -391,7 +404,8 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hisi_qm_stop(qm);
 
 err_with_err_init:
-	hpre_hw_error_disable(hpre);
+	if (pdev->is_physfn)
+		hpre_hw_error_disable(hpre);
 
 err_with_qm_init:
 	hisi_qm_uninit(qm);
@@ -399,15 +413,125 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ret;
 }
 
+static int hpre_vf_q_assign(struct hpre *hpre, int num_vfs)
+{
+	struct hisi_qm *qm = &hpre->qm;
+	u32 qp_num = qm->qp_num;
+	int q_num, remain_q_num, i;
+	u32 q_base = qp_num;
+	int ret;
+
+	if (!num_vfs)
+		return -EINVAL;
+
+	remain_q_num = qm->ctrl_qp_num - qp_num;
+
+	/* If remaining queues are not enough, return error. */
+	if (remain_q_num < num_vfs)
+		return -EINVAL;
+
+	q_num = remain_q_num / num_vfs;
+	for (i = 1; i <= num_vfs; i++) {
+		if (i == num_vfs)
+			q_num += remain_q_num % num_vfs;
+		ret = hisi_qm_set_vft(qm, i, q_base, (u32)q_num);
+		if (ret)
+			return ret;
+		q_base += q_num;
+	}
+
+	return 0;
+}
+
+static int hpre_clear_vft_config(struct hpre *hpre)
+{
+	struct hisi_qm *qm = &hpre->qm;
+	u32 num_vfs = hpre->num_vfs;
+	int ret;
+	u32 i;
+
+	for (i = 1; i <= num_vfs; i++) {
+		ret = hisi_qm_set_vft(qm, i, 0, 0);
+		if (ret)
+			return ret;
+	}
+	hpre->num_vfs = 0;
+
+	return 0;
+}
+
+static int hpre_sriov_enable(struct pci_dev *pdev, int max_vfs)
+{
+	struct hpre *hpre = pci_get_drvdata(pdev);
+	int pre_existing_vfs, num_vfs, ret;
+
+	pre_existing_vfs = pci_num_vf(pdev);
+	if (pre_existing_vfs) {
+		pci_err(pdev,
+			"Can't enable VF. Please disable pre-enabled VFs!\n");
+		return 0;
+	}
+
+	num_vfs = min_t(int, max_vfs, HPRE_VF_NUM);
+	ret = hpre_vf_q_assign(hpre, num_vfs);
+	if (ret) {
+		pci_err(pdev, "Can't assign queues for VF!\n");
+		return ret;
+	}
+
+	hpre->num_vfs = num_vfs;
+
+	ret = pci_enable_sriov(pdev, num_vfs);
+	if (ret) {
+		pci_err(pdev, "Can't enable VF!\n");
+		hpre_clear_vft_config(hpre);
+		return ret;
+	}
+
+	return num_vfs;
+}
+
+static int hpre_sriov_disable(struct pci_dev *pdev)
+{
+	struct hpre *hpre = pci_get_drvdata(pdev);
+
+	if (pci_vfs_assigned(pdev)) {
+		pci_err(pdev, "Failed to disable VFs while VFs are assigned!\n");
+		return -EPERM;
+	}
+
+	/* remove in hpre_pci_driver will be called to free VF resources */
+	pci_disable_sriov(pdev);
+
+	return hpre_clear_vft_config(hpre);
+}
+
+static int hpre_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	if (num_vfs)
+		return hpre_sriov_enable(pdev, num_vfs);
+	else
+		return hpre_sriov_disable(pdev);
+}
+
 static void hpre_remove(struct pci_dev *pdev)
 {
 	struct hpre *hpre = pci_get_drvdata(pdev);
 	struct hisi_qm *qm = &hpre->qm;
+	int ret;
 
 	hpre_algs_unregister();
 	hpre_remove_from_list(hpre);
+	if (qm->fun_type == QM_HW_PF && hpre->num_vfs != 0) {
+		ret = hpre_sriov_disable(pdev);
+		if (ret) {
+			pci_err(pdev, "Disable SRIOV fail!\n");
+			return;
+		}
+	}
 	hisi_qm_stop(qm);
-	hpre_hw_error_disable(hpre);
+	if (qm->fun_type == QM_HW_PF)
+		hpre_hw_error_disable(hpre);
 	hisi_qm_uninit(qm);
 }
 
@@ -476,6 +600,7 @@ static struct pci_driver hpre_pci_driver = {
 	.id_table		= hpre_dev_ids,
 	.probe			= hpre_probe,
 	.remove			= hpre_remove,
+	.sriov_configure	= hpre_sriov_configure,
 	.err_handler		= &hpre_err_handler,
 };
 
-- 
2.8.1

