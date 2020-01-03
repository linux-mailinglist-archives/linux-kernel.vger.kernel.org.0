Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0BD12F59B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 09:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgACIk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 03:40:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58182 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgACIkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:40:25 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1inIVJ-0003TV-Re; Fri, 03 Jan 2020 08:40:22 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     acelan.kao@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 3/3] USB: Disable LPM on WD19's Realtek Hub during setting its ports to U0
Date:   Fri,  3 Jan 2020 16:40:08 +0800
Message-Id: <20200103084008.3579-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103084008.3579-1-kai.heng.feng@canonical.com>
References: <20200103084008.3579-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek Hub (0bda:0x0487) used in Dell Dock WD19 sometimes drops off the
bus when bringing underlying ports from U3 to U0.

After some expirements and guessworks, the hub itself needs to be U0
during setting its port's link state back to U0.

So add a new quirk to let the hub disables LPM on setting U0 for its
downstream facing ports.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/hub.c     | 12 ++++++++++--
 drivers/usb/core/quirks.c  |  7 +++++++
 include/linux/usb/quirks.h |  3 +++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index f229ad6952c0..35a035781c5a 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3533,9 +3533,17 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 	}
 
 	/* see 7.1.7.7; affects power usage, but not budgeting */
-	if (hub_is_superspeed(hub->hdev))
+	if (hub_is_superspeed(hub->hdev)) {
+		if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
+			usb_lock_device(hub->hdev);
+			usb_unlocked_disable_lpm(hub->hdev);
+		}
 		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U0);
-	else
+		if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
+			usb_unlocked_enable_lpm(hub->hdev);
+			usb_unlock_device(hub->hdev);
+		}
+	} else
 		status = usb_clear_port_feature(hub->hdev,
 				port1, USB_PORT_FEAT_SUSPEND);
 	if (status) {
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 6b6413073584..69474d0d2b38 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -131,6 +131,9 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 			case 'o':
 				flags |= USB_QUIRK_HUB_SLOW_RESET;
 				break;
+			case 'p':
+				flags |= USB_QUIRK_DISABLE_LPM_ON_U0;
+				break;
 			/* Ignore unrecognized flag characters */
 			}
 		}
@@ -371,6 +374,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0b05, 0x17e0), .driver_info =
 			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
 
+	/* Realtek hub in Dell WD19 (Type-C) */
+	{ USB_DEVICE(0x0bda, 0x0487), .driver_info =
+			USB_QUIRK_DISABLE_LPM_ON_U0 },
+
 	/* Action Semiconductor flash disk */
 	{ USB_DEVICE(0x10d6, 0x2200), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index a1be64c9940f..1881d650f84c 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -69,4 +69,7 @@
 /* Hub needs extra delay after resetting its port. */
 #define USB_QUIRK_HUB_SLOW_RESET		BIT(14)
 
+/* LPM on hub needs to be disabled during setting port link state. */
+#define USB_QUIRK_DISABLE_LPM_ON_U0		BIT(15)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.17.1

