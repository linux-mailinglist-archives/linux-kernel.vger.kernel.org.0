Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E864EDF20
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 12:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfKDLx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 06:53:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:6714 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728999AbfKDLxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:53:20 -0500
X-UUID: 29fc674194574734bf88777823fb37f3-20191104
X-UUID: 29fc674194574734bf88777823fb37f3-20191104
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 31192826; Mon, 04 Nov 2019 19:53:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 4 Nov 2019 19:53:15 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 4 Nov 2019 19:53:11 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>,
        Cui Zhang <cui.zhang@mediatek.com>,
        Guangming Cao <guangming.cao@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [RESEND,PATCH 12/13] iommu/mediatek: Change single domain to multiple domains
Date:   Mon, 4 Nov 2019 19:52:37 +0800
Message-ID: <20191104115238.2394-13-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191104115238.2394-1-chao.hao@mediatek.com>
References: <20191104115238.2394-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on one mtk_iommu_domain, this patch supports multiple
mtk_iommu_domains to realize different iova regions.

Every module has one smi_larb port, so we can create different
mtk_iommu_domains by smi_larb port define. So we will add port_mask
variable to mtk_domain_data, if some modules need special iova regions,
they can write smi_larb port which corresponding to themselves to
post_mask variable and specify the start and end address of iova region.
The form of port_mask can use "MTK_M4U_ID(larb, port)", larb and port can
refer to "mtxxxx-larb-port.h(ex: mt6779-larb-port.h)" file.

The architecture diagram is as below:

				mtk_iommu_pgtable
					|
				mtk_domain_data
					|
		-------------------------------------------------
		|			|			|
	mtk_iommu_domain1	mtk_iommu_domain2	mtk_iommu_domain3

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 48 +++++++++++++++++++++++++++++++++------
 drivers/iommu/mtk_iommu.h | 11 ++++++++-
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index c0cd7da71c2c..c33ea55a1841 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -130,6 +130,8 @@ struct mtk_iommu_pgtable {
 	struct io_pgtable_ops	*iop;
 	struct device		*init_dev;
 	struct list_head	m4u_dom_v2;
+	spinlock_t		domain_lock; /* lock for domain count */
+	u32			domain_count;
 	const struct mtk_domain_data	*dom_region;
 };
 
@@ -172,11 +174,15 @@ static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 static u32 get_domain_id(struct mtk_iommu_data *data, u32 portid)
 {
 	u32 dom_id = 0;
-	int i;
+	const struct mtk_domain_data *mtk_dom_array = data->plat_data->dom_data;
+	int i, j;
 
-	/* only support one mtk_iommu_domain currently(dom_cnt = 1) */
-	for (i = 0; i < data->plat_data->dom_cnt; i++)
-		return i;
+	for (i = 0; i < data->plat_data->dom_cnt; i++) {
+		for (j = 0; j < MTK_MAX_PORT_NUM; j++) {
+			if (portid == mtk_dom_array[i].port_mask[j])
+				return i;
+		}
+	}
 
 	return dom_id;
 }
@@ -416,6 +422,8 @@ static struct mtk_iommu_pgtable *create_pgtable(struct mtk_iommu_data *data)
 	if (!pgtable)
 		return ERR_PTR(-ENOMEM);
 
