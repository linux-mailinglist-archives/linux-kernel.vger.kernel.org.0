Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293F110A8F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 04:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK0DBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 22:01:40 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:50564 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfK0DBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 22:01:40 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAR31C2b020528, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAR31C2b020528
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Nov 2019 11:01:12 +0800
Received: from localhost.localdomain (172.21.83.238) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 27 Nov 2019 11:01:11 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <matthias.bgg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <alex_lu@realsil.com.cn>,
        <max.chou@realtek.com>
Subject: [PATCH] Bluetooth: btusb: Edit the logical value for Realtek Bluetooth reset
Date:   Wed, 27 Nov 2019 11:01:07 +0800
Message-ID: <20191127030107.17604-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.83.238]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

It should be pull low and pull high on the physical line for the Realtek
Bluetooth reset. gpiod_set_value_cansleep() takes ACTIVE_LOW status for
the logical value settings, so the original commit should be corrected.

Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 70e385987d41..82fb2e7b2892 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -552,9 +552,9 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
 	}
 
 	bt_dev_err(hdev, "Reset Realtek device via gpio");
-	gpiod_set_value_cansleep(reset_gpio, 0);
-	msleep(200);
 	gpiod_set_value_cansleep(reset_gpio, 1);
+	msleep(200);
+	gpiod_set_value_cansleep(reset_gpio, 0);
 }
 
 static inline void btusb_free_frags(struct btusb_data *data)
-- 
2.17.1

