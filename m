Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E967C1DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 11:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfI3JYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 05:24:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37950 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730376AbfI3JX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:23:58 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7537252816E54C323A7B;
        Mon, 30 Sep 2019 17:23:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Sep 2019 17:23:45 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linuxarm@huawei.com>, <forest.zhouchang@huawei.com>,
        Zaibo Xu <xuzaibo@huawei.com>, Hui Tang <tanghui20@huawei.com>
Subject: [PATCH 1/5] crypto: hisilicon - add HiSilicon HPRE accelerator
Date:   Mon, 30 Sep 2019 17:20:05 +0800
Message-ID: <1569835209-44326-2-git-send-email-xuzaibo@huawei.com>
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

The HiSilicon HPRE accelerator implements RSA and DH algorithms. It
uses Hisilicon QM as interface to CPU.

This patch provides PCIe driver to the accelerator and registers its
algorithms to crypto akcipher and kpp interfaces.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/Kconfig            |   11 +
 drivers/crypto/hisilicon/Makefile           |    1 +
 drivers/crypto/hisilicon/hpre/Makefile      |    2 +
 drivers/crypto/hisilicon/hpre/hpre.h        |   48 ++
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 1137 +++++++++++++++++++++++++++
 drivers/crypto/hisilicon/hpre/hpre_main.c   |  503 ++++++++++++
 6 files changed, 1702 insertions(+)
 create mode 100644 drivers/crypto/hisilicon/hpre/Makefile
 create mode 100644 drivers/crypto/hisilicon/hpre/hpre.h
 create mode 100644 drivers/crypto/hisilicon/hpre/hpre_crypto.c
 create mode 100644 drivers/crypto/hisilicon/hpre/hpre_main.c

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 79c82ba..82fb810d 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -31,3 +31,14 @@ config CRYPTO_DEV_HISI_ZIP
 	select SG_SPLIT
 	help
 	  Support for HiSilicon ZIP Driver
+
+config CRYPTO_DEV_HISI_HPRE
+	tristate "Support for HISI HPRE accelerator"
+	depends on PCI && PCI_MSI
+	depends on ARM64 || (COMPILE_TEST && 64BIT)
+	select CRYPTO_DEV_HISI_QM
+	select CRYPTO_DH
+	select CRYPTO_RSA
+	help
+	  Support for HiSilicon HPRE(High Performance RSA Engine)
+	  accelerator, which can accelerate RSA and DH algorithms.
diff --git a/drivers/crypto/hisilicon/Makefile b/drivers/crypto/hisilicon/Makefile
index 4978d14..6cbfba0 100644
--- a/drivers/crypto/hisilicon/Makefile
+++ b/drivers/crypto/hisilicon/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CRYPTO_DEV_HISI_HPRE) += hpre/
 obj-$(CONFIG_CRYPTO_DEV_HISI_SEC) += sec/
 obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += hisi_qm.o
 hisi_qm-objs = qm.o sgl.o
