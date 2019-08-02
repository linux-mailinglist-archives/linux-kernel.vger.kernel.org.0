Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2227E779
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 03:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfHBB1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 21:27:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727848AbfHBB1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:27:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6B64A1B966E4DF1DCBEF;
        Fri,  2 Aug 2019 09:27:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 2 Aug 2019 09:26:53 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: fsl-dpaa2/ethsw: Remove useless set memory to zero use memset()
Date:   Fri, 2 Aug 2019 01:31:49 +0000
Message-ID: <20190802013149.80952-1-weiyongjun1@huawei.com>
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

The memory return by kzalloc() has already be set to zero, so remove
useless memset(0).

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 4b94a01513a7..aac98ece2335 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -641,8 +641,6 @@ static int port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	if (!dma_mem)
 		return -ENOMEM;
 
-	memset(dma_mem, 0, fdb_dump_size);
-
 	fdb_dump_iova = dma_map_single(dev, dma_mem, fdb_dump_size,
 				       DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, fdb_dump_iova)) {



