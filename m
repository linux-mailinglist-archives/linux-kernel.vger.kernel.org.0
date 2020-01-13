Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4480138A38
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 05:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbgAMEcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 23:32:21 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:64495 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387607AbgAMEcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:32:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578889939; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=l7XrpfhhxOyRvikqVWgTDSMGNKmcEQJIF/TbImSjqFM=; b=LbplYLXKsW4bhkzO3PoyBLOIQo5opK0qBj0tu5/Y42YZgikJwxOQbPIIvjimfASPAMOOWzyb
 dXLUdGucnx0MsSvQpSMjCeoxiTqchGe6HjJTNfSBYOwXhCPrtR0JezMGUA6w7z8cK7LKnRK0
 WaYJC/LhzAPiWFkYrLsBQFN6jek=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1bf2cd.7f61a5cfe378-smtp-out-n02;
 Mon, 13 Jan 2020 04:32:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E28BAC433A2; Mon, 13 Jan 2020 04:32:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rocky-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D52DAC433CB;
        Mon, 13 Jan 2020 04:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D52DAC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v5] Bluetooth: hci_qca: Add qca_power_on() API to support both wcn399x and Rome power up
Date:   Mon, 13 Jan 2020 12:30:20 +0800
Message-Id: <20200113043020.9663-1-rjliao@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107052601.32216-1-rjliao@codeaurora.org>
References: <20200107052601.32216-1-rjliao@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a unified API qca_power_on() to support both wcn399x and
Rome power on. For wcn399x it calls the qca_wcn3990_init() to init the
regulators, and for Rome it pulls up the bt_en GPIO to power up the btsoc.
It also moves all the power up operation from hdev->open() to
hdev->setup().

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2: None
Changes in v3:
  -moved all the power up operation from open() to setup()
  -updated the commit message
Changes in v4:
  -made a single call to qca_power_on() in setup()
Changes in v5:
  -modified the debug log location

 drivers/bluetooth/hci_qca.c | 54 ++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 82e4cd4b6663..992622dc1263 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -541,7 +541,6 @@ static int qca_open(struct hci_uart *hu)
 {
 	struct qca_serdev *qcadev;
 	struct qca_data *qca;
-	int ret;
 
 	BT_DBG("hu %p qca_open", hu);
 
@@ -582,23 +581,10 @@ static int qca_open(struct hci_uart *hu)
 	hu->priv = qca;
 
 	if (hu->serdev) {
-
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (!qca_is_wcn399x(qcadev->btsoc_type)) {
-			gpiod_set_value_cansleep(qcadev->bt_en, 1);
-			/* Controller needs time to bootup. */
-			msleep(150);
-		} else {
+		if (qca_is_wcn399x(qcadev->btsoc_type)) {
 			hu->init_speed = qcadev->init_speed;
 			hu->oper_speed = qcadev->oper_speed;
-			ret = qca_regulator_enable(qcadev);
-			if (ret) {
-				destroy_workqueue(qca->workqueue);
-				kfree_skb(qca->rx_skb);
-				hu->priv = NULL;
-				kfree(qca);
-				return ret;
-			}
 		}
 	}
 
@@ -1531,6 +1517,31 @@ static int qca_wcn3990_init(struct hci_uart *hu)
 	return 0;
 }
 
+static int qca_power_on(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	enum qca_btsoc_type soc_type = qca_soc_type(hu);
+	struct qca_serdev *qcadev;
+	int ret = 0;
+
+	/* Non-serdev device usually is powered by external power
+	 * and don't need additional action in driver for power on
+	 */
+	if (!hu->serdev)
+		return 0;
+
+	if (qca_is_wcn399x(soc_type)) {
+		ret = qca_wcn3990_init(hu);
+	} else {
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		gpiod_set_value_cansleep(qcadev->bt_en, 1);
+		/* Controller needs time to bootup. */
+		msleep(150);
+	}
+
+	return ret;
+}
+
 static int qca_setup(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -1553,24 +1564,25 @@ static int qca_setup(struct hci_uart *hu)
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
-	if (qca_is_wcn399x(soc_type)) {
-		bt_dev_info(hdev, "setting up wcn3990");
+	bt_dev_info(hdev, "setting up %s",
+		qca_is_wcn399x(soc_type) ? "wcn399x" : "ROME");
 
+	ret = qca_power_on(hdev);
+	if (ret)
+		return ret;
+
+	if (qca_is_wcn399x(soc_type)) {
 		/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to execute
 		 * setup for every hci up.
 		 */
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hu->hdev->shutdown = qca_power_off;
-		ret = qca_wcn3990_init(hu);
-		if (ret)
-			return ret;
 
 		ret = qca_read_soc_version(hdev, &soc_ver, soc_type);
 		if (ret)
 			return ret;
 	} else {
-		bt_dev_info(hdev, "ROME setup");
 		qca_set_speed(hu, QCA_INIT_SPEED);
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