diff --git a/drivers/crypto/hisilicon/hpre/Makefile b/drivers/crypto/hisilicon/hpre/Makefile
new file mode 100644
index 0000000..4fd32b7
--- /dev/null
+++ b/drivers/crypto/hisilicon/hpre/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_CRYPTO_DEV_HISI_HPRE) += hisi_hpre.o
+hisi_hpre-objs = hpre_main.o hpre_crypto.o
diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
new file mode 100644
index 0000000..d219599
--- /dev/null
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2019 HiSilicon Limited. */
+#ifndef __HISI_HPRE_H
+#define __HISI_HPRE_H
+
+#include <linux/list.h>
+#include "../qm.h"
+
+#define HPRE_SQE_SIZE			sizeof(struct hpre_sqe)
+#define HPRE_PF_DEF_Q_NUM		64
+#define HPRE_PF_DEF_Q_BASE		0
+#define HPRE_CLUSTERS_NUM		4
+
+struct hpre {
+	struct hisi_qm qm;
+	struct list_head list;
+	unsigned long status;
+};
+
+enum hpre_alg_type {
+	HPRE_ALG_NC_NCRT = 0x0,
+	HPRE_ALG_NC_CRT = 0x1,
+	HPRE_ALG_KG_STD = 0x2,
+	HPRE_ALG_KG_CRT = 0x3,
+	HPRE_ALG_DH_G2 = 0x4,
+	HPRE_ALG_DH = 0x5,
+};
+
+struct hpre_sqe {
+	__le32 dw0;
+	__u8 task_len1;
+	__u8 task_len2;
+	__u8 mrttest_num;
+	__u8 resv1;
+	__le64 key;
+	__le64 in;
+	__le64 out;
+	__le16 tag;
+	__le16 resv2;
+#define _HPRE_SQE_ALIGN_EXT	7
+	__le32 rsvd1[_HPRE_SQE_ALIGN_EXT];
+};
+
+struct hpre *hpre_find_device(int node);
+int hpre_algs_register(void);
+void hpre_algs_unregister(void);
+
+#endif
diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
new file mode 100644
index 0000000..98f037e
--- /dev/null
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -0,0 +1,1137 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 HiSilicon Limited. */
+#include <crypto/akcipher.h>
+#include <crypto/dh.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/kpp.h>
+#include <crypto/internal/rsa.h>
+#include <crypto/kpp.h>
+#include <crypto/scatterwalk.h>
+#include <linux/dma-mapping.h>
+#include <linux/fips.h>
+#include <linux/module.h>
+#include "hpre.h"
+
+struct hpre_ctx;
+
+#define HPRE_CRYPTO_ALG_PRI	1000
+#define HPRE_ALIGN_SZ		64
+#define HPRE_BITS_2_BYTES_SHIFT	3
+#define HPRE_RSA_512BITS_KSZ	64
+#define HPRE_RSA_1536BITS_KSZ	192
+#define HPRE_CRT_PRMS		5
+#define HPRE_CRT_Q		2
+#define HPRE_CRT_P		3
+#define HPRE_CRT_INV		4
+#define HPRE_DH_G_FLAG		0x02
+#define HPRE_TRY_SEND_TIMES	100
+#define HPRE_INVLD_REQ_ID		(-1)
+#define HPRE_DEV(ctx)		(&((ctx)->qp->qm->pdev->dev))
+
+#define HPRE_SQE_ALG_BITS	5
+#define HPRE_SQE_DONE_SHIFT	30
+#define HPRE_DH_MAX_P_SZ	512
+
+typedef void (*hpre_cb)(struct hpre_ctx *ctx, void *sqe);
+
+struct hpre_rsa_ctx {
+	/* low address: e--->n */
+	char *pubkey;
+	dma_addr_t dma_pubkey;
+
+	/* low address: d--->n */
+	char *prikey;
+	dma_addr_t dma_prikey;
+
+	/* low address: dq->dp->q->p->qinv */
+	char *crt_prikey;
+	dma_addr_t dma_crt_prikey;
+
+	struct crypto_akcipher *soft_tfm;
+};
+
+struct hpre_dh_ctx {
+	/*
+	 * If base is g we compute the public key
+	 *	ya = g^xa mod p; [RFC2631 sec 2.1.1]
+	 * else if base if the counterpart public key we
+	 * compute the shared secret
+	 *	ZZ = yb^xa mod p; [RFC2631 sec 2.1.1]
+	 */
+	char *xa_p; /* low address: d--->n, please refer to Hisilicon HPRE UM */
+	dma_addr_t dma_xa_p;
+
+	char *g; /* m */
+	dma_addr_t dma_g;
+};
+
+struct hpre_ctx {
+	struct hisi_qp *qp;
+	struct hpre_asym_request **req_list;
+	spinlock_t req_lock;
+	unsigned int key_sz;
+	bool crt_g2_mode;
+	struct idr req_idr;
+	union {
+		struct hpre_rsa_ctx rsa;
+		struct hpre_dh_ctx dh;
+	};
+};
+
+struct hpre_asym_request {
+	char *src;
+	char *dst;
+	struct hpre_sqe req;
+	struct hpre_ctx *ctx;
+	union {
+		struct akcipher_request *rsa;
+		struct kpp_request *dh;
+	} areq;
+	int err;
+	int req_id;
+	hpre_cb cb;
+};
+
+static DEFINE_MUTEX(hpre_alg_lock);
+static unsigned int hpre_active_devs;
+
+static int hpre_alloc_req_id(struct hpre_ctx *ctx)
+{
+	unsigned long flags;
+	int id;
+
+	spin_lock_irqsave(&ctx->req_lock, flags);
+	id = idr_alloc(&ctx->req_idr, NULL, 0, QM_Q_DEPTH, GFP_ATOMIC);
+	spin_unlock_irqrestore(&ctx->req_lock, flags);
+
+	return id;
+}
+
+static void hpre_free_req_id(struct hpre_ctx *ctx, int req_id)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->req_lock, flags);
+	idr_remove(&ctx->req_idr, req_id);
+	spin_unlock_irqrestore(&ctx->req_lock, flags);
+}
+
+static int hpre_add_req_to_ctx(struct hpre_asym_request *hpre_req)
+{
+	struct hpre_ctx *ctx;
+	int id;
+
+	ctx = hpre_req->ctx;
+	id = hpre_alloc_req_id(ctx);
+	if (id < 0)
+		return -EINVAL;
+
+	ctx->req_list[id] = hpre_req;
+	hpre_req->req_id = id;
+
+	return id;
+}
+
+static void hpre_rm_req_from_ctx(struct hpre_asym_request *hpre_req)
+{
+	struct hpre_ctx *ctx = hpre_req->ctx;
+	int id = hpre_req->req_id;
+
+	if (hpre_req->req_id >= 0) {
+		hpre_req->req_id = HPRE_INVLD_REQ_ID;
+		ctx->req_list[id] = NULL;
+		hpre_free_req_id(ctx, id);
+	}
+}
+
+static struct hisi_qp *hpre_get_qp_and_start(void)
+{
+	struct hisi_qp *qp;
+	struct hpre *hpre;
+	int ret;
+
+	/* find the proper hpre device, which is near the current CPU core */
+	hpre = hpre_find_device(cpu_to_node(smp_processor_id()));
+	if (!hpre) {
+		pr_err("Can not find proper hpre device!\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	qp = hisi_qm_create_qp(&hpre->qm, 0);
+	if (IS_ERR(qp)) {
+		pci_err(hpre->qm.pdev, "Can not create qp!\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	ret = hisi_qm_start_qp(qp, 0);
+	if (ret < 0) {
+		hisi_qm_release_qp(qp);
+		pci_err(hpre->qm.pdev, "Can not start qp!\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return qp;
+}
+
+static int hpre_get_data_dma_addr(struct hpre_asym_request *hpre_req,
+			      struct scatterlist *data, unsigned int len,
+			      int is_src, dma_addr_t *tmp)
+{
+	struct hpre_ctx *ctx = hpre_req->ctx;
+	struct device *dev = HPRE_DEV(ctx);
+	enum dma_data_direction dma_dir;
+
+	if (is_src) {
+		hpre_req->src = NULL;
+		dma_dir = DMA_TO_DEVICE;
+	} else {
+		hpre_req->dst = NULL;
+		dma_dir = DMA_FROM_DEVICE;
+	}
+	*tmp = dma_map_single(dev, sg_virt(data),
+			      len, dma_dir);
+	if (dma_mapping_error(dev, *tmp)) {
+		dev_err(dev, "dma map data err!\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int hpre_prepare_dma_buf(struct hpre_asym_request *hpre_req,
+			       struct scatterlist *data, unsigned int len,
+			       int is_src, dma_addr_t *tmp)
+{
+	struct hpre_ctx *ctx = hpre_req->ctx;
+	struct device *dev = HPRE_DEV(ctx);
+	void *ptr;
+	int shift;
+
+	shift = ctx->key_sz - len;
+	if (shift < 0)
+		return -EINVAL;
+
+	ptr = dma_alloc_coherent(dev, ctx->key_sz, tmp, GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	if (is_src) {
+		scatterwalk_map_and_copy(ptr + shift, data, 0, len, 0);
+		hpre_req->src = ptr;
+	} else {
+		hpre_req->dst = ptr;
+	}
+
+	return 0;
+}
+
+static int hpre_hw_data_init(struct hpre_asym_request *hpre_req,
+			 struct scatterlist *data, unsigned int len,
+			 int is_src, int is_dh)
+{
+	struct hpre_sqe *msg = &hpre_req->req;
+	struct hpre_ctx *ctx = hpre_req->ctx;
+	dma_addr_t tmp;
+	int ret;
+
+	/* when the data is dh's source, we should format it */
+	if ((sg_is_last(data) && len == ctx->key_sz) &&
+	    ((is_dh && !is_src) || !is_dh))
+		ret = hpre_get_data_dma_addr(hpre_req, data, len, is_src, &tmp);
+	else
+		ret = hpre_prepare_dma_buf(hpre_req, data, len,
+					  is_src, &tmp);
+	if (ret)
+		return ret;
+
+	if (is_src)
+		msg->in = cpu_to_le64(tmp);
+	else
+		msg->out = cpu_to_le64(tmp);
+
+	return 0;
+}
+
+static void hpre_hw_data_clr_all(struct hpre_ctx *ctx,
+			     struct hpre_asym_request *req,
+			     struct scatterlist *dst, struct scatterlist *src)
+{
+	struct device *dev = HPRE_DEV(ctx);
+	struct hpre_sqe *sqe = &req->req;
+	dma_addr_t tmp;
+
+	tmp = le64_to_cpu(sqe->in);
+	if (!tmp)
+		return;
+
+	if (src) {
+		if (req->src)
+			dma_free_coherent(dev, ctx->key_sz,
+					  req->src, tmp);
+		else
+			dma_unmap_single(dev, tmp,
+					 ctx->key_sz, DMA_TO_DEVICE);
+	}
+
+	tmp = le64_to_cpu(sqe->out);
+	if (!tmp)
+		return;
+
+	if (req->dst) {
+		if (dst)
+			scatterwalk_map_and_copy(req->dst, dst, 0,
+						 ctx->key_sz, 1);
+		dma_free_coherent(dev, ctx->key_sz, req->dst, tmp);
+	} else {
+		dma_unmap_single(dev, tmp, ctx->key_sz, DMA_FROM_DEVICE);
+	}
+}
+
+static int hpre_alg_res_post_hf(struct hpre_ctx *ctx, struct hpre_sqe *sqe,
+			    void **kreq)
+{
+	struct hpre_asym_request *req;
+	int err, id, done;
+
+#define HPRE_NO_HW_ERR		0
+#define HPRE_HW_TASK_DONE	3
+#define HREE_HW_ERR_MASK	0x7ff
+#define HREE_SQE_DONE_MASK	0x3
+	id = (int)le16_to_cpu(sqe->tag);
+	req = ctx->req_list[id];
+	hpre_rm_req_from_ctx(req);
+	*kreq = req;
+
+	err = (le32_to_cpu(sqe->dw0) >> HPRE_SQE_ALG_BITS) &
+		HREE_HW_ERR_MASK;
+
+	done = (le32_to_cpu(sqe->dw0) >> HPRE_SQE_DONE_SHIFT) &
+		HREE_SQE_DONE_MASK;
+
+	if (err == HPRE_NO_HW_ERR &&  done == HPRE_HW_TASK_DONE)
+		return  0;
+
+	return -EINVAL;
+}
+
+static int hpre_ctx_set(struct hpre_ctx *ctx, struct hisi_qp *qp, int qlen)
+{
+	if (!ctx || !qp || qlen < 0)
+		return -EINVAL;
+
+	spin_lock_init(&ctx->req_lock);
+	ctx->qp = qp;
+
+	ctx->req_list = kcalloc(qlen, sizeof(void *), GFP_KERNEL);
+	if (!ctx->req_list)
+		return -ENOMEM;
+	ctx->key_sz = 0;
+	ctx->crt_g2_mode = false;
+	idr_init(&ctx->req_idr);
+
+	return 0;
+}
+
+static void hpre_ctx_clear(struct hpre_ctx *ctx, bool is_clear_all)
+{
+	if (is_clear_all) {
+		idr_destroy(&ctx->req_idr);
+		kfree(ctx->req_list);
+		hisi_qm_release_qp(ctx->qp);
+	}
+
+	ctx->crt_g2_mode = false;
+	ctx->key_sz = 0;
+}
+
+static void hpre_dh_cb(struct hpre_ctx *ctx, void *resp)
+{
+	struct hpre_asym_request *req;
+	struct kpp_request *areq;
+	int ret;
+
+	ret = hpre_alg_res_post_hf(ctx, resp, (void **)&req);
+	areq = req->areq.dh;
+	areq->dst_len = ctx->key_sz;
+	hpre_hw_data_clr_all(ctx, req, areq->dst, areq->src);
+	kpp_request_complete(areq, ret);
+}
+
+static void hpre_rsa_cb(struct hpre_ctx *ctx, void *resp)
+{
+	struct hpre_asym_request *req;
+	struct akcipher_request *areq;
+	int ret;
+
+	ret = hpre_alg_res_post_hf(ctx, resp, (void **)&req);
+	areq = req->areq.rsa;
+	areq->dst_len = ctx->key_sz;
+	hpre_hw_data_clr_all(ctx, req, areq->dst, areq->src);
+	akcipher_request_complete(areq, ret);
+}
+
+static void hpre_alg_cb(struct hisi_qp *qp, void *resp)
+{
+	struct hpre_ctx *ctx = qp->qp_ctx;
+	struct hpre_sqe *sqe = resp;
+
+	ctx->req_list[sqe->tag]->cb(ctx, resp);
+}
+
+static int hpre_ctx_init(struct hpre_ctx *ctx)
+{
+	struct hisi_qp *qp;
+
+	qp = hpre_get_qp_and_start();
+	if (IS_ERR(qp))
+		return PTR_ERR(qp);
+
+	qp->qp_ctx = ctx;
+	qp->req_cb = hpre_alg_cb;
+
+	return hpre_ctx_set(ctx, qp, QM_Q_DEPTH);
+}
+
+static int hpre_msg_request_set(struct hpre_ctx *ctx, void *req, bool is_rsa)
+{
+	struct hpre_asym_request *h_req;
+	struct hpre_sqe *msg;
+	int req_id;
+	void *tmp;
+
+	if (is_rsa) {
+		struct akcipher_request *akreq = req;
+
+		if (akreq->dst_len < ctx->key_sz) {
+			akreq->dst_len = ctx->key_sz;
+			return -EOVERFLOW;
+		}
+
+		tmp = akcipher_request_ctx(akreq);
+		h_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+		h_req->cb = hpre_rsa_cb;
+		h_req->areq.rsa = akreq;
+		msg = &h_req->req;
+		memset(msg, 0, sizeof(*msg));
+	} else {
+		struct kpp_request *kreq = req;
+
+		if (kreq->dst_len < ctx->key_sz) {
+			kreq->dst_len = ctx->key_sz;
+			return -EOVERFLOW;
+		}
+
+		tmp = kpp_request_ctx(kreq);
+		h_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+		h_req->cb = hpre_dh_cb;
+		h_req->areq.dh = kreq;
+		msg = &h_req->req;
+		memset(msg, 0, sizeof(*msg));
+		msg->key = cpu_to_le64((u64)ctx->dh.dma_xa_p);
+	}
+
+	msg->dw0 |= cpu_to_le32(0x1 << HPRE_SQE_DONE_SHIFT);
+	msg->task_len1 = (ctx->key_sz >> HPRE_BITS_2_BYTES_SHIFT) - 1;
+	h_req->ctx = ctx;
+
+	req_id = hpre_add_req_to_ctx(h_req);
+	if (req_id < 0)
+		return -EBUSY;
+
+	msg->tag = cpu_to_le16((u16)req_id);
+
+	return 0;
+}
+
+#ifdef CONFIG_CRYPTO_DH
+static int hpre_dh_compute_value(struct kpp_request *req)
+{
+	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
+	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
+	void *tmp = kpp_request_ctx(req);
+	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+	struct hpre_sqe *msg = &hpre_req->req;
+	int ctr = 0;
+	int ret;
+
+	if (!ctx)
+		return -EINVAL;
+
+	ret = hpre_msg_request_set(ctx, req, false);
+	if (ret)
+		return ret;
+
+	if (req->src) {
+		ret = hpre_hw_data_init(hpre_req, req->src, req->src_len, 1, 1);
+		if (ret)
+			goto clear_all;
+	}
+
+	ret = hpre_hw_data_init(hpre_req, req->dst, req->dst_len, 0, 1);
+	if (ret)
+		goto clear_all;
+
+	if (ctx->crt_g2_mode && !req->src)
+		msg->dw0 |= HPRE_ALG_DH_G2;
+	else
+		msg->dw0 |= HPRE_ALG_DH;
+	do {
+		ret = hisi_qp_send(ctx->qp, msg);
+	} while (ret == -EBUSY && ctr++ < HPRE_TRY_SEND_TIMES);
+
+	/* success */
+	if (!ret)
+		return -EINPROGRESS;
+
+clear_all:
+	hpre_rm_req_from_ctx(hpre_req);
+	hpre_hw_data_clr_all(ctx, hpre_req, req->dst, req->src);
+
+	return ret;
+}
+
+static int hpre_is_dh_params_length_valid(unsigned int key_sz)
+{
+#define _HPRE_DH_GRP1		768
+#define _HPRE_DH_GRP2		1024
+#define _HPRE_DH_GRP5		1536
+#define _HPRE_DH_GRP14		2048
+#define _HPRE_DH_GRP15		3072
+#define _HPRE_DH_GRP16		4096
+	switch (key_sz) {
+	case _HPRE_DH_GRP1:
+	case _HPRE_DH_GRP2:
+	case _HPRE_DH_GRP5:
+	case _HPRE_DH_GRP14:
+	case _HPRE_DH_GRP15:
+	case _HPRE_DH_GRP16:
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int hpre_dh_set_params(struct hpre_ctx *ctx, struct dh *params)
+{
+	struct device *dev = HPRE_DEV(ctx);
+	unsigned int sz;
+
+	if (params->p_size > HPRE_DH_MAX_P_SZ)
+		return -EINVAL;
+
+	if (hpre_is_dh_params_length_valid(params->p_size <<
+		HPRE_BITS_2_BYTES_SHIFT))
+		return -EINVAL;
+
+	sz = ctx->key_sz = params->p_size;
+	ctx->dh.xa_p = dma_alloc_coherent(dev, sz << 1,
+				&ctx->dh.dma_xa_p, GFP_KERNEL);
+	if (!ctx->dh.xa_p)
+		return -ENOMEM;
+
+	memcpy(ctx->dh.xa_p + sz, params->p, sz);
+
+	/* If g equals 2 don't copy it */
+	if (params->g_size == 1 && *(char *)params->g == HPRE_DH_G_FLAG) {
+		ctx->crt_g2_mode = true;
+		return 0;
+	}
+
+	ctx->dh.g = dma_alloc_coherent(dev, sz, &ctx->dh.dma_g, GFP_KERNEL);
+	if (!ctx->dh.g) {
+		dma_free_coherent(dev, sz << 1, ctx->dh.xa_p,
+				  ctx->dh.dma_xa_p);
+		ctx->dh.xa_p = NULL;
+		return -ENOMEM;
+	}
+
+	memcpy(ctx->dh.g + (sz - params->g_size), params->g, params->g_size);
+
+	return 0;
+}
+
+static void hpre_dh_clear_ctx(struct hpre_ctx *ctx, bool is_clear_all)
+{
+	struct device *dev = HPRE_DEV(ctx);
+	unsigned int sz = ctx->key_sz;
+
+	if (is_clear_all)
+		hisi_qm_stop_qp(ctx->qp);
+
+	if (ctx->dh.g) {
+		memset(ctx->dh.g, 0, sz);
+		dma_free_coherent(dev, sz, ctx->dh.g, ctx->dh.dma_g);
+		ctx->dh.g = NULL;
+	}
+
+	if (ctx->dh.xa_p) {
+		memset(ctx->dh.xa_p, 0, sz);
+		dma_free_coherent(dev, sz << 1, ctx->dh.xa_p,
+				  ctx->dh.dma_xa_p);
+		ctx->dh.xa_p = NULL;
+	}
+
+	hpre_ctx_clear(ctx, is_clear_all);
+}
+
+static int hpre_dh_set_secret(struct crypto_kpp *tfm, const void *buf,
+			      unsigned int len)
+{
+	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
+	struct dh params;
+	int ret;
+
+	if (crypto_dh_decode_key(buf, len, &params) < 0)
+		return -EINVAL;
+
+	/* Free old secret if any */
+	hpre_dh_clear_ctx(ctx, false);
+
+	ret = hpre_dh_set_params(ctx, &params);
+	if (ret < 0)
+		goto err_clear_ctx;
+
+	memcpy(ctx->dh.xa_p + (ctx->key_sz - params.key_size), params.key,
+	       params.key_size);
+
+	return 0;
+
+err_clear_ctx:
+	hpre_dh_clear_ctx(ctx, false);
+	return ret;
+}
+
+static unsigned int hpre_dh_max_size(struct crypto_kpp *tfm)
+{
+	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
+
+	return ctx->key_sz;
+}
+
+static int hpre_dh_init_tfm(struct crypto_kpp *tfm)
+{
+	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
+
+	return hpre_ctx_init(ctx);
+}
+
+static void hpre_dh_exit_tfm(struct crypto_kpp *tfm)
+{
+	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
+
+	hpre_dh_clear_ctx(ctx, true);
+}
+#endif
+
+static void hpre_rsa_drop_leading_zeros(const char **ptr, size_t *len)
+{
+	while (!**ptr && *len) {
+		(*ptr)++;
+		(*len)--;
+	}
+}
+
+static bool hpre_rsa_key_size_is_support(unsigned int len)
+{
+	unsigned int bits = len << HPRE_BITS_2_BYTES_SHIFT;
+
+#define _RSA_1024BITS_KEY_WDTH		1024
+#define _RSA_2048BITS_KEY_WDTH		2048
+#define _RSA_3072BITS_KEY_WDTH		3072
+#define _RSA_4096BITS_KEY_WDTH		4096
+
+	switch (bits) {
+	case _RSA_1024BITS_KEY_WDTH:
+	case _RSA_2048BITS_KEY_WDTH:
+	case _RSA_3072BITS_KEY_WDTH:
+	case _RSA_4096BITS_KEY_WDTH:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int hpre_rsa_enc(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
+	void *tmp = akcipher_request_ctx(req);
+	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+	struct hpre_sqe *msg = &hpre_req->req;
+	int ctr = 0;
+	int ret;
+
+	if (!ctx)
+		return -EINVAL;
+
+	/* For 512 and 1536 bits key size, use soft tfm instead */
+	if (ctx->key_sz == HPRE_RSA_512BITS_KSZ ||
+	    ctx->key_sz == HPRE_RSA_1536BITS_KSZ) {
+		akcipher_request_set_tfm(req, ctx->rsa.soft_tfm);
+		ret = crypto_akcipher_encrypt(req);
+		akcipher_request_set_tfm(req, tfm);
+		return ret;
+	}
+
+	if (!ctx->rsa.pubkey)
+		return -EINVAL;
+
+	ret = hpre_msg_request_set(ctx, req, true);
+	if (ret)
+		return ret;
+
+	msg->dw0 |= HPRE_ALG_NC_NCRT;
+	msg->key = cpu_to_le64((u64)ctx->rsa.dma_pubkey);
+
+	ret = hpre_hw_data_init(hpre_req, req->src, req->src_len, 1, 0);
+	if (ret)
+		goto clear_all;
+
+	ret = hpre_hw_data_init(hpre_req, req->dst, req->dst_len, 0, 0);
+	if (ret)
+		goto clear_all;
+
+	do {
+		ret = hisi_qp_send(ctx->qp, msg);
+	} while (ret == -EBUSY && ctr++ < HPRE_TRY_SEND_TIMES);
+
+	/* success */
+	if (!ret)
+		return -EINPROGRESS;
+
+clear_all:
+	hpre_rm_req_from_ctx(hpre_req);
+	hpre_hw_data_clr_all(ctx, hpre_req, req->dst, req->src);
+
+	return ret;
+}
+
+static int hpre_rsa_dec(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
+	void *tmp = akcipher_request_ctx(req);
+	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+	struct hpre_sqe *msg = &hpre_req->req;
+	int ctr = 0;
+	int ret;
+
+	if (!ctx)
+		return -EINVAL;
+
+	/* For 512 and 1536 bits key size, use soft tfm instead */
+	if (ctx->key_sz == HPRE_RSA_512BITS_KSZ ||
+	    ctx->key_sz == HPRE_RSA_1536BITS_KSZ) {
+		akcipher_request_set_tfm(req, ctx->rsa.soft_tfm);
+		ret = crypto_akcipher_decrypt(req);
+		akcipher_request_set_tfm(req, tfm);
+		return ret;
+	}
+
+	if (!ctx->rsa.prikey)
+		return -EINVAL;
+
+	ret = hpre_msg_request_set(ctx, req, true);
+	if (ret)
+		return ret;
+
+	if (ctx->crt_g2_mode) {
+		msg->key = cpu_to_le64((u64)ctx->rsa.dma_crt_prikey);
+		msg->dw0 |= HPRE_ALG_NC_CRT;
+	} else {
+		msg->key = cpu_to_le64((u64)ctx->rsa.dma_prikey);
+		msg->dw0 |= HPRE_ALG_NC_NCRT;
+	}
+
+	ret = hpre_hw_data_init(hpre_req, req->src, req->src_len, 1, 0);
+	if (ret)
+		goto clear_all;
+
+	ret = hpre_hw_data_init(hpre_req, req->dst, req->dst_len, 0, 0);
+	if (ret)
+		goto clear_all;
+
+	do {
+		ret = hisi_qp_send(ctx->qp, msg);
+	} while (ret == -EBUSY && ctr++ < HPRE_TRY_SEND_TIMES);
+
+	/* success */
+	if (!ret)
+		return -EINPROGRESS;
+
+clear_all:
+	hpre_rm_req_from_ctx(hpre_req);
+	hpre_hw_data_clr_all(ctx, hpre_req, req->dst, req->src);
+
+	return ret;
+}
+
+static int hpre_rsa_set_n(struct hpre_ctx *ctx, const char *value,
+			  size_t vlen, bool private)
+{
+	const char *ptr = value;
+
+	hpre_rsa_drop_leading_zeros(&ptr, &vlen);
+
+	ctx->key_sz = vlen;
+
+	/* if invalid key size provided, we use software tfm */
+	if (!hpre_rsa_key_size_is_support(ctx->key_sz))
+		return 0;
+
+	ctx->rsa.pubkey = dma_alloc_coherent(HPRE_DEV(ctx), vlen << 1,
+					     &ctx->rsa.dma_pubkey,
+					     GFP_KERNEL);
+	if (!ctx->rsa.pubkey)
+		return -ENOMEM;
+
+	if (private) {
+		ctx->rsa.prikey = dma_alloc_coherent(HPRE_DEV(ctx), vlen << 1,
+						     &ctx->rsa.dma_prikey,
+						     GFP_KERNEL);
+		if (!ctx->rsa.prikey) {
+			dma_free_coherent(HPRE_DEV(ctx), vlen << 1,
+					  ctx->rsa.pubkey,
+					  ctx->rsa.dma_pubkey);
+			ctx->rsa.pubkey = NULL;
+			return -ENOMEM;
+		}
+		memcpy(ctx->rsa.prikey + vlen, ptr, vlen);
+	}
+	memcpy(ctx->rsa.pubkey + vlen, ptr, vlen);
+
+	/* Using hardware HPRE to do RSA */
+	return 1;
+}
+
+static int hpre_rsa_set_e(struct hpre_ctx *ctx, const char *value,
+			  size_t vlen)
+{
+	const char *ptr = value;
+
+	hpre_rsa_drop_leading_zeros(&ptr, &vlen);
+
+	if (!ctx->key_sz || !vlen || vlen > ctx->key_sz) {
+		ctx->rsa.pubkey = NULL;
+		return -EINVAL;
+	}
+
+	memcpy(ctx->rsa.pubkey + ctx->key_sz - vlen, ptr, vlen);
+
+	return 0;
+}
+
+static int hpre_rsa_set_d(struct hpre_ctx *ctx, const char *value,
+			  size_t vlen)
+{
+	const char *ptr = value;
+
+	hpre_rsa_drop_leading_zeros(&ptr, &vlen);
+
+	if (!ctx->key_sz || !vlen || vlen > ctx->key_sz)
+		return -EINVAL;
+
+	memcpy(ctx->rsa.prikey + ctx->key_sz - vlen, ptr, vlen);
+
+	return 0;
+}
+
+static int hpre_crt_para_get(char *para, const char *raw,
+			     unsigned int raw_sz, unsigned int para_size)
+{
+	const char *ptr = raw;
+	size_t len = raw_sz;
+
+	hpre_rsa_drop_leading_zeros(&ptr, &len);
+	if (!len || len > para_size)
+		return -EINVAL;
+
+	memcpy(para + para_size - len, ptr, len);
+
+	return 0;
+}
+
+static int hpre_rsa_setkey_crt(struct hpre_ctx *ctx, struct rsa_key *rsa_key)
+{
+	unsigned int hlf_ksz = ctx->key_sz >> 1;
+	struct device *dev = HPRE_DEV(ctx);
+	u64 offset;
+	int ret;
+
+	ctx->rsa.crt_prikey = dma_alloc_coherent(dev, hlf_ksz * HPRE_CRT_PRMS,
+					&ctx->rsa.dma_crt_prikey,
+					GFP_KERNEL);
+	if (!ctx->rsa.crt_prikey)
+		return -ENOMEM;
+
+	ret = hpre_crt_para_get(ctx->rsa.crt_prikey, rsa_key->dq,
+				rsa_key->dq_sz, hlf_ksz);
+	if (ret)
+		goto free_key;
+
+	offset = hlf_ksz;
+	ret = hpre_crt_para_get(ctx->rsa.crt_prikey + offset, rsa_key->dp,
+				rsa_key->dp_sz, hlf_ksz);
+	if (ret)
+		goto free_key;
+
+	offset = hlf_ksz * HPRE_CRT_Q;
+	ret = hpre_crt_para_get(ctx->rsa.crt_prikey + offset,
+				rsa_key->q, rsa_key->q_sz, hlf_ksz);
+	if (ret)
+		goto free_key;
+
+	offset = hlf_ksz * HPRE_CRT_P;
+	ret = hpre_crt_para_get(ctx->rsa.crt_prikey + offset,
+				rsa_key->p, rsa_key->p_sz, hlf_ksz);
+	if (ret)
+		goto free_key;
+
+	offset = hlf_ksz * HPRE_CRT_INV;
+	ret = hpre_crt_para_get(ctx->rsa.crt_prikey + offset,
+				rsa_key->qinv, rsa_key->qinv_sz, hlf_ksz);
+	if (ret)
+		goto free_key;
+
+	ctx->crt_g2_mode = true;
+
+	return 0;
+
+free_key:
+	offset = hlf_ksz * HPRE_CRT_PRMS;
+	memset(ctx->rsa.crt_prikey, 0, offset);
+	dma_free_coherent(dev, hlf_ksz * HPRE_CRT_PRMS, ctx->rsa.crt_prikey,
+			  ctx->rsa.dma_crt_prikey);
+	ctx->rsa.crt_prikey = NULL;
+	ctx->crt_g2_mode = false;
+
+	return ret;
+}
+
+/* If it is clear all, all the resources of the QP will be cleaned. */
+static void hpre_rsa_clear_ctx(struct hpre_ctx *ctx, bool is_clear_all)
+{
+	unsigned int half_key_sz = ctx->key_sz >> 1;
+	struct device *dev = HPRE_DEV(ctx);
+
+	if (is_clear_all)
+		hisi_qm_stop_qp(ctx->qp);
+
+	if (ctx->rsa.pubkey) {
+		dma_free_coherent(dev, ctx->key_sz << 1,
+				  ctx->rsa.pubkey, ctx->rsa.dma_pubkey);
+		ctx->rsa.pubkey = NULL;
+	}
+
+	if (ctx->rsa.crt_prikey) {
+		memset(ctx->rsa.crt_prikey, 0, half_key_sz * HPRE_CRT_PRMS);
+		dma_free_coherent(dev, half_key_sz * HPRE_CRT_PRMS,
+				  ctx->rsa.crt_prikey, ctx->rsa.dma_crt_prikey);
+		ctx->rsa.crt_prikey = NULL;
+	}
+
+	if (ctx->rsa.prikey) {
+		memset(ctx->rsa.prikey, 0, ctx->key_sz);
+		dma_free_coherent(dev, ctx->key_sz << 1, ctx->rsa.prikey,
+				  ctx->rsa.dma_prikey);
+		ctx->rsa.prikey = NULL;
+	}
+
+	hpre_ctx_clear(ctx, is_clear_all);
+}
+
+/*
+ * we should judge if it is CRT or not,
+ * CRT: return true,  N-CRT: return false .
+ */
+static bool hpre_is_crt_key(struct rsa_key *key)
+{
+	u16 len = key->p_sz + key->q_sz + key->dp_sz + key->dq_sz +
+		  key->qinv_sz;
+
+#define LEN_OF_NCRT_PARA	5
+
+	/* N-CRT less than 5 parameters */
+	return len > LEN_OF_NCRT_PARA;
+}
+
+static int hpre_rsa_setkey(struct hpre_ctx *ctx, const void *key,
+			   unsigned int keylen, bool private)
+{
+	struct rsa_key rsa_key;
+	int ret;
+
+	hpre_rsa_clear_ctx(ctx, false);
+
+	if (private)
+		ret = rsa_parse_priv_key(&rsa_key, key, keylen);
+	else
+		ret = rsa_parse_pub_key(&rsa_key, key, keylen);
+	if (ret < 0)
+		return ret;
+
+	ret = hpre_rsa_set_n(ctx, rsa_key.n, rsa_key.n_sz, private);
+	if (ret <= 0)
+		return ret;
+
+	if (private) {
+		ret = hpre_rsa_set_d(ctx, rsa_key.d, rsa_key.d_sz);
+		if (ret < 0)
+			goto free;
+
+		if (hpre_is_crt_key(&rsa_key)) {
+			ret = hpre_rsa_setkey_crt(ctx, &rsa_key);
+			if (ret < 0)
+				goto free;
+		}
+	}
+
+	ret = hpre_rsa_set_e(ctx, rsa_key.e, rsa_key.e_sz);
+	if (ret < 0)
+		goto free;
+
+	if ((private && !ctx->rsa.prikey) || !ctx->rsa.pubkey) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	return 0;
+
+free:
+	hpre_rsa_clear_ctx(ctx, false);
+	return ret;
+}
+
+static int hpre_rsa_setpubkey(struct crypto_akcipher *tfm, const void *key,
+			      unsigned int keylen)
+{
+	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
+	int ret;
+
+	ret = crypto_akcipher_set_pub_key(ctx->rsa.soft_tfm, key, keylen);
+	if (ret)
+		return ret;
+
+	return hpre_rsa_setkey(ctx, key, keylen, false);
+}
+
+static int hpre_rsa_setprivkey(struct crypto_akcipher *tfm, const void *key,
+			       unsigned int keylen)
+{
+	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
+	int ret;
+
+	ret = crypto_akcipher_set_priv_key(ctx->rsa.soft_tfm, key, keylen);
+	if (ret)
+		return ret;
+
+	return hpre_rsa_setkey(ctx, key, keylen, true);
+}
+
+static unsigned int hpre_rsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	/* For 512 and 1536 bits key size, use soft tfm instead */
+	if (ctx->key_sz == HPRE_RSA_512BITS_KSZ ||
+	    ctx->key_sz == HPRE_RSA_1536BITS_KSZ)
+		return crypto_akcipher_maxsize(ctx->rsa.soft_tfm);
+
+	return ctx->key_sz;
+}
+
+static int hpre_rsa_init_tfm(struct crypto_akcipher *tfm)
+{
+	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	ctx->rsa.soft_tfm = crypto_alloc_akcipher("rsa-generic", 0, 0);
+	if (IS_ERR(ctx->rsa.soft_tfm)) {
+		pr_err("Can not alloc_akcipher!\n");
+		return PTR_ERR(ctx->rsa.soft_tfm);
+	}
+
+	return hpre_ctx_init(ctx);
+}
+
+static void hpre_rsa_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	hpre_rsa_clear_ctx(ctx, true);
+	crypto_free_akcipher(ctx->rsa.soft_tfm);
+}
+
+static struct akcipher_alg rsa = {
+	.sign = hpre_rsa_dec,
+	.verify = hpre_rsa_enc,
+	.encrypt = hpre_rsa_enc,
+	.decrypt = hpre_rsa_dec,
+	.set_pub_key = hpre_rsa_setpubkey,
+	.set_priv_key = hpre_rsa_setprivkey,
+	.max_size = hpre_rsa_max_size,
+	.init = hpre_rsa_init_tfm,
+	.exit = hpre_rsa_exit_tfm,
+	.reqsize = sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ,
+	.base = {
+		.cra_ctxsize = sizeof(struct hpre_ctx),
+		.cra_priority = HPRE_CRYPTO_ALG_PRI,
+		.cra_name = "rsa",
+		.cra_driver_name = "hpre-rsa",
+		.cra_module = THIS_MODULE,
+	},
+};
+
+#ifdef CONFIG_CRYPTO_DH
+static struct kpp_alg dh = {
+	.set_secret = hpre_dh_set_secret,
+	.generate_public_key = hpre_dh_compute_value,
+	.compute_shared_secret = hpre_dh_compute_value,
+	.max_size = hpre_dh_max_size,
+	.init = hpre_dh_init_tfm,
+	.exit = hpre_dh_exit_tfm,
+	.reqsize = sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ,
+	.base = {
+		.cra_ctxsize = sizeof(struct hpre_ctx),
+		.cra_priority = HPRE_CRYPTO_ALG_PRI,
+		.cra_name = "dh",
+		.cra_driver_name = "hpre-dh",
+		.cra_module = THIS_MODULE,
+	},
+};
+#endif
+
+int hpre_algs_register(void)
+{
+	int ret = 0;
+
+	mutex_lock(&hpre_alg_lock);
+	if (++hpre_active_devs == 1) {
+		rsa.base.cra_flags = 0;
+		ret = crypto_register_akcipher(&rsa);
+		if (ret)
+			goto unlock;
+#ifdef CONFIG_CRYPTO_DH
+		ret = crypto_register_kpp(&dh);
+		if (ret) {
+			crypto_unregister_akcipher(&rsa);
+			goto unlock;
+		}
+#endif
+	}
+
+unlock:
+	mutex_unlock(&hpre_alg_lock);
+	return ret;
+}
+
+void hpre_algs_unregister(void)
+{
+	mutex_lock(&hpre_alg_lock);
+	if (--hpre_active_devs == 0) {
+		crypto_unregister_akcipher(&rsa);
+#ifdef CONFIG_CRYPTO_DH
+		crypto_unregister_kpp(&dh);
+#endif
+	}
+	mutex_unlock(&hpre_alg_lock);
+}
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
new file mode 100644
index 0000000..9cf46e4
--- /dev/null
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2019 HiSilicon Limited. */
+#include <linux/acpi.h>
+#include <linux/aer.h>
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/topology.h>
+#include "hpre.h"
+
+#define HPRE_VF_NUM			63
+#define HPRE_QUEUE_NUM_V2		1024
+#define HPRE_QM_ABNML_INT_MASK		0x100004
+#define HPRE_CTRL_CNT_CLR_CE_BIT	BIT(0)
+#define HPRE_COMM_CNT_CLR_CE		0x0
+#define HPRE_CTRL_CNT_CLR_CE		0x301000
+#define HPRE_FSM_MAX_CNT		0x301008
+#define HPRE_VFG_AXQOS			0x30100c
+#define HPRE_VFG_AXCACHE		0x301010
+#define HPRE_RDCHN_INI_CFG		0x301014
+#define HPRE_AWUSR_FP_CFG		0x301018
+#define HPRE_BD_ENDIAN			0x301020
+#define HPRE_ECC_BYPASS			0x301024
+#define HPRE_RAS_WIDTH_CFG		0x301028
+#define HPRE_POISON_BYPASS		0x30102c
+#define HPRE_BD_ARUSR_CFG		0x301030
+#define HPRE_BD_AWUSR_CFG		0x301034
+#define HPRE_TYPES_ENB			0x301038
+#define HPRE_DATA_RUSER_CFG		0x30103c
+#define HPRE_DATA_WUSER_CFG		0x301040
+#define HPRE_INT_MASK			0x301400
+#define HPRE_INT_STATUS			0x301800
+#define HPRE_CORE_INT_ENABLE		0
+#define HPRE_CORE_INT_DISABLE		0x003fffff
+#define HPRE_RAS_ECC_1BIT_TH		0x30140c
+#define HPRE_RDCHN_INI_ST		0x301a00
+#define HPRE_CLSTR_BASE			0x302000
+#define HPRE_CORE_EN_OFFSET		0x04
+#define HPRE_CORE_INI_CFG_OFFSET	0x20
+#define HPRE_CORE_INI_STATUS_OFFSET	0x80
+#define HPRE_CORE_HTBT_WARN_OFFSET	0x8c
+#define HPRE_CORE_IS_SCHD_OFFSET	0x90
+
+#define HPRE_RAS_CE_ENB			0x301410
+#define HPRE_HAC_RAS_CE_ENABLE		0x3f
+#define HPRE_RAS_NFE_ENB		0x301414
+#define HPRE_HAC_RAS_NFE_ENABLE		0x3fffc0
+#define HPRE_RAS_FE_ENB			0x301418
+#define HPRE_HAC_RAS_FE_ENABLE		0
+
+#define HPRE_CORE_ENB		(HPRE_CLSTR_BASE + HPRE_CORE_EN_OFFSET)
+#define HPRE_CORE_INI_CFG	(HPRE_CLSTR_BASE + HPRE_CORE_INI_CFG_OFFSET)
+#define HPRE_CORE_INI_STATUS (HPRE_CLSTR_BASE + HPRE_CORE_INI_STATUS_OFFSET)
+#define HPRE_HAC_ECC1_CNT		0x301a04
+#define HPRE_HAC_ECC2_CNT		0x301a08
+#define HPRE_HAC_INT_STATUS		0x301800
+#define HPRE_HAC_SOURCE_INT		0x301600
+#define MASTER_GLOBAL_CTRL_SHUTDOWN	1
+#define MASTER_TRANS_RETURN_RW		3
+#define HPRE_MASTER_TRANS_RETURN	0x300150
+#define HPRE_MASTER_GLOBAL_CTRL		0x300000
+#define HPRE_CLSTR_ADDR_INTRVL		0x1000
+#define HPRE_CLUSTER_INQURY		0x100
+#define HPRE_CLSTR_ADDR_INQRY_RSLT	0x104
+#define HPRE_TIMEOUT_ABNML_BIT		6
+#define HPRE_PASID_EN_BIT		9
+#define HPRE_REG_RD_INTVRL_US		10
+#define HPRE_REG_RD_TMOUT_US		1000
+#define HPRE_DBGFS_VAL_MAX_LEN		20
+#define HPRE_PCI_DEVICE_ID		0xa258
+#define HPRE_ADDR(qm, offset)		(qm->io_base + (offset))
+#define HPRE_QM_USR_CFG_MASK		0xfffffffe
+#define HPRE_QM_AXI_CFG_MASK		0xffff
+#define HPRE_QM_VFG_AX_MASK		0xff
+#define HPRE_BD_USR_MASK		0x3
+#define HPRE_CLUSTER_CORE_MASK		0xf
+
+#define HPRE_VIA_MSI_DSM		1
+
+static LIST_HEAD(hpre_list);
+static DEFINE_MUTEX(hpre_list_lock);
+static const char hpre_name[] = "hisi_hpre";
+static const struct pci_device_id hpre_dev_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HPRE_PCI_DEVICE_ID) },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, hpre_dev_ids);
+
+struct hpre_hw_error {
+	u32 int_msk;
+	const char *msg;
+};
+
+static const struct hpre_hw_error hpre_hw_errors[] = {
+	{ .int_msk = BIT(0), .msg = "hpre_ecc_1bitt_err" },
+	{ .int_msk = BIT(1), .msg = "hpre_ecc_2bit_err" },
+	{ .int_msk = BIT(2), .msg = "hpre_data_wr_err" },
+	{ .int_msk = BIT(3), .msg = "hpre_data_rd_err" },
+	{ .int_msk = BIT(4), .msg = "hpre_bd_rd_err" },
+	{ .int_msk = BIT(5), .msg = "hpre_ooo_2bit_ecc_err" },
+	{ .int_msk = BIT(6), .msg = "hpre_cltr1_htbt_tm_out_err" },
+	{ .int_msk = BIT(7), .msg = "hpre_cltr2_htbt_tm_out_err" },
+	{ .int_msk = BIT(8), .msg = "hpre_cltr3_htbt_tm_out_err" },
+	{ .int_msk = BIT(9), .msg = "hpre_cltr4_htbt_tm_out_err" },
+	{ .int_msk = GENMASK(10, 15), .msg = "hpre_ooo_rdrsp_err" },
+	{ .int_msk = GENMASK(16, 21), .msg = "hpre_ooo_wrrsp_err" },
+	{ /* sentinel */ }
+};
+
+static int hpre_pf_q_num_set(const char *val, const struct kernel_param *kp)
+{
+	struct pci_dev *pdev;
+	u32 n, q_num;
+	u8 rev_id;
+	int ret;
+
+	if (!val)
+		return -EINVAL;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_HUAWEI, HPRE_PCI_DEVICE_ID, NULL);
+	if (!pdev) {
+		q_num = HPRE_QUEUE_NUM_V2;
+		pr_info("No device found currently, suppose queue number is %d\n",
+			q_num);
+	} else {
+		rev_id = pdev->revision;
+		if (rev_id != QM_HW_V2)
+			return -EINVAL;
+
+		q_num = HPRE_QUEUE_NUM_V2;
+	}
+
+	ret = kstrtou32(val, 10, &n);
+	if (ret != 0 || n == 0 || n > q_num)
+		return -EINVAL;
+
+	return param_set_int(val, kp);
+}
+
+static const struct kernel_param_ops hpre_pf_q_num_ops = {
+	.set = hpre_pf_q_num_set,
+	.get = param_get_int,
+};
+
+static u32 hpre_pf_q_num = HPRE_PF_DEF_Q_NUM;
+module_param_cb(hpre_pf_q_num, &hpre_pf_q_num_ops, &hpre_pf_q_num, 0444);
+MODULE_PARM_DESC(hpre_pf_q_num, "Number of queues in PF of CS(1-1024)");
+
+static inline void hpre_add_to_list(struct hpre *hpre)
+{
+	mutex_lock(&hpre_list_lock);
+	list_add_tail(&hpre->list, &hpre_list);
+	mutex_unlock(&hpre_list_lock);
+}
+
+static inline void hpre_remove_from_list(struct hpre *hpre)
+{
+	mutex_lock(&hpre_list_lock);
+	list_del(&hpre->list);
+	mutex_unlock(&hpre_list_lock);
+}
+
+struct hpre *hpre_find_device(int node)
+{
+	struct hpre *hpre, *ret = NULL;
+	int min_distance = INT_MAX;
+	struct device *dev;
+	int dev_node = 0;
+
+	mutex_lock(&hpre_list_lock);
+	list_for_each_entry(hpre, &hpre_list, list) {
+		dev = &hpre->qm.pdev->dev;
+#ifdef CONFIG_NUMA
+		dev_node = dev->numa_node;
+		if (dev_node < 0)
+			dev_node = 0;
+#endif
+		if (node_distance(dev_node, node) < min_distance) {
+			ret = hpre;
+			min_distance = node_distance(dev_node, node);
+		}
+	}
+	mutex_unlock(&hpre_list_lock);
+
+	return ret;
+}
+
+static int hpre_cfg_by_dsm(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+	union acpi_object *obj;
+	guid_t guid;
+
+	if (guid_parse("b06b81ab-0134-4a45-9b0c-483447b95fa7", &guid)) {
+		dev_err(dev, "Hpre GUID failed\n");
+		return -EINVAL;
+	}
+
+	/* Switch over to MSI handling due to non-standard PCI implementation */
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &guid,
+				0, HPRE_VIA_MSI_DSM, NULL);
+	if (!obj) {
+		dev_err(dev, "ACPI handle failed!\n");
+		return -EIO;
+	}
+
+	ACPI_FREE(obj);
+
+	return 0;
+}
+
+static int hpre_set_user_domain_and_cache(struct hpre *hpre)
+{
+	struct hisi_qm *qm = &hpre->qm;
+	struct device *dev = &qm->pdev->dev;
+	unsigned long offset;
+	int ret, i;
+	u32 val;
+
+	writel(HPRE_QM_USR_CFG_MASK, HPRE_ADDR(qm, QM_ARUSER_M_CFG_ENABLE));
+	writel(HPRE_QM_USR_CFG_MASK, HPRE_ADDR(qm, QM_AWUSER_M_CFG_ENABLE));
+	writel_relaxed(HPRE_QM_AXI_CFG_MASK, HPRE_ADDR(qm, QM_AXI_M_CFG));
+
+	/* disable FLR triggered by BME(bus master enable) */
+	writel(PEH_AXUSER_CFG, HPRE_ADDR(qm, QM_PEH_AXUSER_CFG));
+	writel(PEH_AXUSER_CFG_ENABLE, HPRE_ADDR(qm, QM_PEH_AXUSER_CFG_ENABLE));
+
+	/* HPRE need more time, we close this interrupt */
+	val = readl_relaxed(HPRE_ADDR(qm, HPRE_QM_ABNML_INT_MASK));
+	val |= BIT(HPRE_TIMEOUT_ABNML_BIT);
+	writel_relaxed(val, HPRE_ADDR(qm, HPRE_QM_ABNML_INT_MASK));
+
+	writel(0x1, HPRE_ADDR(qm, HPRE_TYPES_ENB));
+	writel(HPRE_QM_VFG_AX_MASK, HPRE_ADDR(qm, HPRE_VFG_AXCACHE));
+	writel(0x0, HPRE_ADDR(qm, HPRE_BD_ENDIAN));
+	writel(0x0, HPRE_ADDR(qm, HPRE_INT_MASK));
+	writel(0x0, HPRE_ADDR(qm, HPRE_RAS_ECC_1BIT_TH));
+	writel(0x0, HPRE_ADDR(qm, HPRE_POISON_BYPASS));
+	writel(0x0, HPRE_ADDR(qm, HPRE_COMM_CNT_CLR_CE));
+	writel(0x0, HPRE_ADDR(qm, HPRE_ECC_BYPASS));
+
+	writel(HPRE_BD_USR_MASK, HPRE_ADDR(qm, HPRE_BD_ARUSR_CFG));
+	writel(HPRE_BD_USR_MASK, HPRE_ADDR(qm, HPRE_BD_AWUSR_CFG));
+	writel(0x1, HPRE_ADDR(qm, HPRE_RDCHN_INI_CFG));
+	ret = readl_relaxed_poll_timeout(HPRE_ADDR(qm, HPRE_RDCHN_INI_ST), val,
+			val & BIT(0),
+			HPRE_REG_RD_INTVRL_US,
+			HPRE_REG_RD_TMOUT_US);
+	if (ret) {
+		dev_err(dev, "read rd channel timeout fail!\n");
+		return -ETIMEDOUT;
+	}
+
+	for (i = 0; i < HPRE_CLUSTERS_NUM; i++) {
+		offset = i * HPRE_CLSTR_ADDR_INTRVL;
+
+		/* clusters initiating */
+		writel(HPRE_CLUSTER_CORE_MASK,
+		       HPRE_ADDR(qm, offset + HPRE_CORE_ENB));
+		writel(0x1, HPRE_ADDR(qm, offset + HPRE_CORE_INI_CFG));
+		ret = readl_relaxed_poll_timeout(HPRE_ADDR(qm, offset +
+					HPRE_CORE_INI_STATUS), val,
+					((val & HPRE_CLUSTER_CORE_MASK) ==
+					HPRE_CLUSTER_CORE_MASK),
+					HPRE_REG_RD_INTVRL_US,
+					HPRE_REG_RD_TMOUT_US);
+		if (ret) {
+			dev_err(dev,
+				"cluster %d int st status timeout!\n", i);
+			return -ETIMEDOUT;
+		}
+	}
+
+	ret = hpre_cfg_by_dsm(qm);
+	if (ret)
+		dev_err(dev, "acpi_evaluate_dsm err.\n");
+
+	return ret;
+}
+
+static void hpre_hw_error_disable(struct hpre *hpre)
+{
+	struct hisi_qm *qm = &hpre->qm;
+
+	/* disable hpre hw error interrupts */
+	writel(HPRE_CORE_INT_DISABLE, qm->io_base + HPRE_INT_MASK);
+}
+
+static void hpre_hw_error_enable(struct hpre *hpre)
+{
+	struct hisi_qm *qm = &hpre->qm;
+
+	/* enable hpre hw error interrupts */
+	writel(HPRE_CORE_INT_ENABLE, qm->io_base + HPRE_INT_MASK);
+	writel(HPRE_HAC_RAS_CE_ENABLE, qm->io_base + HPRE_RAS_CE_ENB);
+	writel(HPRE_HAC_RAS_NFE_ENABLE, qm->io_base + HPRE_RAS_NFE_ENB);
+	writel(HPRE_HAC_RAS_FE_ENABLE, qm->io_base + HPRE_RAS_FE_ENB);
+}
+
+static int hpre_qm_pre_init(struct hisi_qm *qm, struct pci_dev *pdev)
+{
+	enum qm_hw_ver rev_id;
+
+	rev_id = hisi_qm_get_hw_version(pdev);
+	if (rev_id < 0)
+		return -ENODEV;
+
+	if (rev_id == QM_HW_V1) {
+		pci_warn(pdev, "HPRE version 1 is not supported!\n");
+		return -EINVAL;
+	}
+
+	qm->pdev = pdev;
+	qm->ver = rev_id;
+	qm->sqe_size = HPRE_SQE_SIZE;
+	qm->dev_name = hpre_name;
+	qm->qp_base = HPRE_PF_DEF_Q_BASE;
+	qm->qp_num = hpre_pf_q_num;
+	qm->use_dma_api = true;
+
+	return 0;
+}
+
+static void hpre_hw_err_init(struct hpre *hpre)
+{
+	hisi_qm_hw_error_init(&hpre->qm, QM_BASE_CE, QM_BASE_NFE,
+			      0, QM_DB_RANDOM_INVALID);
+	hpre_hw_error_enable(hpre);
+}
+
+static int hpre_pf_probe_init(struct hpre *hpre)
+{
+	struct hisi_qm *qm = &hpre->qm;
+	int ret;
+
+	qm->ctrl_qp_num = HPRE_QUEUE_NUM_V2;
+
+	ret = hpre_set_user_domain_and_cache(hpre);
+	if (ret)
+		return ret;
+
+	hpre_hw_err_init(hpre);
+
+	return 0;
+}
+
+static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct hisi_qm *qm;
+	struct hpre *hpre;
+	int ret;
+
+	hpre = devm_kzalloc(&pdev->dev, sizeof(*hpre), GFP_KERNEL);
+	if (!hpre)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, hpre);
+
+	qm = &hpre->qm;
+	ret = hpre_qm_pre_init(qm, pdev);
+	if (ret)
+		return ret;
+
+	ret = hisi_qm_init(qm);
+	if (ret)
+		return ret;
+
+	ret = hpre_pf_probe_init(hpre);
+	if (ret)
+		goto err_with_qm_init;
+
+	ret = hisi_qm_start(qm);
+	if (ret)
+		goto err_with_err_init;
+
+	hpre_add_to_list(hpre);
+
+	ret = hpre_algs_register();
+	if (ret < 0) {
+		hpre_remove_from_list(hpre);
+		pci_err(pdev, "fail to register algs to crypto!\n");
+		goto err_with_qm_start;
+	}
+	return 0;
+
+err_with_qm_start:
+	hisi_qm_stop(qm);
+
+err_with_err_init:
+	hpre_hw_error_disable(hpre);
+
+err_with_qm_init:
+	hisi_qm_uninit(qm);
+
+	return ret;
+}
+
+static void hpre_remove(struct pci_dev *pdev)
+{
+	struct hpre *hpre = pci_get_drvdata(pdev);
+	struct hisi_qm *qm = &hpre->qm;
+
+	hpre_algs_unregister();
+	hpre_remove_from_list(hpre);
+	hisi_qm_stop(qm);
+	hpre_hw_error_disable(hpre);
+	hisi_qm_uninit(qm);
+}
+
+static void hpre_log_hw_error(struct hpre *hpre, u32 err_sts)
+{
+	const struct hpre_hw_error *err = hpre_hw_errors;
+	struct device *dev = &hpre->qm.pdev->dev;
+
+	while (err->msg) {
+		if (err->int_msk & err_sts)
+			dev_warn(dev, "%s [error status=0x%x] found\n",
+				 err->msg, err->int_msk);
+		err++;
+	}
+}
+
+static pci_ers_result_t hpre_hw_error_handle(struct hpre *hpre)
+{
+	u32 err_sts;
+
+	/* read err sts */
+	err_sts = readl(hpre->qm.io_base + HPRE_HAC_INT_STATUS);
+	if (err_sts) {
+		hpre_log_hw_error(hpre, err_sts);
+
+		/* clear error interrupts */
+		writel(err_sts, hpre->qm.io_base + HPRE_HAC_SOURCE_INT);
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static pci_ers_result_t hpre_process_hw_error(struct pci_dev *pdev)
+{
+	struct hpre *hpre = pci_get_drvdata(pdev);
+	pci_ers_result_t qm_ret, hpre_ret;
+
+	/* log qm error */
+	qm_ret = hisi_qm_hw_error_handle(&hpre->qm);
+
+	/* log hpre error */
+	hpre_ret = hpre_hw_error_handle(hpre);
+
+	return (qm_ret == PCI_ERS_RESULT_NEED_RESET ||
+		hpre_ret == PCI_ERS_RESULT_NEED_RESET) ?
+		PCI_ERS_RESULT_NEED_RESET : PCI_ERS_RESULT_RECOVERED;
+}
+
+static pci_ers_result_t hpre_error_detected(struct pci_dev *pdev,
+					    pci_channel_state_t state)
+{
+	pci_info(pdev, "PCI error detected, state(=%d)!!\n", state);
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	return hpre_process_hw_error(pdev);
+}
+
+static const struct pci_error_handlers hpre_err_handler = {
+	.error_detected		= hpre_error_detected,
+};
+
+static struct pci_driver hpre_pci_driver = {
+	.name			= hpre_name,
+	.id_table		= hpre_dev_ids,
+	.probe			= hpre_probe,
+	.remove			= hpre_remove,
+	.err_handler		= &hpre_err_handler,
+};
+
+static int __init hpre_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&hpre_pci_driver);
+	if (ret)
+		pr_err("hpre: can't register hisi hpre driver.\n");
+
+	return ret;
+}
+
+static void __exit hpre_exit(void)
+{
+	pci_unregister_driver(&hpre_pci_driver);
+}
+
+module_init(hpre_init);
+module_exit(hpre_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Zaibo Xu <xuzaibo@huawei.com>");
+MODULE_DESCRIPTION("Driver for HiSilicon HPRE accelerator");
-- 
2.8.1

