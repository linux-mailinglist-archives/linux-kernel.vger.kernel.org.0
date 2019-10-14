Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853CBD5BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 08:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbfJNGuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 02:50:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37971 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbfJNGug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:50:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so2596503pgt.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 23:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u642RcI9Sn6DT3hAjg9K/2Ph/wnOuv1v0S9cInSRvf0=;
        b=YAVOPZ+nmt/G3Z7SDaQi8WZNbG8mW3zbo6WqHvS3Tr7qnE45cYBmSddIyW/8HVSKAC
         iayae9STkYGbxfXhbUfw+3RVA/F39KX0RRJ5qGt2ciXZi09XZiPB6MINO4WixBF3i7Ky
         yrXmio9q1pzcrfafmpAOVVr0LvT7z/Pi2mqLv9TcbrlsjwdFE2ccp5TRibsH9tzOOD01
         w2G4/CSPHoX2j0jYf6zeSduZvc7v9iVdJelINUc+tfJs+wclDpX1WQobWPfPTiTJlhzP
         FisQNpvyE7CLiBDMTWDuYmWYnXl67IvwupfOOJv9OtN6KItobv5pY9ykjD+06Yfi1ltt
         XoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u642RcI9Sn6DT3hAjg9K/2Ph/wnOuv1v0S9cInSRvf0=;
        b=IW3Q+dEY9JndLs4J+QUTXNTbB3KykZJNeS7GOeHnpDVFJcXSoatB7MXRT5X8FbgNmf
         sKJzYoD/9aSDuSwiNfW10pFWfUFl0LIs7ttGapQC/aE82JF/I+uAuOpdynCj/ydedRkx
         CMguYq0q60Huu4oB5PFuMP1O3lgIObCTWYB3QWRyDSndHAS+3rxBluFFHdyDbtkSrda1
         70BJbLZOkfCfNbR2sEDix7gkaV1ATl7sxTPf44V5RdnjoTvtDKtM/l5T5EA5M3IsagYP
         c1VFwd0KqZvX4Rcf5SUTtiIEkobduewdV7mj1yGG++Sk3vryuwIafAIKMTKBf/uob+tt
         am2w==
X-Gm-Message-State: APjAAAV3RqVuy1qXEI3vIOsx+YMWJXiHqsrkcyNjlYPO0OypIQDXW5/W
        kJeuq2iSK+W/l76vk11WTsQuhQ==
X-Google-Smtp-Source: APXvYqxs0UpK/JcwJVjYLGy4TwybDjRr6FS5bXmR1LihlfAVc34kElNQ7qsjJG/zoTHMDneKtOdNXg==
X-Received: by 2002:a63:931a:: with SMTP id b26mr5886764pge.217.1571035835569;
        Sun, 13 Oct 2019 23:50:35 -0700 (PDT)
Received: from localhost.localdomain ([240e:362:4f9:7100:a8e8:9325:d90d:271f])
        by smtp.gmail.com with ESMTPSA id f188sm19580810pfa.170.2019.10.13.23.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Oct 2019 23:50:35 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     reg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v5 3/3] crypto: hisilicon - register zip engine to uacce
Date:   Mon, 14 Oct 2019 14:48:55 +0800
Message-Id: <1571035735-31882-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571035735-31882-1-git-send-email-zhangfei.gao@linaro.org>
References: <1571035735-31882-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qm using uacce as an example, will resubmit after uacce is merged.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/qm.c           | 254 ++++++++++++++++++++++++++++++--
 drivers/crypto/hisilicon/qm.h           |  13 +-
 drivers/crypto/hisilicon/zip/zip_main.c |  39 ++---
 include/uapi/misc/uacce/qm.h            |  15 ++
 4 files changed, 285 insertions(+), 36 deletions(-)
 create mode 100644 include/uapi/misc/uacce/qm.h

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index f975c39..60067d8 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -9,6 +9,9 @@
 #include <linux/log2.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/uacce.h>
