Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEDE11FD07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 03:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLPCzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 21:55:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726504AbfLPCzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 21:55:46 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4CC3034BE39B0A6EA2C4;
        Mon, 16 Dec 2019 10:55:44 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Dec 2019
 10:55:37 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <richard.gong@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] firmware: stratix10-svc: Remove unneeded semicolon
Date:   Mon, 16 Dec 2019 11:02:58 +0800
Message-ID: <1576465378-11109-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/firmware/stratix10-svc.c:271:2-3: Unneeded semicolon
drivers/firmware/stratix10-svc.c:515:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/firmware/stratix10-svc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index c6c3140..7ffb42b 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -268,7 +268,7 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
 		 */
 		msleep(1000);
 		count_in_sec--;
-	};
+	}

 	if (res.a0 == INTEL_SIP_SMC_STATUS_OK && count_in_sec)
 		cb_data->status = BIT(SVC_STATUS_RECONFIG_COMPLETED);
@@ -512,7 +512,7 @@ static int svc_normal_to_secure_thread(void *data)
 			break;

 		}
-	};
+	}

 	kfree(cbdata);
 	kfree(pdata);
--
2.7.4

