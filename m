Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A9B1290C5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 02:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfLWBwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 20:52:33 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:64188 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfLWBwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:52:32 -0500
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 8EF11587128DA7A88804;
        Mon, 23 Dec 2019 09:52:30 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id xBN1q0Wb032782;
        Mon, 23 Dec 2019 09:52:00 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019122309520245-1467735 ;
          Mon, 23 Dec 2019 09:52:02 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     sudeep.dutt@intel.com
Cc:     ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, vincent.whitchurch@axis.com,
        alexios.zavras@intel.com, tglx@linutronix.de, allison@lohutok.net,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn,
        Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH] misc: Use kzalloc() instead of kmalloc() with flag GFP_ZERO.
Date:   Mon, 23 Dec 2019 09:51:58 +0800
Message-Id: <1577065918-25513-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-12-23 09:52:02,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-12-23 09:52:01,
        Serialize complete at 2019-12-23 09:52:01
X-MAIL: mse-fl2.zte.com.cn xBN1q0Wb032782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Zijiang <huang.zijiang@zte.com.cn>

Use kzalloc instead of manually setting kmalloc
with flag GFP_ZERO since kzalloc sets allocated memory
to zero.

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 drivers/misc/mic/host/mic_boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
index 7335759..c1f87a4 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -137,7 +137,7 @@ static void *__mic_dma_alloc(struct device *dev, size_t size,
     struct scif_hw_dev *scdev = dev_get_drvdata(dev);
     struct mic_device *mdev = scdev_to_mdev(scdev);
     dma_addr_t tmp;
-    void *va = kmalloc(size, gfp | __GFP_ZERO);
+void *va = kzalloc(size, gfp);
 
     if (va) {
         tmp = mic_map_single(mdev, va, size);
-- 
1.9.1

