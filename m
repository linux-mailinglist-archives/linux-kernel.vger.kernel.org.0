Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0547713C578
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 15:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgAOOOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 09:14:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40705 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbgAOOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:14:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so8274367pgt.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7g+A6EIwp3+uoUr/nE8BNmfnMZluXrSBZonY3RnkoaI=;
        b=A7SamQuevOsKhfQnTzbBI8X6DhhQWgEDOUlldX99SNFKpiKcNQn5NyjpSU1YlNeTQe
         w9+NYdLkKfMzZnU+Nbp2Ny3YuixtQhaPMheUtIwl51kSoQWFNX8/toXNix2salORUyhv
         iTQV5lr2Nrs29PZ2rmR8RoTV4df/k+LXZXL7vk3nh1MDFSXcnuBiL1/aTUNmGBHzsTV4
         IFPvGAURePGtKoGas5A9gYEOBnEEOvKgiyqzIRSPq2eA/+LIzV+dKKGtGMuOIJFO4J46
         AvNxO9CwZkUUv1l0usGW+i1kxLcAzaysCPNN8KSKZfv9qxlO9SVuk1asKjH5Sym5uS7k
         FbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7g+A6EIwp3+uoUr/nE8BNmfnMZluXrSBZonY3RnkoaI=;
        b=DW533P27jkVFPxAxjxjro4mb3aNXlpqAhYLZHHGYpGeHtWEtEXbyj3V2jKvX5OfIDD
         YQWQf+QKxHdAQFEuQgPfrxfZUuLWKTi9QKm4b6YQ0y/32hbBYhb8/KlUnfvz/7gnsZvD
         Koc2cKr/sgtK1nxsp98IhIxZWyYeVJUFSDLcBzjEz3H9FTVE0RoSn0RwtpEXIx5yHpnh
         UZp5pmJ3U+LwkhBWekfVmHrTQWcnbOZ7BhqtIR+nQ0STSZQ6OSg1LEoJH8d6d2qVUEtG
         6Q49TLGHR39VcN5/HxR/zfTHRM3zG9ndsnnL6LCyFKwuO+q85MkIJviCLp1hcQU9KvQ4
         Ymtg==
X-Gm-Message-State: APjAAAWLI3dy7ymrrfQhqtcJNMt93FBr3Awfbysnoj/KGcBWxzndTvy6
        +y7Us7lQ8bvhU/MdDD+LCY3YaQ==
X-Google-Smtp-Source: APXvYqwQQERNuRwRXlNDQbTOVSbY1x16/7bzx0riR3fwBnj/krjnxBlk2KP6r8cDUbdGEr12j6aLZw==
X-Received: by 2002:a65:5281:: with SMTP id y1mr32541324pgp.327.1579097683100;
        Wed, 15 Jan 2020 06:14:43 -0800 (PST)
Received: from localhost.localdomain ([104.238.63.136])
        by smtp.gmail.com with ESMTPSA id a15sm22591980pfh.169.2020.01.15.06.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Jan 2020 06:14:42 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v12 4/4] crypto: hisilicon - register zip engine to uacce
Date:   Wed, 15 Jan 2020 22:12:48 +0800
Message-Id: <1579097568-17542-5-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
References: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register qm to uacce framework for user crypto driver

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/qm.c           | 239 +++++++++++++++++++++++++++++++-
 drivers/crypto/hisilicon/qm.h           |  11 ++
 drivers/crypto/hisilicon/zip/zip_main.c |  16 ++-
 include/uapi/misc/uacce/hisi_qm.h       |  23 +++
 4 files changed, 281 insertions(+), 8 deletions(-)
 create mode 100644 include/uapi/misc/uacce/hisi_qm.h

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index d6e2497..c56d819 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -9,6 +9,9 @@
 #include <linux/log2.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/uacce.h>
+#include <linux/uaccess.h>
+#include <uapi/misc/uacce/hisi_qm.h>
 #include "qm.h"
 
 /* eq/aeq irq enable */
