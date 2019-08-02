Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A83B57EEAA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404053AbfHBIRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 04:17:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403972AbfHBIQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:16:57 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8F5665C1575646BB46AE;
        Fri,  2 Aug 2019 16:16:55 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 2 Aug 2019 16:16:44 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>
Subject: [PATCH v3 3/7] crypto: hisilicon - add HiSilicon ZIP accelerator support
Date:   Fri, 2 Aug 2019 15:57:52 +0800
Message-ID: <1564732676-35987-4-git-send-email-wangzhou1@hisilicon.com>
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

The HiSilicon ZIP accelerator implements the zlib and gzip algorithm. It
uses Hisilicon QM as the interface to the CPU.

This patch provides PCIe driver to the accelerator and registers it to
crypto acomp interface. It also uses sgl as data input/output interface.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
Signed-off-by: Hao Fang <fanghao11@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 drivers/crypto/hisilicon/Kconfig          |   8 +
 drivers/crypto/hisilicon/Makefile         |   1 +
 drivers/crypto/hisilicon/zip/Makefile     |   2 +
 drivers/crypto/hisilicon/zip/zip.h        |  71 ++++
 drivers/crypto/hisilicon/zip/zip_crypto.c | 651 ++++++++++++++++++++++++++++++
 drivers/crypto/hisilicon/zip/zip_main.c   | 504 +++++++++++++++++++++++
 6 files changed, 1237 insertions(+)
 create mode 100644 drivers/crypto/hisilicon/zip/Makefile
 create mode 100644 drivers/crypto/hisilicon/zip/zip.h
 create mode 100644 drivers/crypto/hisilicon/zip/zip_crypto.c
 create mode 100644 drivers/crypto/hisilicon/zip/zip_main.c

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 457d9bc..1929317 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -27,3 +27,11 @@ config CRYPTO_HISI_SGL
 	  HiSilicon accelerator engines use a common hardware scatterlist
 	  interface for data format. Specific engine driver may use this
 	  module.
+
+config CRYPTO_DEV_HISI_ZIP
+	tristate "Support for HiSilicon ZIP accelerator"
+	select CRYPTO_DEV_HISI_QM
+	select CRYPTO_HISI_SGL
+	select SG_SPLIT
+	help
+	  Support for HiSilicon ZIP Driver
diff --git a/drivers/crypto/hisilicon/Makefile b/drivers/crypto/hisilicon/Makefile
index 96cb913..45a2797 100644
--- a/drivers/crypto/hisilicon/Makefile
+++ b/drivers/crypto/hisilicon/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_CRYPTO_DEV_HISI_SEC) += sec/
 obj-$(CONFIG_CRYPTO_DEV_HISI_QM) += qm.o
 obj-$(CONFIG_CRYPTO_HISI_SGL) += sgl.o
