Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A00113FFE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 12:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfLELTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 06:19:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47966 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729017AbfLELTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:19:32 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9B570BC9944553746866;
        Thu,  5 Dec 2019 19:19:28 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Dec 2019 19:19:19 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <haver@linux.ibm.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <yaohongbo@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: genwqe: fix compile warnings
Date:   Thu, 5 Dec 2019 19:16:55 +0800
Message-ID: <20191205111655.170382-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the following command will get compile warnings:
make W=1 drivers/misc/genwqe/card_ddcb.o ARCH=x86_64

drivers/misc/genwqe/card_ddcb.c: In function setup_ddcb_queue:
drivers/misc/genwqe/card_ddcb.c:1024:6: warning: variable rc set but not
used [-Wunused-but-set-variable]
drivers/misc/genwqe/card_ddcb.c: In function genwqe_card_thread:
drivers/misc/genwqe/card_ddcb.c:1190:23: warning: variable rc set but
not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 drivers/misc/genwqe/card_ddcb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
index 026c6ca24540..905106579935 100644
--- a/drivers/misc/genwqe/card_ddcb.c
+++ b/drivers/misc/genwqe/card_ddcb.c
@@ -1084,7 +1084,7 @@ static int setup_ddcb_queue(struct genwqe_dev *cd, struct ddcb_queue *queue)
 				queue->ddcb_daddr);
 	queue->ddcb_vaddr = NULL;
 	queue->ddcb_daddr = 0ull;
-	return -ENODEV;
+	return rc;
 
 }
 
@@ -1179,7 +1179,7 @@ static irqreturn_t genwqe_vf_isr(int irq, void *dev_id)
  */
 static int genwqe_card_thread(void *data)
 {
-	int should_stop = 0, rc = 0;
+	int should_stop = 0;
 	struct genwqe_dev *cd = (struct genwqe_dev *)data;
 
 	while (!kthread_should_stop()) {
@@ -1187,12 +1187,12 @@ static int genwqe_card_thread(void *data)
 		genwqe_check_ddcb_queue(cd, &cd->queue);
 
 		if (GENWQE_POLLING_ENABLED) {
-			rc = wait_event_interruptible_timeout(
+			wait_event_interruptible_timeout(
 				cd->queue_waitq,
 				genwqe_ddcbs_in_flight(cd) ||
 				(should_stop = kthread_should_stop()), 1);
 		} else {
-			rc = wait_event_interruptible_timeout(
+			wait_event_interruptible_timeout(
 				cd->queue_waitq,
 				genwqe_next_ddcb_ready(cd) ||
 				(should_stop = kthread_should_stop()), HZ);
-- 
2.20.1

