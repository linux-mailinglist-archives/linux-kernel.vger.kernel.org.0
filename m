Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6D913D2B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 04:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgAPD3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 22:29:19 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:41026 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgAPD3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:29:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TnrJrCt_1579145349;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TnrJrCt_1579145349)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jan 2020 11:29:17 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     james.morse@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [V2 3/3] firmware: arm_sdei: clean up sdei_event_create()
Date:   Thu, 16 Jan 2020 11:28:51 +0800
Message-Id: <1579145331-78633-3-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579145331-78633-1-git-send-email-zhangliguang@linux.alibaba.com>
References: <1579145331-78633-1-git-send-email-zhangliguang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function sdei_event_find() is always called in sdei_event_create(), but
it is already called in sdei_event_register(). So we should remove some
needless sdei_event_find() calls.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/firmware/arm_sdei.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index f81c09e..79ae07c 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -271,15 +271,9 @@ static struct sdei_event *sdei_event_create(u32 event_num,
 		event->private_registered = regs;
 	}
 
-	if (sdei_event_find(event_num)) {
-		kfree(event->registered);
-		kfree(event);
-		event = ERR_PTR(-EBUSY);
-	} else {
-		spin_lock(&sdei_list_lock);
-		list_add(&event->list, &sdei_list);
-		spin_unlock(&sdei_list_lock);
-	}
+	spin_lock(&sdei_list_lock);
+	list_add(&event->list, &sdei_list);
+	spin_unlock(&sdei_list_lock);
 
 	return event;
 }
-- 
1.8.3.1

