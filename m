Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB58F4C965
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 10:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfFTIZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 04:25:01 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:31443 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726185AbfFTIZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:25:01 -0400
X-UUID: a611cf909cc344bba66b5de4c2ba3db2-20190620
X-UUID: a611cf909cc344bba66b5de4c2ba3db2-20190620
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 687249219; Thu, 20 Jun 2019 16:24:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 20 Jun 2019 16:24:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 20 Jun 2019 16:24:53 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [v2 PATCH] usb: dwc3: remove unused @lock member of dwc3_ep struct
Date:   Thu, 20 Jun 2019 16:24:48 +0800
Message-ID: <674c9b71735b3fd58e9a8599ab9ea05ad41a1a62.1561018843.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member @lock of dwc3_ep struct is only initialized,
and not used elsewhere, so remove it.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: fix typo of dwc3_ep in commit log
---
 drivers/usb/dwc3/core.h   | 2 --
 drivers/usb/dwc3/gadget.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index f19cbeb01087..72d28cb14bdf 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -649,7 +649,6 @@ struct dwc3_event_buffer {
  * @cancelled_list: list of cancelled requests for this endpoint
  * @pending_list: list of pending requests for this endpoint
  * @started_list: list of started requests on this endpoint
- * @lock: spinlock for endpoint request queue traversal
  * @regs: pointer to first endpoint register
  * @trb_pool: array of transaction buffers
  * @trb_pool_dma: dma address of @trb_pool
@@ -677,7 +676,6 @@ struct dwc3_ep {
 	struct list_head	pending_list;
 	struct list_head	started_list;
 
-	spinlock_t		lock;
 	void __iomem		*regs;
 
 	struct dwc3_trb		*trb_pool;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d67655384eb2..7f75da30caba 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2251,8 +2251,6 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 		dep->endpoint.comp_desc = NULL;
 	}
 
-	spin_lock_init(&dep->lock);
-
 	if (num == 0)
 		ret = dwc3_gadget_init_control_endpoint(dep);
 	else if (direction)
-- 
2.21.0

