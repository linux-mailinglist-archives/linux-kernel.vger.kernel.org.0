Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8132812A646
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 07:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfLYGDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Dec 2019 01:03:30 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:36923 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbfLYGD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 01:03:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577253809; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=0JaZpRNzIAOhHOHQvAOYMrOTx4xK+wS+FRSzKysbEps=; b=ZThhI26lfYzMBOiVLwlRg/fvOJNwQE9+cCGgydYUZ1pqv/RnDo0fbq5fdT/UAly8rR+wJSy0
 5EZRCY08jD8/WGL2hj7oYwcJuGvptLafVuyuQjB9FWkthaJKoR/mvHn/kXWrO61iM7uos6+Q
 0Pz5xCpxIY6pmBrtj1mo2KloCWY=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e02fbae.7fe013371490-smtp-out-n03;
 Wed, 25 Dec 2019 06:03:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 65D9DC433A2; Wed, 25 Dec 2019 06:03:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rocky-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 783BBC43383;
        Wed, 25 Dec 2019 06:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 783BBC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v1 2/4] Bluetooth: hci_qca: Retry btsoc initialize when it fails
Date:   Wed, 25 Dec 2019 14:03:15 +0800
Message-Id: <20191225060317.5258-2-rjliao@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191225060317.5258-1-rjliao@codeaurora.org>
References: <20191225060317.5258-1-rjliao@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the retry of btsoc initialization when it fails. There are
reports that the btsoc initialization may fail on some platforms but the
repro ratio is very low. The failure may be caused by UART, platform HW or
the btsoc itself but it's very difficlut to root cause, given the repro
ratio is very low. Add a retry for the btsoc initialization will resolve
most of the failures and make Bluetooth finally works.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 43fd84028786..45042aa27fa4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -53,6 +53,9 @@
 /* Controller debug log header */
 #define QCA_DEBUG_HANDLE	0x2EDC
 
+/* max retry count when init fails */
+#define QCA_MAX_INIT_RETRY_COUNT 3
+
 enum qca_flags {
 	QCA_IBS_ENABLED,
 	QCA_DROP_VENDOR_EVENT,
@@ -1257,7 +1260,9 @@ static int qca_setup(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
 	struct qca_data *qca = hu->priv;
+	struct qca_serdev *qcadev;
 	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
+	unsigned int init_retry_count = 0;
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 	const char *firmware_name = qca_get_firmware_name(hu);
 	int ret;
@@ -1275,6 +1280,7 @@ static int qca_setup(struct hci_uart *hu)
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
+retry:
 	if (qca_is_wcn399x(soc_type)) {
 		bt_dev_info(hdev, "setting up wcn3990");
 
@@ -1293,6 +1299,12 @@ static int qca_setup(struct hci_uart *hu)
 			return ret;
 	} else {
 		bt_dev_info(hdev, "ROME setup");
+		if (hu->serdev) {
+			qcadev = serdev_device_get_drvdata(hu->serdev);
+			gpiod_set_value_cansleep(qcadev->bt_en, 1);
+			/* Controller needs time to bootup. */
+			msleep(150);
+		}
 		qca_set_speed(hu, QCA_INIT_SPEED);
 	}
 
@@ -1329,6 +1341,20 @@ static int qca_setup(struct hci_uart *hu)
 		 * patch/nvm-config is found, so run with original fw/config.
 		 */
 		ret = 0;
+	} else {
+		if (init_retry_count < QCA_MAX_INIT_RETRY_COUNT) {
+			qca_power_off(hdev);
+			if (hu->serdev) {
+				serdev_device_close(hu->serdev);
+				ret = serdev_device_open(hu->serdev);
+				if (ret) {
+					bt_dev_err(hu->hdev, "open port fail");
+					return ret;
+				}
+			}
+			init_retry_count++;
+			goto retry;
+		}
 	}
 
 	/* Setup bdaddr */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
