Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936AE91CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 08:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfHSGNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 02:13:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfHSGNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:13:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B9C35382D04232DAEC32;
        Mon, 19 Aug 2019 14:13:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 19 Aug 2019 14:13:34 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <etnaviv@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/etnaviv: fix missing unlock on error in etnaviv_iommuv1_context_alloc()
Date:   Mon, 19 Aug 2019 06:17:33 +0000
Message-ID: <20190819061733.50023-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing unlock before return from function etnaviv_iommuv1_context_alloc()
in the error handling case.

Fixes: 27b67278e007 ("drm/etnaviv: rework MMU handling")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_iommu.c b/drivers/gpu/drm/etnaviv/etnaviv_iommu.c
index aac8dbf3ea56..1a7c89a67bea 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_iommu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_iommu.c
@@ -140,8 +140,10 @@ etnaviv_iommuv1_context_alloc(struct etnaviv_iommu_global *global)
 	}
 
 	v1_context = kzalloc(sizeof(*v1_context), GFP_KERNEL);
-	if (!v1_context)
+	if (!v1_context) {
+		mutex_unlock(&global->lock);
 		return NULL;
+	}
 
 	v1_context->pgtable_cpu = dma_alloc_wc(global->dev, PT_SIZE,
 					       &v1_context->pgtable_dma,



