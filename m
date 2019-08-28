Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37129A0165
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 14:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfH1MN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 08:13:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:38366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbfH1MN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:13:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 155AAAC2C;
        Wed, 28 Aug 2019 12:13:58 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, linux-kernel@vger.kernel.org,
        oneukum@suse.com, acho@suse.com, tiwai@suse.com, jlee@suse.com
Subject: [PATCH] Revert "Bluetooth: btusb: driver to enable the usb-wakeup feature"
Date:   Wed, 28 Aug 2019 14:13:49 +0200
Message-Id: <20190828121349.24966-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a0085f2510e8976614ad8f766b209448b385492f.

After this commit systems wake up at random, most commonly when

 - put to sleep while bluetooth audio stream is running
 - connected bluetooth audio device is powered off while system is
 asleep

This is broken since the commit was merged up to 5.3-rc6.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/bluetooth/btusb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5cf0734eb31b..5c67d41ca254 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1170,10 +1170,6 @@ static int btusb_open(struct hci_dev *hdev)
 	}
 
 	data->intf->needs_remote_wakeup = 1;
-	/* device specific wakeup source enabled and required for USB
-	 * remote wakeup while host is suspended
-	 */
-	device_wakeup_enable(&data->udev->dev);
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		goto done;
@@ -1238,7 +1234,6 @@ static int btusb_close(struct hci_dev *hdev)
 		goto failed;
 
 	data->intf->needs_remote_wakeup = 0;
-	device_wakeup_disable(&data->udev->dev);
 	usb_autopm_put_interface(data->intf);
 
 failed:
-- 
2.22.0

