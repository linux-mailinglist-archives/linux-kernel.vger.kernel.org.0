Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9B097239
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 08:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfHUGXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 02:23:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41344 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbfHUGXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:23:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7D2A060AD1; Wed, 21 Aug 2019 06:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566368627;
        bh=Y9lfHvXmCYaMf6ZT1eovpH76Ni5r3c6awwg4Xedz9NY=;
        h=From:To:Cc:Subject:Date:From;
        b=D19WhqRuDbRxgQlQnVA8aHTN2CeX1srAZvf/r18oSvqZhkn656qFtIVo9pouqIHGy
         vaGgEhkiQ45TaWJ5BF1DZ8h2AHP9+4/pAK7nTzaNS+RWpd26dlyLlG/YeF6XuKLQY1
         mIT7zusGDOMeObQoHpMBx3g7eCFi19gBNv9SGQAo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from rocky-HP-EliteBook-8460p.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EA4E60863;
        Wed, 21 Aug 2019 06:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566368626;
        bh=Y9lfHvXmCYaMf6ZT1eovpH76Ni5r3c6awwg4Xedz9NY=;
        h=From:To:Cc:Subject:Date:From;
        b=ba0I2wxglxE/Wclyi75YDG0yTDxdYHqeIqHjZtwynfX6VPkur2ywyZ1+28EYGQbAa
         fVRMfkSIsofJOCTfqs/kkAvm71lrnYr5Eisr+wyNcugKLURDRLPtSiaKugWAy9iVhe
         xmafcOpVQvIa4OkTdpfuMNxvb8v0v2bmPUAL7yj0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EA4E60863
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for QCA UART Radio
Date:   Wed, 21 Aug 2019 14:23:39 +0800
Message-Id: <1566368619-3941-1-git-send-email-rjliao@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCA UART Bluetooth controllers can do both LE scan and BR/EDR inquiry
at once, need to set HCI_QUIRK_SIMULTANEOUS_DISCOVERY quirk.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ab4c18e..fdf67a0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1242,6 +1242,11 @@ static int qca_setup(struct hci_uart *hu)
 	/* Patch downloading has to be done without IBS mode */
 	clear_bit(QCA_IBS_ENABLED, &qca->flags);
 
+	/* Enable controller to do both LE scan and BR/EDR inquiry
+	 * simultaneously.
+	 */
+	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+
 	if (qca_is_wcn399x(soc_type)) {
 		bt_dev_info(hdev, "setting up wcn3990");
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