+obj-$(CONFIG_CRYPTO_DEV_HISI_ZIP) += zip/
diff --git a/drivers/crypto/hisilicon/zip/Makefile b/drivers/crypto/hisilicon/zip/Makefile
new file mode 100644
index 0000000..a936f09
--- /dev/null
+++ b/drivers/crypto/hisilicon/zip/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_CRYPTO_DEV_HISI_ZIP) += hisi_zip.o
+hisi_zip-objs = zip_main.o zip_crypto.o
diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
new file mode 100644
index 0000000..ffb00d9
--- /dev/null
+++ b/drivers/crypto/hisilicon/zip/zip.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2019 HiSilicon Limited. */
+#ifndef HISI_ZIP_H
+#define HISI_ZIP_H
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"hisi_zip: " fmt
+
+#include <linux/list.h>
+#include "../qm.h"
+#include "../sgl.h"
+
+/* hisi_zip_sqe dw3 */
+#define HZIP_BD_STATUS_M			GENMASK(7, 0)
+/* hisi_zip_sqe dw9 */
+#define HZIP_REQ_TYPE_M				GENMASK(7, 0)
+#define HZIP_ALG_TYPE_ZLIB			0x02
+#define HZIP_ALG_TYPE_GZIP			0x03
+#define HZIP_BUF_TYPE_M				GENMASK(11, 8)
+#define HZIP_PBUFFER				0x0
+#define HZIP_SGL				0x1
+
+enum hisi_zip_error_type {
+	/* negative compression */
+	HZIP_NC_ERR = 0x0d,
+};
+
+struct hisi_zip_ctrl;
+
+struct hisi_zip {
+	struct hisi_qm qm;
+	struct list_head list;
+	struct hisi_zip_ctrl *ctrl;
+};
+
+struct hisi_zip_sqe {
+	u32 consumed;
+	u32 produced;
+	u32 comp_data_length;
+	u32 dw3;
+	u32 input_data_length;
+	u32 lba_l;
+	u32 lba_h;
+	u32 dw7;
+	u32 dw8;
+	u32 dw9;
+	u32 dw10;
+	u32 priv_info;
+	u32 dw12;
+	u32 tag;
+	u32 dest_avail_out;
+	u32 rsvd0;
+	u32 comp_head_addr_l;
+	u32 comp_head_addr_h;
+	u32 source_addr_l;
+	u32 source_addr_h;
+	u32 dest_addr_l;
+	u32 dest_addr_h;
+	u32 stream_ctx_addr_l;
+	u32 stream_ctx_addr_h;
+	u32 cipher_key1_addr_l;
+	u32 cipher_key1_addr_h;
+	u32 cipher_key2_addr_l;
+	u32 cipher_key2_addr_h;
+	u32 rsvd1[4];
+};
+
+struct hisi_zip *find_zip_device(int node);
+int hisi_zip_register_to_crypto(void);
+void hisi_zip_unregister_from_crypto(void);
+#endif
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
new file mode 100644
index 0000000..3033513
--- /dev/null
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -0,0 +1,651 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 HiSilicon Limited. */
+#include <crypto/internal/acompress.h>
+#include <linux/bitfield.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+#include "zip.h"
+
+#define HZIP_ZLIB_HEAD_SIZE			2
+#define HZIP_GZIP_HEAD_SIZE			10
+
+#define GZIP_HEAD_FHCRC_BIT			BIT(1)
+#define GZIP_HEAD_FEXTRA_BIT			BIT(2)
+#define GZIP_HEAD_FNAME_BIT			BIT(3)
+#define GZIP_HEAD_FCOMMENT_BIT			BIT(4)
+
+#define GZIP_HEAD_FLG_SHIFT			3
+#define GZIP_HEAD_FEXTRA_SHIFT			10
+#define GZIP_HEAD_FEXTRA_XLEN			2
+#define GZIP_HEAD_FHCRC_SIZE			2
+
+#define HZIP_CTX_Q_NUM				2
+#define HZIP_GZIP_HEAD_BUF			256
+#define HZIP_ALG_PRIORITY			300
+
+static const u8 zlib_head[HZIP_ZLIB_HEAD_SIZE] = {0x78, 0x9c};
+static const u8 gzip_head[HZIP_GZIP_HEAD_SIZE] = {0x1f, 0x8b, 0x08, 0x0, 0x0,
+						  0x0, 0x0, 0x0, 0x0, 0x03};
+enum hisi_zip_alg_type {
+	HZIP_ALG_TYPE_COMP = 0,
+	HZIP_ALG_TYPE_DECOMP = 1,
+};
+
+#define COMP_NAME_TO_TYPE(alg_name)					\
+	(!strcmp((alg_name), "zlib-deflate") ? HZIP_ALG_TYPE_ZLIB :	\
+	 !strcmp((alg_name), "gzip") ? HZIP_ALG_TYPE_GZIP : 0)		\
+
+#define TO_HEAD_SIZE(req_type)						\
+	(((req_type) == HZIP_ALG_TYPE_ZLIB) ? sizeof(zlib_head) :	\
+	 ((req_type) == HZIP_ALG_TYPE_GZIP) ? sizeof(gzip_head) : 0)	\
+
+#define TO_HEAD(req_type)						\
+	(((req_type) == HZIP_ALG_TYPE_ZLIB) ? zlib_head :		\
+	 ((req_type) == HZIP_ALG_TYPE_GZIP) ? gzip_head : 0)		\
+
+struct hisi_zip_req {
+	struct acomp_req *req;
+	struct scatterlist *src;
+	struct scatterlist *dst;
+	size_t slen;
+	size_t dlen;
+	struct hisi_acc_hw_sgl *hw_src;
+	struct hisi_acc_hw_sgl *hw_dst;
+	dma_addr_t dma_src;
+	dma_addr_t dma_dst;
+	int req_id;
+};
+
+struct hisi_zip_req_q {
+	struct hisi_zip_req *q;
+	unsigned long *req_bitmap;
+	rwlock_t req_lock;
+	u16 size;
+};
+
+struct hisi_zip_qp_ctx {
+	struct hisi_qp *qp;
+	struct hisi_zip_sqe zip_sqe;
+	struct hisi_zip_req_q req_q;
+	struct hisi_acc_sgl_pool sgl_pool;
+	struct hisi_zip *zip_dev;
+	struct hisi_zip_ctx *ctx;
+};
+
+struct hisi_zip_ctx {
+#define QPC_COMP	0
+#define QPC_DECOMP	1
+	struct hisi_zip_qp_ctx qp_ctx[HZIP_CTX_Q_NUM];
+};
+
+static void hisi_zip_config_buf_type(struct hisi_zip_sqe *sqe, u8 buf_type)
+{
+	u32 val;
+
+	val = (sqe->dw9) & ~HZIP_BUF_TYPE_M;
+	val |= FIELD_PREP(HZIP_BUF_TYPE_M, buf_type);
+	sqe->dw9 = val;
+}
+
+static void hisi_zip_config_tag(struct hisi_zip_sqe *sqe, u32 tag)
+{
+	sqe->tag = tag;
+}
+
+static void hisi_zip_fill_sqe(struct hisi_zip_sqe *sqe, u8 req_type,
+			      dma_addr_t s_addr, dma_addr_t d_addr, u32 slen,
+			      u32 dlen)
+{
+	memset(sqe, 0, sizeof(struct hisi_zip_sqe));
+
+	sqe->input_data_length = slen;
+	sqe->dw9 = FIELD_PREP(HZIP_REQ_TYPE_M, req_type);
+	sqe->dest_avail_out = dlen;
+	sqe->source_addr_l = lower_32_bits(s_addr);
+	sqe->source_addr_h = upper_32_bits(s_addr);
+	sqe->dest_addr_l = lower_32_bits(d_addr);
+	sqe->dest_addr_h = upper_32_bits(d_addr);
+}
+
+static int hisi_zip_create_qp(struct hisi_qm *qm, struct hisi_zip_qp_ctx *ctx,
+			      int alg_type, int req_type)
+{
+	struct hisi_qp *qp;
+	int ret;
+
+	qp = hisi_qm_create_qp(qm, alg_type);
+	if (IS_ERR(qp))
+		return PTR_ERR(qp);
+
+	qp->req_type = req_type;
+	qp->qp_ctx = ctx;
+	ctx->qp = qp;
+
+	ret = hisi_qm_start_qp(qp, 0);
+	if (ret < 0)
+		goto err_release_qp;
+
+	return 0;
+
+err_release_qp:
+	hisi_qm_release_qp(qp);
+	return ret;
+}
+
+static void hisi_zip_release_qp(struct hisi_zip_qp_ctx *ctx)
+{
+	hisi_qm_stop_qp(ctx->qp);
+	hisi_qm_release_qp(ctx->qp);
+}
+
+static int hisi_zip_ctx_init(struct hisi_zip_ctx *hisi_zip_ctx, u8 req_type)
+{
+	struct hisi_zip *hisi_zip;
+	struct hisi_qm *qm;
+	int ret, i, j;
+
+	/* find the proper zip device */
+	hisi_zip = find_zip_device(cpu_to_node(smp_processor_id()));
+	if (!hisi_zip) {
+		pr_err("Failed to find a proper ZIP device!\n");
+		return -ENODEV;
+	}
+	qm = &hisi_zip->qm;
+
+	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
+		/* alg_type = 0 for compress, 1 for decompress in hw sqe */
+		ret = hisi_zip_create_qp(qm, &hisi_zip_ctx->qp_ctx[i], i,
+					 req_type);
+		if (ret)
+			goto err;
+
+		hisi_zip_ctx->qp_ctx[i].zip_dev = hisi_zip;
+	}
+
+	return 0;
+err:
+	for (j = i - 1; j >= 0; j--)
+		hisi_zip_release_qp(&hisi_zip_ctx->qp_ctx[j]);
+
+	return ret;
+}
+
+static void hisi_zip_ctx_exit(struct hisi_zip_ctx *hisi_zip_ctx)
+{
+	int i;
+
+	for (i = 1; i >= 0; i--)
+		hisi_zip_release_qp(&hisi_zip_ctx->qp_ctx[i]);
+}
+
+static u16 get_extra_field_size(const u8 *start)
+{
+	return *((u16 *)start) + GZIP_HEAD_FEXTRA_XLEN;
+}
+
+static u32 get_name_field_size(const u8 *start)
+{
+	return strlen(start) + 1;
+}
+
+static u32 get_comment_field_size(const u8 *start)
+{
+	return strlen(start) + 1;
+}
+
+static u32 __get_gzip_head_size(const u8 *src)
+{
+	u8 head_flg = *(src + GZIP_HEAD_FLG_SHIFT);
+	u32 size = GZIP_HEAD_FEXTRA_SHIFT;
+
+	if (head_flg & GZIP_HEAD_FEXTRA_BIT)
+		size += get_extra_field_size(src + size);
+	if (head_flg & GZIP_HEAD_FNAME_BIT)
+		size += get_name_field_size(src + size);
+	if (head_flg & GZIP_HEAD_FCOMMENT_BIT)
+		size += get_comment_field_size(src + size);
+	if (head_flg & GZIP_HEAD_FHCRC_BIT)
+		size += GZIP_HEAD_FHCRC_SIZE;
+
+	return size;
+}
+
+static int hisi_zip_create_req_q(struct hisi_zip_ctx *ctx)
+{
+	struct hisi_zip_req_q *req_q;
+	int i, ret;
+
+	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
+		req_q = &ctx->qp_ctx[i].req_q;
+		req_q->size = QM_Q_DEPTH;
+
+		req_q->req_bitmap = kcalloc(BITS_TO_LONGS(req_q->size),
+					    sizeof(long), GFP_KERNEL);
+		if (!req_q->req_bitmap) {
+			ret = -ENOMEM;
+			if (i == 1)
+				goto err_free_loop0;
+		}
+		rwlock_init(&req_q->req_lock);
+
+		req_q->q = kcalloc(req_q->size, sizeof(struct hisi_zip_req),
+				   GFP_KERNEL);
+		if (!req_q->q) {
+			ret = -ENOMEM;
+			if (i == 0)
+				goto err_free_bitmap;
+			else
+				goto err_free_loop1;
+		}
+	}
+
+	return 0;
+
+err_free_loop1:
+	kfree(ctx->qp_ctx[QPC_DECOMP].req_q.req_bitmap);
+err_free_loop0:
+	kfree(ctx->qp_ctx[QPC_COMP].req_q.q);
+err_free_bitmap:
+	kfree(ctx->qp_ctx[QPC_COMP].req_q.req_bitmap);
+	return ret;
+}
+
+static void hisi_zip_release_req_q(struct hisi_zip_ctx *ctx)
+{
+	int i;
+
+	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
+		kfree(ctx->qp_ctx[i].req_q.q);
+		kfree(ctx->qp_ctx[i].req_q.req_bitmap);
+	}
+}
+
+static int hisi_zip_create_sgl_pool(struct hisi_zip_ctx *ctx)
+{
+	struct hisi_zip_qp_ctx *tmp;
+	int i, ret;
+
+	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
+		tmp = &ctx->qp_ctx[i];
+		ret = hisi_acc_create_sgl_pool(&tmp->qp->qm->pdev->dev,
+					       &tmp->sgl_pool,
+					       QM_Q_DEPTH << 1);
+		if (ret < 0) {
+			if (i == 1)
+				goto err_free_sgl_pool0;
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+
+err_free_sgl_pool0:
+	hisi_acc_free_sgl_pool(&ctx->qp_ctx[QPC_COMP].qp->qm->pdev->dev,
+			       &ctx->qp_ctx[QPC_COMP].sgl_pool);
+	return -ENOMEM;
+}
+
+static void hisi_zip_release_sgl_pool(struct hisi_zip_ctx *ctx)
+{
+	int i;
+
+	for (i = 0; i < HZIP_CTX_Q_NUM; i++)
+		hisi_acc_free_sgl_pool(&ctx->qp_ctx[i].qp->qm->pdev->dev,
+				       &ctx->qp_ctx[i].sgl_pool);
+}
+
+static void hisi_zip_remove_req(struct hisi_zip_qp_ctx *qp_ctx,
+				struct hisi_zip_req *req)
+{
+	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
+
+	if (qp_ctx->qp->alg_type == HZIP_ALG_TYPE_COMP)
+		kfree(req->dst);
+	else
+		kfree(req->src);
+
+	write_lock(&req_q->req_lock);
+	clear_bit(req->req_id, req_q->req_bitmap);
+	memset(req, 0, sizeof(struct hisi_zip_req));
+	write_unlock(&req_q->req_lock);
+}
+
+static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
+{
+	struct hisi_zip_sqe *sqe = data;
+	struct hisi_zip_qp_ctx *qp_ctx = qp->qp_ctx;
+	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
+	struct hisi_zip_req *req = req_q->q + sqe->tag;
+	struct acomp_req *acomp_req = req->req;
+	struct device *dev = &qp->qm->pdev->dev;
+	u32 status, dlen, head_size;
+	int err = 0;
+
+	status = sqe->dw3 & HZIP_BD_STATUS_M;
+
+	if (status != 0 && status != HZIP_NC_ERR) {
+		dev_err(dev, "%scompress fail in qp%u: %u, output: %u\n",
+			(qp->alg_type == 0) ? "" : "de", qp->qp_id, status,
+			sqe->produced);
+		err = -EIO;
+	}
+	dlen = sqe->produced;
+
+	hisi_acc_sg_buf_unmap(dev, req->src, req->hw_src);
+	hisi_acc_sg_buf_unmap(dev, req->dst, req->hw_dst);
+
+	head_size = (qp->alg_type == 0) ? TO_HEAD_SIZE(qp->req_type) : 0;
+	acomp_req->dlen = dlen + head_size;
+
+	if (acomp_req->base.complete)
+		acomp_request_complete(acomp_req, err);
+
+	hisi_zip_remove_req(qp_ctx, req);
+}
+
+static void hisi_zip_set_acomp_cb(struct hisi_zip_ctx *ctx,
+				  void (*fn)(struct hisi_qp *, void *))
+{
+	int i;
+
+	for (i = 0; i < HZIP_CTX_Q_NUM; i++)
+		ctx->qp_ctx[i].qp->req_cb = fn;
+}
+
+static int hisi_zip_acomp_init(struct crypto_acomp *tfm)
+{
+	const char *alg_name = crypto_tfm_alg_name(&tfm->base);
+	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(&tfm->base);
+	int ret;
+
+	ret = hisi_zip_ctx_init(ctx, COMP_NAME_TO_TYPE(alg_name));
+	if (ret)
+		return ret;
+
+	ret = hisi_zip_create_req_q(ctx);
+	if (ret)
+		goto err_ctx_exit;
+
+	ret = hisi_zip_create_sgl_pool(ctx);
+	if (ret)
+		goto err_release_req_q;
+
+	hisi_zip_set_acomp_cb(ctx, hisi_zip_acomp_cb);
+
+	return 0;
+
+err_release_req_q:
+	hisi_zip_release_req_q(ctx);
+err_ctx_exit:
+	hisi_zip_ctx_exit(ctx);
+	return ret;
+}
+
+static void hisi_zip_acomp_exit(struct crypto_acomp *tfm)
+{
+	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(&tfm->base);
+
+	hisi_zip_set_acomp_cb(ctx, NULL);
+	hisi_zip_release_sgl_pool(ctx);
+	hisi_zip_release_req_q(ctx);
+	hisi_zip_ctx_exit(ctx);
+}
+
+static int add_comp_head(struct scatterlist *dst, u8 req_type)
+{
+	int head_size = TO_HEAD_SIZE(req_type);
+	const u8 *head = TO_HEAD(req_type);
+	int ret;
+
+	ret = sg_copy_from_buffer(dst, sg_nents(dst), head, head_size);
+	if (ret != head_size)
+		return -ENOMEM;
+
+	return head_size;
+}
+
+static size_t get_gzip_head_size(struct scatterlist *sgl)
+{
+	char buf[HZIP_GZIP_HEAD_BUF];
+
+	sg_copy_to_buffer(sgl, sg_nents(sgl), buf, sizeof(buf));
+
+	return __get_gzip_head_size(buf);
+}
+
+static size_t get_comp_head_size(struct scatterlist *src, u8 req_type)
+{
+	switch (req_type) {
+	case HZIP_ALG_TYPE_ZLIB:
+		return TO_HEAD_SIZE(HZIP_ALG_TYPE_ZLIB);
+	case HZIP_ALG_TYPE_GZIP:
+		return get_gzip_head_size(src);
+	default:
+		pr_err("request type does not support!\n");
+		return -EINVAL;
+	}
+}
+
+static int get_sg_skip_bytes(struct scatterlist *sgl, size_t bytes,
+			     size_t remains, struct scatterlist **out)
+{
+#define SPLIT_NUM 2
+	size_t split_sizes[SPLIT_NUM];
+	int out_mapped_nents[SPLIT_NUM];
+
+	split_sizes[0] = bytes;
+	split_sizes[1] = remains;
+
+	return sg_split(sgl, 0, 0, SPLIT_NUM, split_sizes, out,
+			out_mapped_nents, GFP_KERNEL);
+}
+
+static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,
+						struct hisi_zip_qp_ctx *qp_ctx,
+						size_t head_size, bool is_comp)
+{
+	struct hisi_zip_req_q *req_q = &qp_ctx->req_q;
+	struct hisi_zip_req *q = req_q->q;
+	struct hisi_zip_req *req_cache;
+	struct scatterlist *out[2];
+	struct scatterlist *sgl;
+	size_t len;
+	int ret, req_id;
+
+	/*
+	 * remove/add zlib/gzip head, as hardware operations do not include
+	 * comp head. so split req->src to get sgl without heads in acomp, or
+	 * add comp head to req->dst ahead of that hardware output compressed
+	 * data in sgl splited from req->dst without comp head.
+	 */
+	if (is_comp) {
+		sgl = req->dst;
+		len = req->dlen - head_size;
+	} else {
+		sgl = req->src;
+		len = req->slen - head_size;
+	}
+
+	ret = get_sg_skip_bytes(sgl, head_size, len, out);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* sgl for comp head is useless, so free it now */
+	kfree(out[0]);
+
+	write_lock(&req_q->req_lock);
+
+	req_id = find_first_zero_bit(req_q->req_bitmap, req_q->size);
+	if (req_id >= req_q->size) {
+		write_unlock(&req_q->req_lock);
+		dev_dbg(&qp_ctx->qp->qm->pdev->dev, "req cache is full!\n");
+		kfree(out[1]);
+		return ERR_PTR(-EBUSY);
+	}
+	set_bit(req_id, req_q->req_bitmap);
+
+	req_cache = q + req_id;
+	req_cache->req_id = req_id;
+	req_cache->req = req;
+	if (is_comp) {
+		req_cache->src = req->src;
+		req_cache->dst = out[1];
+		req_cache->slen = req->slen;
+		req_cache->dlen = req->dlen - head_size;
+	} else {
+		req_cache->src = out[1];
+		req_cache->dst = req->dst;
+		req_cache->slen = req->slen - head_size;
+		req_cache->dlen = req->dlen;
+	}
+
+	write_unlock(&req_q->req_lock);
+
+	return req_cache;
+}
+
+static int hisi_zip_do_work(struct hisi_zip_req *req,
+			    struct hisi_zip_qp_ctx *qp_ctx)
+{
+	struct hisi_zip_sqe *zip_sqe = &qp_ctx->zip_sqe;
+	struct hisi_qp *qp = qp_ctx->qp;
+	struct device *dev = &qp->qm->pdev->dev;
+	struct hisi_acc_sgl_pool *pool = &qp_ctx->sgl_pool;
+	dma_addr_t input;
+	dma_addr_t output;
+	int ret;
+
+	if (!req->src || !req->slen || !req->dst || !req->dlen)
+		return -EINVAL;
+
+	req->hw_src = hisi_acc_sg_buf_map_to_hw_sgl(dev, req->src, pool,
+						    req->req_id << 1, &input);
+	if (IS_ERR(req->hw_src))
+		return PTR_ERR(req->hw_src);
+	req->dma_src = input;
+
+	req->hw_dst = hisi_acc_sg_buf_map_to_hw_sgl(dev, req->dst, pool,
+						    (req->req_id << 1) + 1,
+						    &output);
+	if (IS_ERR(req->hw_dst)) {
+		ret = PTR_ERR(req->hw_dst);
+		goto err_unmap_input;
+	}
+	req->dma_dst = output;
+
+	hisi_zip_fill_sqe(zip_sqe, qp->req_type, input, output, req->slen,
+			  req->dlen);
+	hisi_zip_config_buf_type(zip_sqe, HZIP_SGL);
+	hisi_zip_config_tag(zip_sqe, req->req_id);
+
+	/* send command to start a task */
+	ret = hisi_qp_send(qp, zip_sqe);
+	if (ret < 0)
+		goto err_unmap_output;
+
+	return -EINPROGRESS;
+
+err_unmap_output:
+	hisi_acc_sg_buf_unmap(dev, req->dst, req->hw_dst);
+err_unmap_input:
+	hisi_acc_sg_buf_unmap(dev, req->src, req->hw_src);
+	return ret;
+}
+
+static int hisi_zip_acompress(struct acomp_req *acomp_req)
+{
+	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(acomp_req->base.tfm);
+	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[QPC_COMP];
+	struct hisi_zip_req *req;
+	size_t head_size;
+	int ret;
+
+	/* let's output compression head now */
+	head_size = add_comp_head(acomp_req->dst, qp_ctx->qp->req_type);
+	if (head_size < 0)
+		return -ENOMEM;
+
+	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, true);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = hisi_zip_do_work(req, qp_ctx);
+	if (ret != -EINPROGRESS)
+		hisi_zip_remove_req(qp_ctx, req);
+
+	return ret;
+}
+
+static int hisi_zip_adecompress(struct acomp_req *acomp_req)
+{
+	struct hisi_zip_ctx *ctx = crypto_tfm_ctx(acomp_req->base.tfm);
+	struct hisi_zip_qp_ctx *qp_ctx = &ctx->qp_ctx[QPC_DECOMP];
+	struct hisi_zip_req *req;
+	size_t head_size;
+	int ret;
+
+	head_size = get_comp_head_size(acomp_req->src, qp_ctx->qp->req_type);
+
+	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, false);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = hisi_zip_do_work(req, qp_ctx);
+	if (ret != -EINPROGRESS)
+		hisi_zip_remove_req(qp_ctx, req);
+
+	return ret;
+}
+
+static struct acomp_alg hisi_zip_acomp_zlib = {
+	.init			= hisi_zip_acomp_init,
+	.exit			= hisi_zip_acomp_exit,
+	.compress		= hisi_zip_acompress,
+	.decompress		= hisi_zip_adecompress,
+	.base			= {
+		.cra_name		= "zlib-deflate",
+		.cra_driver_name	= "hisi-zlib-acomp",
+		.cra_module		= THIS_MODULE,
+		.cra_priority           = HZIP_ALG_PRIORITY,
+		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
+	}
+};
+
+static struct acomp_alg hisi_zip_acomp_gzip = {
+	.init			= hisi_zip_acomp_init,
+	.exit			= hisi_zip_acomp_exit,
+	.compress		= hisi_zip_acompress,
+	.decompress		= hisi_zip_adecompress,
+	.base			= {
+		.cra_name		= "gzip",
+		.cra_driver_name	= "hisi-gzip-acomp",
+		.cra_module		= THIS_MODULE,
+		.cra_priority           = HZIP_ALG_PRIORITY,
+		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
+	}
+};
+
+int hisi_zip_register_to_crypto(void)
+{
+	int ret = 0;
+
+	ret = crypto_register_acomp(&hisi_zip_acomp_zlib);
+	if (ret) {
+		pr_err("Zlib acomp algorithm registration failed\n");
+		return ret;
+	}
+
+	ret = crypto_register_acomp(&hisi_zip_acomp_gzip);
+	if (ret) {
+		pr_err("Gzip acomp algorithm registration failed\n");
+		crypto_unregister_acomp(&hisi_zip_acomp_zlib);
+	}
+
+	return ret;
+}
+
+void hisi_zip_unregister_from_crypto(void)
+{
+	crypto_unregister_acomp(&hisi_zip_acomp_gzip);
+	crypto_unregister_acomp(&hisi_zip_acomp_zlib);
+}
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
new file mode 100644
index 0000000..ee4e20e
--- /dev/null
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -0,0 +1,504 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 HiSilicon Limited. */
+#include <linux/acpi.h>
+#include <linux/aer.h>
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/topology.h>
+#include "zip.h"
+
+#define PCI_DEVICE_ID_ZIP_PF		0xa250
+
+#define HZIP_VF_NUM			63
+#define HZIP_QUEUE_NUM_V1		4096
+#define HZIP_QUEUE_NUM_V2		1024
+
+#define HZIP_CLOCK_GATE_CTRL		0x301004
+#define COMP0_ENABLE			BIT(0)
+#define COMP1_ENABLE			BIT(1)
+#define DECOMP0_ENABLE			BIT(2)
+#define DECOMP1_ENABLE			BIT(3)
+#define DECOMP2_ENABLE			BIT(4)
+#define DECOMP3_ENABLE			BIT(5)
+#define DECOMP4_ENABLE			BIT(6)
+#define DECOMP5_ENABLE			BIT(7)
+#define ALL_COMP_DECOMP_EN		(COMP0_ENABLE | COMP1_ENABLE |	\
+					 DECOMP0_ENABLE | DECOMP1_ENABLE | \
+					 DECOMP2_ENABLE | DECOMP3_ENABLE | \
+					 DECOMP4_ENABLE | DECOMP5_ENABLE)
+#define DECOMP_CHECK_ENABLE		BIT(16)
+
+#define HZIP_PORT_ARCA_CHE_0		0x301040
+#define HZIP_PORT_ARCA_CHE_1		0x301044
+#define HZIP_PORT_AWCA_CHE_0		0x301060
+#define HZIP_PORT_AWCA_CHE_1		0x301064
+#define CACHE_ALL_EN			0xffffffff
+
+#define HZIP_BD_RUSER_32_63		0x301110
+#define HZIP_SGL_RUSER_32_63		0x30111c
+#define HZIP_DATA_RUSER_32_63		0x301128
+#define HZIP_DATA_WUSER_32_63		0x301134
+#define HZIP_BD_WUSER_32_63		0x301140
+
+
+
+#define HZIP_CORE_INT_SOURCE		0x3010A0
+#define HZIP_CORE_INT_MASK		0x3010A4
+#define HZIP_CORE_INT_STATUS		0x3010AC
+#define HZIP_CORE_INT_STATUS_M_ECC	BIT(1)
+#define HZIP_CORE_SRAM_ECC_ERR_INFO	0x301148
+#define SRAM_ECC_ERR_NUM_SHIFT		16
+#define SRAM_ECC_ERR_ADDR_SHIFT		24
+#define HZIP_CORE_INT_DISABLE		0x000007FF
+#define HZIP_SQE_SIZE			128
+#define HZIP_PF_DEF_Q_NUM		64
+#define HZIP_PF_DEF_Q_BASE		0
+
+
+#define HZIP_NUMA_DISTANCE		100
+
+static const char hisi_zip_name[] = "hisi_zip";
+LIST_HEAD(hisi_zip_list);
+DEFINE_MUTEX(hisi_zip_list_lock);
+
+#ifdef CONFIG_NUMA
+static struct hisi_zip *find_zip_device_numa(int node)
+{
+	struct hisi_zip *zip = NULL;
+	struct hisi_zip *hisi_zip;
+	int min_distance = HZIP_NUMA_DISTANCE;
+	struct device *dev;
+
+	list_for_each_entry(hisi_zip, &hisi_zip_list, list) {
+		dev = &hisi_zip->qm.pdev->dev;
+		if (node_distance(dev->numa_node, node) < min_distance) {
+			zip = hisi_zip;
+			min_distance = node_distance(dev->numa_node, node);
+		}
+	}
+
+	return zip;
+}
+#endif
+
+struct hisi_zip *find_zip_device(int node)
+{
+	struct hisi_zip *zip = NULL;
+
+	mutex_lock(&hisi_zip_list_lock);
+#ifdef CONFIG_NUMA
+	zip = find_zip_device_numa(node);
+#else
+	zip = list_first_entry(&hisi_zip_list, struct hisi_zip, list);
+#endif
+	mutex_unlock(&hisi_zip_list_lock);
+
+	return zip;
+}
+
+struct hisi_zip_hw_error {
+	u32 int_msk;
+	const char *msg;
+};
+
+static const struct hisi_zip_hw_error zip_hw_error[] = {
+	{ .int_msk = BIT(0), .msg = "zip_ecc_1bitt_err" },
+	{ .int_msk = BIT(1), .msg = "zip_ecc_2bit_err" },
+	{ .int_msk = BIT(2), .msg = "zip_axi_rresp_err" },
+	{ .int_msk = BIT(3), .msg = "zip_axi_bresp_err" },
+	{ .int_msk = BIT(4), .msg = "zip_src_addr_parse_err" },
+	{ .int_msk = BIT(5), .msg = "zip_dst_addr_parse_err" },
+	{ .int_msk = BIT(6), .msg = "zip_pre_in_addr_err" },
+	{ .int_msk = BIT(7), .msg = "zip_pre_in_data_err" },
+	{ .int_msk = BIT(8), .msg = "zip_com_inf_err" },
+	{ .int_msk = BIT(9), .msg = "zip_enc_inf_err" },
+	{ .int_msk = BIT(10), .msg = "zip_pre_out_err" },
+	{ /* sentinel */ }
+};
+
+/*
+ * One ZIP controller has one PF and multiple VFs, some global configurations
+ * which PF has need this structure.
+ *
+ * Just relevant for PF.
+ */
+struct hisi_zip_ctrl {
+	struct hisi_zip *hisi_zip;
+};
+
+static int pf_q_num_set(const char *val, const struct kernel_param *kp)
+{
+	struct pci_dev *pdev = pci_get_device(PCI_VENDOR_ID_HUAWEI,
+					      PCI_DEVICE_ID_ZIP_PF, NULL);
+	u32 n, q_num;
+	u8 rev_id;
+	int ret;
+
+	if (!val)
+		return -EINVAL;
+
+	if (!pdev) {
+		q_num = min_t(u32, HZIP_QUEUE_NUM_V1, HZIP_QUEUE_NUM_V2);
+		pr_info("No device found currently, suppose queue number is %d\n",
+			q_num);
+	} else {
+		rev_id = pdev->revision;
+		switch (rev_id) {
+		case QM_HW_V1:
+			q_num = HZIP_QUEUE_NUM_V1;
+			break;
+		case QM_HW_V2:
+			q_num = HZIP_QUEUE_NUM_V2;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	ret = kstrtou32(val, 10, &n);
+	if (ret != 0 || n > q_num || n == 0)
+		return -EINVAL;
+
+	return param_set_int(val, kp);
+}
+
+static const struct kernel_param_ops pf_q_num_ops = {
+	.set = pf_q_num_set,
+	.get = param_get_int,
+};
+
+static u32 pf_q_num = HZIP_PF_DEF_Q_NUM;
+module_param_cb(pf_q_num, &pf_q_num_ops, &pf_q_num, 0444);
+MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 1-4096, v2 1-1024)");
+
+static int uacce_mode;
+module_param(uacce_mode, int, 0);
+
+static const struct pci_device_id hisi_zip_dev_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_ZIP_PF) },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, hisi_zip_dev_ids);
+
+static inline void hisi_zip_add_to_list(struct hisi_zip *hisi_zip)
+{
+	mutex_lock(&hisi_zip_list_lock);
+	list_add_tail(&hisi_zip->list, &hisi_zip_list);
+	mutex_unlock(&hisi_zip_list_lock);
+}
+
+static inline void hisi_zip_remove_from_list(struct hisi_zip *hisi_zip)
+{
+	mutex_lock(&hisi_zip_list_lock);
+	list_del(&hisi_zip->list);
+	mutex_unlock(&hisi_zip_list_lock);
+}
+
+static void hisi_zip_set_user_domain_and_cache(struct hisi_zip *hisi_zip)
+{
+	void __iomem *base = hisi_zip->qm.io_base;
+
+	/* qm user domain */
+	writel(AXUSER_BASE, base + QM_ARUSER_M_CFG_1);
+	writel(ARUSER_M_CFG_ENABLE, base + QM_ARUSER_M_CFG_ENABLE);
+	writel(AXUSER_BASE, base + QM_AWUSER_M_CFG_1);
+	writel(AWUSER_M_CFG_ENABLE, base + QM_AWUSER_M_CFG_ENABLE);
+	writel(WUSER_M_CFG_ENABLE, base + QM_WUSER_M_CFG_ENABLE);
+
+	/* qm cache */
+	writel(AXI_M_CFG, base + QM_AXI_M_CFG);
+	writel(AXI_M_CFG_ENABLE, base + QM_AXI_M_CFG_ENABLE);
+	/* disable FLR triggered by BME(bus master enable) */
+	writel(PEH_AXUSER_CFG, base + QM_PEH_AXUSER_CFG);
+	writel(PEH_AXUSER_CFG_ENABLE, base + QM_PEH_AXUSER_CFG_ENABLE);
+
+	/* cache */
+	writel(CACHE_ALL_EN, base + HZIP_PORT_ARCA_CHE_0);
+	writel(CACHE_ALL_EN, base + HZIP_PORT_ARCA_CHE_1);
+	writel(CACHE_ALL_EN, base + HZIP_PORT_AWCA_CHE_0);
+	writel(CACHE_ALL_EN, base + HZIP_PORT_AWCA_CHE_1);
+
+	/* user domain configurations */
+	writel(AXUSER_BASE, base + HZIP_BD_RUSER_32_63);
+	writel(AXUSER_BASE, base + HZIP_SGL_RUSER_32_63);
+	writel(AXUSER_BASE, base + HZIP_BD_WUSER_32_63);
+	writel(AXUSER_BASE, base + HZIP_DATA_RUSER_32_63);
+	writel(AXUSER_BASE, base + HZIP_DATA_WUSER_32_63);
+
+	/* let's open all compression/decompression cores */
+	writel(DECOMP_CHECK_ENABLE | ALL_COMP_DECOMP_EN,
+	       base + HZIP_CLOCK_GATE_CTRL);
+
+	/* enable sqc writeback */
+	writel(SQC_CACHE_ENABLE | CQC_CACHE_ENABLE | SQC_CACHE_WB_ENABLE |
+	       CQC_CACHE_WB_ENABLE | FIELD_PREP(SQC_CACHE_WB_THRD, 1) |
+	       FIELD_PREP(CQC_CACHE_WB_THRD, 1), base + QM_CACHE_CTL);
+}
+
+static void hisi_zip_hw_error_set_state(struct hisi_zip *hisi_zip, bool state)
+{
+	struct hisi_qm *qm = &hisi_zip->qm;
+
+	if (qm->ver == QM_HW_V1) {
+		writel(HZIP_CORE_INT_DISABLE, qm->io_base + HZIP_CORE_INT_MASK);
+		dev_info(&qm->pdev->dev, "ZIP v%d does not support hw error handle\n",
+			 qm->ver);
+		return;
+	}
+
+	if (state) {
+		/* clear ZIP hw error source if having */
+		writel(HZIP_CORE_INT_DISABLE, hisi_zip->qm.io_base +
+					      HZIP_CORE_INT_SOURCE);
+		/* enable ZIP hw error interrupts */
+		writel(0, hisi_zip->qm.io_base + HZIP_CORE_INT_MASK);
+	} else {
+		/* disable ZIP hw error interrupts */
+		writel(HZIP_CORE_INT_DISABLE,
+		       hisi_zip->qm.io_base + HZIP_CORE_INT_MASK);
+	}
+}
+
+static void hisi_zip_hw_error_init(struct hisi_zip *hisi_zip)
+{
+	hisi_qm_hw_error_init(&hisi_zip->qm, QM_BASE_CE,
+			      QM_BASE_NFE | QM_ACC_WB_NOT_READY_TIMEOUT, 0,
+			      QM_DB_RANDOM_INVALID);
+	hisi_zip_hw_error_set_state(hisi_zip, true);
+}
+
+static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
+{
+	struct hisi_qm *qm = &hisi_zip->qm;
+	struct hisi_zip_ctrl *ctrl;
+
+	ctrl = devm_kzalloc(&qm->pdev->dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	hisi_zip->ctrl = ctrl;
+	ctrl->hisi_zip = hisi_zip;
+
+	switch (qm->ver) {
+	case QM_HW_V1:
+		qm->ctrl_qp_num = HZIP_QUEUE_NUM_V1;
+		break;
+
+	case QM_HW_V2:
+		qm->ctrl_qp_num = HZIP_QUEUE_NUM_V2;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	hisi_zip_set_user_domain_and_cache(hisi_zip);
+	hisi_zip_hw_error_init(hisi_zip);
+
+	return 0;
+}
+
+static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct hisi_zip *hisi_zip;
+	enum qm_hw_ver rev_id;
+	struct hisi_qm *qm;
+	int ret;
+
+	rev_id = hisi_qm_get_hw_version(pdev);
+	if (rev_id == QM_HW_UNKNOWN)
+		return -EINVAL;
+
+	hisi_zip = devm_kzalloc(&pdev->dev, sizeof(*hisi_zip), GFP_KERNEL);
+	if (!hisi_zip)
+		return -ENOMEM;
+	pci_set_drvdata(pdev, hisi_zip);
+
+	qm = &hisi_zip->qm;
+	qm->pdev = pdev;
+	qm->ver = rev_id;
+
+	qm->sqe_size = HZIP_SQE_SIZE;
+	qm->dev_name = hisi_zip_name;
+	switch (uacce_mode) {
+	case 0:
+		qm->use_dma_api = true;
+		break;
+	case 1:
+		qm->use_dma_api = false;
+		break;
+	case 2:
+		qm->use_dma_api = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = hisi_qm_init(qm);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to init qm!\n");
+		return ret;
+	}
+
+	ret = hisi_zip_pf_probe_init(hisi_zip);
+	if (ret)
+		goto err_qm_uninit;
+
+	qm->qp_base = HZIP_PF_DEF_Q_BASE;
+	qm->qp_num = pf_q_num;
+
+	ret = hisi_qm_start(qm);
+	if (ret)
+		goto err_qm_uninit;
+
+	hisi_zip_add_to_list(hisi_zip);
+
+	return 0;
+
+err_qm_uninit:
+	hisi_qm_uninit(qm);
+	return ret;
+}
+
+static void hisi_zip_remove(struct pci_dev *pdev)
+{
+	struct hisi_zip *hisi_zip = pci_get_drvdata(pdev);
+	struct hisi_qm *qm = &hisi_zip->qm;
+
+	hisi_qm_stop(qm);
+	hisi_zip_hw_error_set_state(hisi_zip, false);
+	hisi_qm_uninit(qm);
+	hisi_zip_remove_from_list(hisi_zip);
+}
+
+static void hisi_zip_log_hw_error(struct hisi_zip *hisi_zip, u32 err_sts)
+{
+	const struct hisi_zip_hw_error *err = zip_hw_error;
+	struct device *dev = &hisi_zip->qm.pdev->dev;
+	u32 err_val;
+
+	while (err->msg) {
+		if (err->int_msk & err_sts) {
+			dev_warn(dev, "%s [error status=0x%x] found\n",
+				 err->msg, err->int_msk);
+
+			if (HZIP_CORE_INT_STATUS_M_ECC & err->int_msk) {
+				err_val = readl(hisi_zip->qm.io_base +
+						HZIP_CORE_SRAM_ECC_ERR_INFO);
+				dev_warn(dev, "hisi-zip multi ecc sram num=0x%x\n",
+					 ((err_val >> SRAM_ECC_ERR_NUM_SHIFT) &
+					  0xFF));
+				dev_warn(dev, "hisi-zip multi ecc sram addr=0x%x\n",
+					 (err_val >> SRAM_ECC_ERR_ADDR_SHIFT));
+			}
+		}
+		err++;
+	}
+}
+
+static pci_ers_result_t hisi_zip_hw_error_handle(struct hisi_zip *hisi_zip)
+{
+	u32 err_sts;
+
+	/* read err sts */
+	err_sts = readl(hisi_zip->qm.io_base + HZIP_CORE_INT_STATUS);
+
+	if (err_sts) {
+		hisi_zip_log_hw_error(hisi_zip, err_sts);
+		/* clear error interrupts */
+		writel(err_sts, hisi_zip->qm.io_base + HZIP_CORE_INT_SOURCE);
+
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static pci_ers_result_t hisi_zip_process_hw_error(struct pci_dev *pdev)
+{
+	struct hisi_zip *hisi_zip = pci_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	pci_ers_result_t qm_ret, zip_ret;
+
+	if (!hisi_zip) {
+		dev_err(dev,
+			"Can't recover ZIP-error occurred during device init\n");
+		return PCI_ERS_RESULT_NONE;
+	}
+
+	qm_ret = hisi_qm_hw_error_handle(&hisi_zip->qm);
+
+	zip_ret = hisi_zip_hw_error_handle(hisi_zip);
+
+	return (qm_ret == PCI_ERS_RESULT_NEED_RESET ||
+		zip_ret == PCI_ERS_RESULT_NEED_RESET) ?
+	       PCI_ERS_RESULT_NEED_RESET : PCI_ERS_RESULT_RECOVERED;
+}
+
+static pci_ers_result_t hisi_zip_error_detected(struct pci_dev *pdev,
+						pci_channel_state_t state)
+{
+	if (pdev->is_virtfn)
+		return PCI_ERS_RESULT_NONE;
+
+	dev_info(&pdev->dev, "PCI error detected, state(=%d)!!\n", state);
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	return hisi_zip_process_hw_error(pdev);
+}
+
+static const struct pci_error_handlers hisi_zip_err_handler = {
+	.error_detected	= hisi_zip_error_detected,
+};
+
+static struct pci_driver hisi_zip_pci_driver = {
+	.name			= "hisi_zip",
+	.id_table		= hisi_zip_dev_ids,
+	.probe			= hisi_zip_probe,
+	.remove			= hisi_zip_remove,
+	.err_handler		= &hisi_zip_err_handler,
+};
+
+static int __init hisi_zip_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&hisi_zip_pci_driver);
+	if (ret < 0) {
+		pr_err("Failed to register pci driver.\n");
+		return ret;
+	}
+
+	if (uacce_mode == 0 || uacce_mode == 2) {
+		ret = hisi_zip_register_to_crypto();
+		if (ret < 0) {
+			pr_err("Failed to register driver to crypto.\n");
+			goto err_crypto;
+		}
+	}
+
+	return 0;
+
+err_crypto:
+	pci_unregister_driver(&hisi_zip_pci_driver);
+	return ret;
+}
+
+static void __exit hisi_zip_exit(void)
+{
+	if (uacce_mode == 0 || uacce_mode == 2)
+		hisi_zip_unregister_from_crypto();
+	pci_unregister_driver(&hisi_zip_pci_driver);
+}
+
+module_init(hisi_zip_init);
+module_exit(hisi_zip_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
+MODULE_DESCRIPTION("Driver for HiSilicon ZIP accelerator");
-- 
2.8.1

