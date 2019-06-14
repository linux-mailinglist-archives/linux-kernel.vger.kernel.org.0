Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1F44632D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 17:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfFNPou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 11:44:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfFNPot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:44:49 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D24A61DFBA62986F1C44;
        Fri, 14 Jun 2019 23:44:46 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 23:44:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <s-anna@ti.com>, <santosh.shilimkar@oracle.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] firmware: ti_sci: remove set but not used variable 'dev'
Date:   Fri, 14 Jun 2019 23:44:21 +0800
Message-ID: <20190614154421.17556-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/firmware/ti_sci.c: In function ti_sci_cmd_ring_config:
drivers/firmware/ti_sci.c:2035:17: warning: variable dev set but not used [-Wunused-but-set-variable]
drivers/firmware/ti_sci.c: In function ti_sci_cmd_ring_get_config:
drivers/firmware/ti_sci.c:2104:17: warning: variable dev set but not used [-Wunused-but-set-variable]
drivers/firmware/ti_sci.c: In function ti_sci_cmd_rm_udmap_tx_ch_cfg:
drivers/firmware/ti_sci.c:2287:17: warning: variable dev set but not used [-Wunused-but-set-variable]
drivers/firmware/ti_sci.c: In function ti_sci_cmd_rm_udmap_rx_ch_cfg:
drivers/firmware/ti_sci.c:2357:17: warning: variable dev set but not used [-Wunused-but-set-variable]

It is never used since commit 1e407f337f40 ("firmware:
ti_sci: Add support for processor control")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/firmware/ti_sci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 86b2727..8c1a961 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2032,14 +2032,12 @@ static int ti_sci_cmd_ring_config(const struct ti_sci_handle *handle,
 	struct ti_sci_msg_hdr *resp;
 	struct ti_sci_xfer *xfer;
 	struct ti_sci_info *info;
-	struct device *dev;
 	int ret = 0;
 
 	if (IS_ERR_OR_NULL(handle))
 		return -EINVAL;
 
 	info = handle_to_ti_sci_info(handle);
-	dev = info->dev;
 
 	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_RM_RING_CFG,
 				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
@@ -2101,14 +2099,12 @@ static int ti_sci_cmd_ring_get_config(const struct ti_sci_handle *handle,
 	struct ti_sci_msg_rm_ring_get_cfg_req *req;
 	struct ti_sci_xfer *xfer;
 	struct ti_sci_info *info;
-	struct device *dev;
 	int ret = 0;
 
 	if (IS_ERR_OR_NULL(handle))
 		return -EINVAL;
 
 	info = handle_to_ti_sci_info(handle);
-	dev = info->dev;
 
 	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_RM_RING_GET_CFG,
 				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
@@ -2284,14 +2280,12 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
 	struct ti_sci_msg_hdr *resp;
 	struct ti_sci_xfer *xfer;
 	struct ti_sci_info *info;
-	struct device *dev;
 	int ret = 0;
 
 	if (IS_ERR_OR_NULL(handle))
 		return -EINVAL;
 
 	info = handle_to_ti_sci_info(handle);
-	dev = info->dev;
 
 	xfer = ti_sci_get_one_xfer(info, TISCI_MSG_RM_UDMAP_TX_CH_CFG,
 				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
@@ -2354,14 +2348,12 @@ static int ti_sci_cmd_rm_udmap_rx_ch_cfg(const struct ti_sci_handle *handle,
 	struct ti_sci_msg_hdr *resp;
 	struct ti_sci_xfer *xfer;
 	struct ti_sci_info *info;
-	struct device *dev;
 	int ret = 0;
 
 	if (IS_ERR_OR_NULL(handle))
 		return -EINVAL;
 
 	info = handle_to_ti_sci_info(handle);
-	dev = info->dev;
 
 	xfer = ti_sci_get_one_xfer(info, TISCI_MSG_RM_UDMAP_RX_CH_CFG,
 				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
-- 
2.7.4