@@ -465,9 +468,14 @@ static void qm_cq_head_update(struct hisi_qp *qp)
 
 static void qm_poll_qp(struct hisi_qp *qp, struct hisi_qm *qm)
 {
-	struct qm_cqe *cqe = qp->cqe + qp->qp_status.cq_head;
+	if (qp->event_cb) {
+		qp->event_cb(qp);
+		return;
+	}
 
 	if (qp->req_cb) {
+		struct qm_cqe *cqe = qp->cqe + qp->qp_status.cq_head;
+
 		while (QM_CQE_PHASE(cqe) == qp->qp_status.cqc_phase) {
 			dma_rmb();
 			qp->req_cb(qp, qp->sqe + qm->sqe_size *
@@ -1269,7 +1277,7 @@ static int qm_qp_ctx_cfg(struct hisi_qp *qp, int qp_id, int pasid)
  * @qp: The qp we want to start to run.
  * @arg: Accelerator specific argument.
  *
- * After this function, qp can receive request from user. Return qp_id if
+ * After this function, qp can receive request from user. Return 0 if
  * successful, Return -EBUSY if failed.
  */
 int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg)
@@ -1314,7 +1322,7 @@ int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg)
 
 	dev_dbg(dev, "queue %d started\n", qp_id);
 
-	return qp_id;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(hisi_qm_start_qp);
 
@@ -1440,6 +1448,214 @@ static void hisi_qm_cache_wb(struct hisi_qm *qm)
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
+	hisi_qm_cache_wb(qp->qm);
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
+		/*
+		 * dma_mmap_coherent() requires vm_pgoff as 0
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
+	hisi_qm_stop_qp(q->priv);
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
+static const struct uacce_ops uacce_qm_ops = {
+	.get_available_instances = hisi_qm_get_available_instances,
+	.get_queue = hisi_qm_uacce_get_queue,
+	.put_queue = hisi_qm_uacce_put_queue,
+	.start_queue = hisi_qm_uacce_start_queue,
+	.stop_queue = hisi_qm_uacce_stop_queue,
+	.mmap = hisi_qm_uacce_mmap,
+	.ioctl = hisi_qm_uacce_ioctl,
+};
+
+static int qm_alloc_uacce(struct hisi_qm *qm)
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
+	uacce = uacce_alloc(&pdev->dev, &interface);
+	if (IS_ERR(uacce))
+		return PTR_ERR(uacce);
+
+	if (uacce->flags & UACCE_DEV_SVA) {
+		qm->use_sva = true;
+	} else {
+		/* only consider sva case */
+		uacce_remove(uacce);
+		qm->uacce = NULL;
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
+	uacce->qf_pg_num[UACCE_QFRT_MMIO] = mmio_page_nr;
+	uacce->qf_pg_num[UACCE_QFRT_DUS]  = dus_page_nr;
+
+	qm->uacce = uacce;
+
+	return 0;
+}
+
 /**
  * hisi_qm_get_free_qp_num() - Get free number of qp in qm.
  * @qm: The qm which want to get free qp.
@@ -1482,10 +1698,14 @@ int hisi_qm_init(struct hisi_qm *qm)
 		return -EINVAL;
 	}
 
+	ret = qm_alloc_uacce(qm);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "fail to alloc uacce (%d)\n", ret);
+
 	ret = pci_enable_device_mem(pdev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to enable device mem!\n");
-		return ret;
+		goto err_remove_uacce;
 	}
 
 	ret = pci_request_mem_regions(pdev, qm->dev_name);
@@ -1494,8 +1714,9 @@ int hisi_qm_init(struct hisi_qm *qm)
 		goto err_disable_pcidev;
 	}
 
-	qm->io_base = ioremap(pci_resource_start(pdev, PCI_BAR_2),
-			      pci_resource_len(qm->pdev, PCI_BAR_2));
+	qm->phys_base = pci_resource_start(pdev, PCI_BAR_2);
+	qm->phys_size = pci_resource_len(qm->pdev, PCI_BAR_2);
+	qm->io_base = ioremap(qm->phys_base, qm->phys_size);
 	if (!qm->io_base) {
 		ret = -EIO;
 		goto err_release_mem_regions;
@@ -1538,6 +1759,9 @@ int hisi_qm_init(struct hisi_qm *qm)
 	pci_release_mem_regions(pdev);
 err_disable_pcidev:
 	pci_disable_device(pdev);
+err_remove_uacce:
+	uacce_remove(qm->uacce);
+	qm->uacce = NULL;
 
 	return ret;
 }
@@ -1554,6 +1778,9 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	struct device *dev = &pdev->dev;
 
+	uacce_remove(qm->uacce);
+	qm->uacce = NULL;
+
 	if (qm->use_dma_api && qm->qdma.va) {
 		hisi_qm_cache_wb(qm);
 		dma_free_coherent(dev, qm->qdma.size,
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 078b8f1..c096f80 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -77,6 +77,9 @@
 
 #define HISI_ACC_SGL_SGE_NR_MAX		255
 
+/* page number for queue file region */
+#define QM_DOORBELL_PAGE_NR		1
+
 enum qp_state {
 	QP_STOP,
 };
@@ -162,7 +165,12 @@ struct hisi_qm {
 	u32 error_mask;
 	u32 msi_mask;
 
+	const char *algs;
 	bool use_dma_api;
+	bool use_sva;
+	resource_size_t phys_base;
+	resource_size_t phys_size;
+	struct uacce_device *uacce;
 };
 
 struct hisi_qp_status {
@@ -192,10 +200,13 @@ struct hisi_qp {
 	struct hisi_qp_ops *hw_ops;
 	void *qp_ctx;
 	void (*req_cb)(struct hisi_qp *qp, void *data);
+	void (*event_cb)(struct hisi_qp *qp);
 	struct work_struct work;
 	struct workqueue_struct *wq;
 
 	struct hisi_qm *qm;
+	u16 pasid;
+	struct uacce_queue *uacce_q;
 };
 
 int hisi_qm_init(struct hisi_qm *qm);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 853b97e..622f60b 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/seq_file.h>
 #include <linux/topology.h>
+#include <linux/uacce.h>
 #include "zip.h"
 
 #define PCI_DEVICE_ID_ZIP_PF		0xa250
@@ -351,8 +352,14 @@ static void hisi_zip_set_user_domain_and_cache(struct hisi_zip *hisi_zip)
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
@@ -797,6 +804,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	qm->pdev = pdev;
 	qm->ver = rev_id;
 
+	qm->algs = "zlib\ngzip";
 	qm->sqe_size = HZIP_SQE_SIZE;
 	qm->dev_name = hisi_zip_name;
 	qm->fun_type = (pdev->device == PCI_DEVICE_ID_ZIP_PF) ? QM_HW_PF :
@@ -840,6 +848,10 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	hisi_zip_add_to_list(hisi_zip);
 
+	ret = uacce_register(qm->uacce);
+	if (ret)
+		goto err_qm_uninit;
+
 	if (qm->fun_type == QM_HW_PF && vfs_num > 0) {
 		ret = hisi_zip_sriov_enable(pdev, vfs_num);
 		if (ret < 0)
diff --git a/include/uapi/misc/uacce/hisi_qm.h b/include/uapi/misc/uacce/hisi_qm.h
new file mode 100644
index 0000000..6435f0b
--- /dev/null
+++ b/include/uapi/misc/uacce/hisi_qm.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_HISI_QM_H
+#define _UAPI_HISI_QM_H
+
+#include <linux/types.h>
+
+/**
+ * struct hisi_qp_ctx - User data for hisi qp.
+ * @id: qp_index return to user space
+ * @qc_type: Accelerator algorithm type
+ */
+struct hisi_qp_ctx {
+	__u16 id;
+	__u16 qc_type;
+};
+
+#define HISI_QM_API_VER_BASE "hisi_qm_v1"
+#define HISI_QM_API_VER2_BASE "hisi_qm_v2"
+
+/* UACCE_CMD_QM_SET_QP_CTX: Set qp algorithm type */
+#define UACCE_CMD_QM_SET_QP_CTX	_IOWR('H', 10, struct hisi_qp_ctx)
+
+#endif
-- 
2.7.4