+#include <linux/uaccess.h>
+#include <uapi/misc/uacce/qm.h>
 #include "qm.h"
 
 /* eq/aeq irq enable */
@@ -459,17 +462,22 @@ static void qm_cq_head_update(struct hisi_qp *qp)
 
 static void qm_poll_qp(struct hisi_qp *qp, struct hisi_qm *qm)
 {
-	struct qm_cqe *cqe = qp->cqe + qp->qp_status.cq_head;
-
-	if (qp->req_cb) {
-		while (QM_CQE_PHASE(cqe) == qp->qp_status.cqc_phase) {
-			dma_rmb();
-			qp->req_cb(qp, qp->sqe + qm->sqe_size * cqe->sq_head);
-			qm_cq_head_update(qp);
-			cqe = qp->cqe + qp->qp_status.cq_head;
-			qm_db(qm, qp->qp_id, QM_DOORBELL_CMD_CQ,
-			      qp->qp_status.cq_head, 0);
-			atomic_dec(&qp->qp_status.used);
+	struct qm_cqe *cqe;
+
+	if (qp->event_cb) {
+		qp->event_cb(qp);
+	} else {
+		cqe = qp->cqe + qp->qp_status.cq_head;
+
+		if (qp->req_cb) {
+			while (QM_CQE_PHASE(cqe) == qp->qp_status.cqc_phase) {
+				dma_rmb();
+				qp->req_cb(qp, qp->sqe + qm->sqe_size *
+					   cqe->sq_head);
+				qm_cq_head_update(qp);
+				cqe = qp->cqe + qp->qp_status.cq_head;
+				atomic_dec(&qp->qp_status.used);
+			}
 		}
 
 		/* set c_flag */
@@ -1391,6 +1399,221 @@ static void hisi_qm_cache_wb(struct hisi_qm *qm)
 	}
 }
 
+static void qm_qp_event_notifier(struct hisi_qp *qp)
+{
+	wake_up_interruptible(&qp->uacce_q->wait);
+}
+
+static int hisi_qm_get_available_instances(struct uacce_device *uacce)
+{
+	int i, ret;
+	struct hisi_qm *qm = uacce->priv;
+
+	read_lock(&qm->qps_lock);
+	for (i = 0, ret = 0; i < qm->qp_num; i++)
+		if (!qm->qp_array[i])
+			ret++;
+	read_unlock(&qm->qps_lock);
+
+	return ret;
+}
+
+static int hisi_qm_uacce_get_queue(struct uacce_device *uacce,
+				   unsigned long arg,
+				   struct uacce_queue *q)
+{
+	struct hisi_qm *qm = uacce->priv;
+	struct hisi_qp *qp;
+	u8 alg_type = 0;
+
+	qp = hisi_qm_create_qp(qm, alg_type);
+	if (IS_ERR(qp))
+		return PTR_ERR(qp);
+
+	q->priv = qp;
+	q->uacce = uacce;
+	qp->uacce_q = q;
+	qp->event_cb = qm_qp_event_notifier;
+	qp->pasid = arg;
+
+	return 0;
+}
+
+static void hisi_qm_uacce_put_queue(struct uacce_queue *q)
+{
+	struct hisi_qp *qp = q->priv;
+
+	/*
+	 * As put_queue is only called in uacce_mode=1, and only one queue can
+	 * be used in this mode. we flush all sqc cache back in put queue.
+	 */
+	hisi_qm_cache_wb(qp->qm);
+
+	/* need to stop hardware, but can not support in v1 */
+	hisi_qm_release_qp(qp);
+}
+
+/* map sq/cq/doorbell to user space */
+static int hisi_qm_uacce_mmap(struct uacce_queue *q,
+			      struct vm_area_struct *vma,
+			      struct uacce_qfile_region *qfr)
+{
+	struct hisi_qp *qp = q->priv;
+	struct hisi_qm *qm = qp->qm;
+	size_t sz = vma->vm_end - vma->vm_start;
+	struct pci_dev *pdev = qm->pdev;
+	struct device *dev = &pdev->dev;
+	unsigned long vm_pgoff;
+	int ret;
+
+	switch (qfr->type) {
+	case UACCE_QFRT_MMIO:
+		if (qm->ver == QM_HW_V2) {
+			if (sz > PAGE_SIZE * (QM_DOORBELL_PAGE_NR +
+			    QM_DOORBELL_SQ_CQ_BASE_V2 / PAGE_SIZE))
+				return -EINVAL;
+		} else {
+			if (sz > PAGE_SIZE * QM_DOORBELL_PAGE_NR)
+				return -EINVAL;
+		}
+
+		vma->vm_flags |= VM_IO;
+
+		return remap_pfn_range(vma, vma->vm_start,
+				       qm->phys_base >> PAGE_SHIFT,
+				       sz, pgprot_noncached(vma->vm_page_prot));
+	case UACCE_QFRT_DUS:
+		if (sz != qp->qdma.size)
+			return -EINVAL;
+
+		/* dma_mmap_coherent() requires vm_pgoff as 0
+		 * restore vm_pfoff to initial value for mmap()
+		 */
+		vm_pgoff = vma->vm_pgoff;
+		vma->vm_pgoff = 0;
+		ret = dma_mmap_coherent(dev, vma, qp->qdma.va,
+					qp->qdma.dma, sz);
+		vma->vm_pgoff = vm_pgoff;
+		return ret;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hisi_qm_uacce_start_queue(struct uacce_queue *q)
+{
+	struct hisi_qp *qp = q->priv;
+
+	return hisi_qm_start_qp(qp, qp->pasid);
+}
+
+static void hisi_qm_uacce_stop_queue(struct uacce_queue *q)
+{
+	struct hisi_qp *qp = q->priv;
+
+	hisi_qm_stop_qp(qp);
+}
+
+static int qm_set_sqctype(struct uacce_queue *q, u16 type)
+{
+	struct hisi_qm *qm = q->uacce->priv;
+	struct hisi_qp *qp = q->priv;
+
+	write_lock(&qm->qps_lock);
+	qp->alg_type = type;
+	write_unlock(&qm->qps_lock);
+
+	return 0;
+}
+
+static long hisi_qm_uacce_ioctl(struct uacce_queue *q, unsigned int cmd,
+				unsigned long arg)
+{
+	struct hisi_qp *qp = q->priv;
+	struct hisi_qp_ctx qp_ctx;
+
+	if (cmd == UACCE_CMD_QM_SET_QP_CTX) {
+		if (copy_from_user(&qp_ctx, (void __user *)arg,
+				   sizeof(struct hisi_qp_ctx)))
+			return -EFAULT;
+
+		if (qp_ctx.qc_type != 0 && qp_ctx.qc_type != 1)
+			return -EINVAL;
+
+		qm_set_sqctype(q, qp_ctx.qc_type);
+		qp_ctx.id = qp->qp_id;
+
+		if (copy_to_user((void __user *)arg, &qp_ctx,
+				 sizeof(struct hisi_qp_ctx)))
+			return -EFAULT;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct uacce_ops uacce_qm_ops = {
+	.get_available_instances = hisi_qm_get_available_instances,
+	.get_queue = hisi_qm_uacce_get_queue,
+	.put_queue = hisi_qm_uacce_put_queue,
+	.start_queue = hisi_qm_uacce_start_queue,
+	.stop_queue = hisi_qm_uacce_stop_queue,
+	.mmap = hisi_qm_uacce_mmap,
+	.ioctl = hisi_qm_uacce_ioctl,
+};
+
+static int qm_register_uacce(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	struct uacce_device *uacce;
+	unsigned long mmio_page_nr;
+	unsigned long dus_page_nr;
+	struct uacce_interface interface = {
+		.flags = UACCE_DEV_SVA,
+		.ops = &uacce_qm_ops,
+	};
+
+	strncpy(interface.name, pdev->driver->name, sizeof(interface.name));
+
+	uacce = uacce_register(&pdev->dev, &interface);
+	if (IS_ERR(uacce))
+		return PTR_ERR(uacce);
+
+	if (uacce->flags & UACCE_DEV_SVA) {
+		qm->use_sva = true;
+	} else {
+		/* only consider sva case */
+		uacce_unregister(qm->uacce);
+		return -EINVAL;
+	}
+
+	uacce->is_vf = pdev->is_virtfn;
+	uacce->priv = qm;
+	uacce->algs = qm->algs;
+
+	if (qm->ver == QM_HW_V1) {
+		mmio_page_nr = QM_DOORBELL_PAGE_NR;
+		uacce->api_ver = HISI_QM_API_VER_BASE;
+	} else {
+		mmio_page_nr = QM_DOORBELL_PAGE_NR +
+			QM_DOORBELL_SQ_CQ_BASE_V2 / PAGE_SIZE;
+		uacce->api_ver = HISI_QM_API_VER2_BASE;
+	}
+
+	dus_page_nr = (PAGE_SIZE - 1 + qm->sqe_size * QM_Q_DEPTH +
+		       sizeof(struct qm_cqe) * QM_Q_DEPTH) >> PAGE_SHIFT;
+
+	uacce->qf_pg_size[UACCE_QFRT_MMIO] = mmio_page_nr;
+	uacce->qf_pg_size[UACCE_QFRT_DUS]  = dus_page_nr;
+	uacce->qf_pg_size[UACCE_QFRT_SS]   = 0;
+
+	qm->uacce = uacce;
+
+	return 0;
+}
+
 /**
  * hisi_qm_init() - Initialize configures about qm.
  * @qm: The qm needing init.
@@ -1415,6 +1638,10 @@ int hisi_qm_init(struct hisi_qm *qm)
 		return -EINVAL;
 	}
 
+	ret = qm_register_uacce(qm);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "fail to register uacce (%d)\n", ret);
+
 	ret = pci_enable_device_mem(pdev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to enable device mem!\n");
@@ -1427,6 +1654,8 @@ int hisi_qm_init(struct hisi_qm *qm)
 		goto err_disable_pcidev;
 	}
 
+	qm->phys_base = pci_resource_start(pdev, PCI_BAR_2);
+	qm->size = pci_resource_len(qm->pdev, PCI_BAR_2);
 	qm->io_base = ioremap(pci_resource_start(pdev, PCI_BAR_2),
 			      pci_resource_len(qm->pdev, PCI_BAR_2));
 	if (!qm->io_base) {
@@ -1498,6 +1727,9 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 	iounmap(qm->io_base);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
+
+	if (qm->uacce)
+		uacce_unregister(qm->uacce);
 }
 EXPORT_SYMBOL_GPL(hisi_qm_uninit);
 
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 70e672ae..58af252 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -75,6 +75,10 @@
 
 #define QM_Q_DEPTH			1024
 
+/* page number for queue file region */
+#define QM_DOORBELL_PAGE_NR		1
+
+
 enum qp_state {
 	QP_STOP,
 };
@@ -159,7 +163,12 @@ struct hisi_qm {
 	u32 error_mask;
 	u32 msi_mask;
 
+	const char *algs;
 	bool use_dma_api;
+	bool use_sva;
+	resource_size_t phys_base;
+	resource_size_t size;
+	struct uacce_device *uacce;
 };
 
 struct hisi_qp_status {
@@ -189,10 +198,12 @@ struct hisi_qp {
 	struct hisi_qp_ops *hw_ops;
 	void *qp_ctx;
 	void (*req_cb)(struct hisi_qp *qp, void *data);
+	void (*event_cb)(struct hisi_qp *qp);
 	struct work_struct work;
 	struct workqueue_struct *wq;
-
 	struct hisi_qm *qm;
+	u16 pasid;
+	struct uacce_queue *uacce_q;
 };
 
 int hisi_qm_init(struct hisi_qm *qm);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 1b2ee96..48860d2 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -316,8 +316,14 @@ static void hisi_zip_set_user_domain_and_cache(struct hisi_zip *hisi_zip)
 	writel(AXUSER_BASE, base + HZIP_BD_RUSER_32_63);
 	writel(AXUSER_BASE, base + HZIP_SGL_RUSER_32_63);
 	writel(AXUSER_BASE, base + HZIP_BD_WUSER_32_63);
-	writel(AXUSER_BASE, base + HZIP_DATA_RUSER_32_63);
-	writel(AXUSER_BASE, base + HZIP_DATA_WUSER_32_63);
+
+	if (hisi_zip->qm.use_sva) {
+		writel(AXUSER_BASE | AXUSER_SSV, base + HZIP_DATA_RUSER_32_63);
+		writel(AXUSER_BASE | AXUSER_SSV, base + HZIP_DATA_WUSER_32_63);
+	} else {
+		writel(AXUSER_BASE, base + HZIP_DATA_RUSER_32_63);
+		writel(AXUSER_BASE, base + HZIP_DATA_WUSER_32_63);
+	}
 
 	/* let's open all compression/decompression cores */
 	writel(DECOMP_CHECK_ENABLE | ALL_COMP_DECOMP_EN,
@@ -671,24 +677,12 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	qm = &hisi_zip->qm;
 	qm->pdev = pdev;
 	qm->ver = rev_id;
-
+	qm->use_dma_api = true;
+	qm->algs = "zlib\ngzip\n";
 	qm->sqe_size = HZIP_SQE_SIZE;
 	qm->dev_name = hisi_zip_name;
 	qm->fun_type = (pdev->device == PCI_DEVICE_ID_ZIP_PF) ? QM_HW_PF :
 								QM_HW_VF;
-	switch (uacce_mode) {
-	case 0:
-		qm->use_dma_api = true;
-		break;
-	case 1:
-		qm->use_dma_api = false;
-		break;
-	case 2:
-		qm->use_dma_api = true;
-		break;
-	default:
-		return -EINVAL;
-	}
 
 	ret = hisi_qm_init(qm);
 	if (ret) {
@@ -976,12 +970,10 @@ static int __init hisi_zip_init(void)
 		goto err_pci;
 	}
 
-	if (uacce_mode == 0 || uacce_mode == 2) {
-		ret = hisi_zip_register_to_crypto();
-		if (ret < 0) {
-			pr_err("Failed to register driver to crypto.\n");
-			goto err_crypto;
-		}
+	ret = hisi_zip_register_to_crypto();
+	if (ret < 0) {
+		pr_err("Failed to register driver to crypto.\n");
+		goto err_crypto;
 	}
 
 	return 0;
@@ -996,8 +988,7 @@ static int __init hisi_zip_init(void)
 
 static void __exit hisi_zip_exit(void)
 {
-	if (uacce_mode == 0 || uacce_mode == 2)
-		hisi_zip_unregister_from_crypto();
+	hisi_zip_unregister_from_crypto();
 	pci_unregister_driver(&hisi_zip_pci_driver);
 	hisi_zip_unregister_debugfs();
 }
diff --git a/include/uapi/misc/uacce/qm.h b/include/uapi/misc/uacce/qm.h
new file mode 100644
index 0000000..b4ad3ae
--- /dev/null
+++ b/include/uapi/misc/uacce/qm.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef HISI_QM_USR_IF_H
+#define HISI_QM_USR_IF_H
+
+struct hisi_qp_ctx {
+	__u16 id;
+	__u16 qc_type;
+};
+
+#define HISI_QM_API_VER_BASE "hisi_qm_v1"
+#define HISI_QM_API_VER2_BASE "hisi_qm_v2"
+
+#define UACCE_CMD_QM_SET_QP_CTX	_IOWR('H', 10, struct hisi_qp_ctx)
+
+#endif
-- 
2.7.4

