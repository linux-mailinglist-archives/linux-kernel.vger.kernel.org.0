Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE521167E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 09:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLIIAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 03:00:52 -0500
Received: from mail1.windriver.com ([147.11.146.13]:58916 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfLIIAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:00:52 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id xB97GCpH029717
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 8 Dec 2019 23:16:12 -0800 (PST)
Received: from pek-lpggp4.wrs.com (128.224.153.77) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.468.0; Sun, 8 Dec 2019
 23:16:11 -0800
From:   Xiaotao Yin <xiaotao.yin@windriver.com>
To:     <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <Kexin.Hao@windriver.com>,
        <xiaotao.yin@windriver.com>
Subject: [PATCH] iommu/iova: kmemleak when pfn_lo equals IOVA_ANCHOR
Date:   Mon, 9 Dec 2019 15:16:09 +0800
Message-ID: <20191209071609.35690-1-xiaotao.yin@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During ethernet(Marvell octeontx2) set ring buffer test:
ethtool -G eth1 rx <rx ring size> tx <tx ring size>
following kmemleak will happen sometimes:

unreferenced object 0xffff000b85421340 (size 64):
  comm "ethtool", pid 867, jiffies 4295323539 (age 550.500s)
  hex dump (first 64 bytes):
    80 13 42 85 0b 00 ff ff ff ff ff ff ff ff ff ff  ..B.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000001b204ddf>] kmem_cache_alloc+0x1b0/0x350
    [<00000000d9ef2e50>] alloc_iova+0x3c/0x168
    [<00000000ea30f99d>] alloc_iova_fast+0x7c/0x2d8
    [<00000000b8bb2f1f>] iommu_dma_alloc_iova.isra.0+0x12c/0x138
    [<000000002f1a43b5>] __iommu_dma_map+0x8c/0xf8
    [<00000000ecde7899>] iommu_dma_map_page+0x98/0xf8
    [<0000000082004e59>] otx2_alloc_rbuf+0xf4/0x158
    [<000000002b107f6b>] otx2_rq_aura_pool_init+0x110/0x270
    [<00000000c3d563c7>] otx2_open+0x15c/0x734
    [<00000000a2f5f3a8>] otx2_dev_open+0x3c/0x68
    [<00000000456a98b5>] otx2_set_ringparam+0x1ac/0x1d4
    [<00000000f2fbb819>] dev_ethtool+0xb84/0x2028
    [<0000000069b67c5a>] dev_ioctl+0x248/0x3a0
    [<00000000af38663a>] sock_ioctl+0x280/0x638
    [<000000002582384c>] do_vfs_ioctl+0x8b0/0xa80
    [<000000004e1a2c02>] ksys_ioctl+0x84/0xb8

The reason:
When alloc_iova_mem() without initial with Zero, sometimes fpn_lo will equal to
IOVA_ANCHOR by chance, so when return from __alloc_and_insert_iova_range() with
-ENOMEM(iova32_full), the new_iova will not be freed in free_iova_mem().

Fixes: bb68b2fbfbd6 ("iommu/iova: Add rbtree anchor node")
Signed-off-by: Xiaotao Yin <xiaotao.yin@windriver.com>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 41c605b0058f..2c27a661632c 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -233,7 +233,7 @@ static DEFINE_MUTEX(iova_cache_mutex);
 
 struct iova *alloc_iova_mem(void)
 {
-	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
+	return kmem_cache_alloc(iova_cache, GFP_ATOMIC | __GFP_ZERO);
 }
 EXPORT_SYMBOL(alloc_iova_mem);
 
-- 
2.17.1

