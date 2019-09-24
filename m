Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71382BC275
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 09:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408089AbfIXHVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 03:21:51 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3069 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390221AbfIXHVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:21:50 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35d89c3f97da-f32e5; Tue, 24 Sep 2019 15:21:29 +0800 (CST)
X-RM-TRANSID: 2ee35d89c3f97da-f32e5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95d89c3f9278-8dc6c;
        Tue, 24 Sep 2019 15:21:29 +0800 (CST)
X-RM-TRANSID: 2ee95d89c3f9278-8dc6c
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_mmio: remove redundant dev_err message
Date:   Tue, 24 Sep 2019 15:21:06 +0800
Message-Id: <1569309666-1437-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/virtio/virtio_mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index e09edb5..c4b9f25 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -466,10 +466,8 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	int irq = platform_get_irq(vm_dev->pdev, 0);
 	int i, err, queue_idx = 0;
 
-	if (irq < 0) {
-		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vm_dev);
-- 
1.9.1