+	spin_lock_init(&pgtable->domain_lock);
+	pgtable->domain_count = 0;
 	INIT_LIST_HEAD(&pgtable->m4u_dom_v2);
 
 	pgtable->cfg = (struct io_pgtable_cfg) {
@@ -476,6 +484,7 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	struct mtk_iommu_data *data;
 	struct mtk_iommu_domain *dom;
 	struct device *dev;
+	unsigned long flags;
 
 	if (type != IOMMU_DOMAIN_DMA)
 		return NULL;
@@ -503,18 +512,34 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (dom->id >= data->plat_data->dom_cnt)
 		goto  put_dma_cookie;
 
+	spin_lock_irqsave(&pgtable->domain_lock, flags);
+	if (pgtable->domain_count >= data->plat_data->dom_cnt) {
+		spin_unlock_irqrestore(&pgtable->domain_lock, flags);
+		dev_err(dev, "%s, too many domain, count=%u\n",
+			__func__, pgtable->domain_count);
+		goto  put_dma_cookie;
+	}
+	pgtable->domain_count++;
+	spin_unlock_irqrestore(&pgtable->domain_lock, flags);
 	dom->data = data;
 	dom->group = data->m4u_group;
+
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = pgtable->cfg.pgsize_bitmap;
 
 	dom->domain.geometry.aperture_start =
-				pgtable->dom_region->min_iova;
+				pgtable->dom_region[dom->id].min_iova;
 	dom->domain.geometry.aperture_end =
-				pgtable->dom_region->max_iova;
+				pgtable->dom_region[dom->id].max_iova;
 	dom->domain.geometry.force_aperture = true;
 	list_add_tail(&dom->list, &pgtable->m4u_dom_v2);
 
+	dev_info(dev, "%s: dom_id:%u, start:%pa, end:%pa, dom_cnt:%u\n",
+		 __func__, dom->id,
+		 &dom->domain.geometry.aperture_start,
+		 &dom->domain.geometry.aperture_end,
+		 pgtable->domain_count);
+
 	return &dom->domain;
 
 put_dma_cookie:
@@ -527,9 +552,17 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 static void mtk_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
+	unsigned long flags;
 
 	iommu_put_dma_cookie(domain);
 	kfree(to_mtk_domain(domain));
+	spin_lock_irqsave(&pgtable->domain_lock, flags);
+	pgtable->domain_count--;
+	if (pgtable->domain_count > 0) {
+		spin_unlock_irqrestore(&pgtable->domain_lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&pgtable->domain_lock, flags);
 	free_io_pgtable_ops(pgtable->iop);
 	kfree(pgtable);
 }
@@ -703,6 +736,7 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
 {
 	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
 	unsigned int i, total_cnt = data->plat_data->resv_cnt;
+	u32 dom_id = mtk_iommu_get_domain_id(dev);
 	const struct mtk_iommu_resv_iova_region *resv_data;
 	struct iommu_resv_region *region;
 	unsigned long base = 0;
@@ -717,7 +751,7 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
 			base = (unsigned long)resv_data[i].iova_base;
 			size = resv_data[i].iova_size;
 		}
-		if (!size)
+		if (!size || resv_data[i].dom_id != dom_id)
 			continue;
 
 		region = iommu_alloc_resv_region(base, size, prot,
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 10476b23adee..345c0a0c2881 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -37,6 +37,7 @@ enum mtk_iommu_plat {
 };
 
 struct mtk_iommu_resv_iova_region {
+	u32			dom_id;
 	dma_addr_t		iova_base;
 	size_t			iova_size;
 	enum iommu_resv_type	type;
@@ -50,12 +51,20 @@ struct mtk_iommu_resv_iova_region {
  * struct mtk_domain_data:	domain configuration
  * @min_iova:	Start address of iova
  * @max_iova:	End address of iova
- * Note: one user can only belong to one domain
+ * @port_mask:	User can specify mtk_iommu_domain by smi larb and port.
+ *		Different mtk_iommu_domain have different iova space,
+ *		port_mask is made up of larb_id and port_id.
+ *		The format of larb and port can refer to mtxxxx-larb-port.h.
+ *		bit[4:0] = port_id  bit[11:5] = larb_id.
+ * Note: one user can only belong to one domain,
+ * the port mask is in unit of SMI larb.
  */
+#define MTK_MAX_PORT_NUM	5
 
 struct mtk_domain_data {
 	dma_addr_t	min_iova;
 	dma_addr_t	max_iova;
+	u32		port_mask[MTK_MAX_PORT_NUM];
 };
 
 struct mtk_iommu_plat_data {
-- 
2.18.0

