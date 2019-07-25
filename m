Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E478A7490A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 10:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389536AbfGYIYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 04:24:54 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2242 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389405AbfGYIYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:24:54 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75d396735228-27891; Thu, 25 Jul 2019 16:24:21 +0800 (CST)
X-RM-TRANSID: 2ee75d396735228-27891
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85d39673479c-3b1c6;
        Thu, 25 Jul 2019 16:24:21 +0800 (CST)
X-RM-TRANSID: 2ee85d39673479c-3b1c6
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: fix return value check in zynqmp_ipi_mbox_probe
Date:   Thu, 25 Jul 2019 16:24:17 +0800
Message-Id: <1564043057-23381-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_ioremap() failed, it will return NULL pointer not
ERR_PTR(). So, use NULL test instead of IS_ERR() test.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 86887c9..660a8d2 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -504,9 +504,9 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 		mchan->req_buf_size = resource_size(&res);
 		mchan->req_buf = devm_ioremap(mdev, res.start,
 					      mchan->req_buf_size);
-		if (IS_ERR(mchan->req_buf)) {
+		if (!mchan->req_buf) {
 			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
-			ret = PTR_ERR(mchan->req_buf);
+			ret = -ENOMEM;
 			return ret;
 		}
 	} else if (ret != -ENODEV) {
@@ -520,9 +520,9 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 		mchan->resp_buf_size = resource_size(&res);
 		mchan->resp_buf = devm_ioremap(mdev, res.start,
 					       mchan->resp_buf_size);
-		if (IS_ERR(mchan->resp_buf)) {
+		if (!mchan->resp_buf) {
 			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
-			ret = PTR_ERR(mchan->resp_buf);
+			ret = -ENOMEM;
 			return ret;
 		}
 	} else if (ret != -ENODEV) {
@@ -543,9 +543,9 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 		mchan->req_buf_size = resource_size(&res);
 		mchan->req_buf = devm_ioremap(mdev, res.start,
 					      mchan->req_buf_size);
-		if (IS_ERR(mchan->req_buf)) {
+		if (!mchan->req_buf) {
 			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
-			ret = PTR_ERR(mchan->req_buf);
+			ret = -ENOMEM;
 			return ret;
 		}
 	} else if (ret != -ENODEV) {
@@ -559,9 +559,9 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 		mchan->resp_buf_size = resource_size(&res);
 		mchan->resp_buf = devm_ioremap(mdev, res.start,
 					       mchan->resp_buf_size);
-		if (IS_ERR(mchan->resp_buf)) {
+		if (!mchan->resp_buf) {
 			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
-			ret = PTR_ERR(mchan->resp_buf);
+			ret = -ENOMEM;
 			return ret;
 		}
 	} else if (ret != -ENODEV) {
-- 
1.9.1



