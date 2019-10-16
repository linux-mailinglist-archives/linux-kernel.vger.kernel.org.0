Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1ECD8696
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 05:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403894AbfJPDd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 23:33:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38225 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403861AbfJPDdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:33:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so13788550pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 20:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2PoKh0+SG7fHxZLJh2y0Lp0GiZzbHmOzaEb4WWk+/NM=;
        b=u9L/pE1CJ4s0MCM+ENSOrn5WX8ACrKw+f7H+culvO6PxC99AEUEIDqUc/Od//7F4ux
         NGKoaw5O875g7vF+TdHz5jOtu/6ZqGT/u9eVpntdnCTT247RwTDWquw2hdvSCV+fBi1V
         m7ETBCC7pz06d+d+CYF7H/t97DpuXf3fs4XAntVl56c3A9yJOyJQ7AmCA1cdxAs/PqEq
         i9JwY1zgFvlchdZKDy82Wn/K4HljT0F70ysZwFzhzmhzYxoC2a7ppnxV/j3m3sWF+toz
         AaM2eMUwXZBux98pSL0V4XInnIoMgsw7qVjNKuwWmC2PUBfCABDddSm/pvOPJpHR+aZz
         VQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2PoKh0+SG7fHxZLJh2y0Lp0GiZzbHmOzaEb4WWk+/NM=;
        b=DzhPbpjm4FebPZk1WtJ64iTM9FGe+RdYmQ0lIiz+GUuK4f1zWbBNvzzRqywwucNfgJ
         kHyEZlOhdAlH7Qp7ya/NKloMOq4VdKGrWMt/AU2N02o0GHHSRFp61QzGNr4SwVJeUb6E
         +ogikVqijyjvFGYAQS7DguQK/+P2JN+QXuNXEREfHE8FCRqLZyU0v3Ots6hI+vQ2wI7S
         wpQqCkSlk0gegXWCD2aToFNa2mJa56qc7tx4tSrtb6FAmPO+LNbiNp/XpIw7MgtYHCRS
         HZn+ualN8DDtXK7jzIaZ6yhseELHJTgLY0COHf9sE+hw+kR3ptShzpk34byPIS9ur4cL
         Ok/g==
X-Gm-Message-State: APjAAAUUHucNRvQh24LOecSZIBceV4uG/Y4Vi/Yw5z69+QyQ0GLbpdN+
        K6Mcz5whoG1AKDPLEAMhgHaJc4ygzSg=
X-Google-Smtp-Source: APXvYqwm2S497WA37OpvJu48WtPFC2QRdjOTLBX6kJACVlFLFjKUX/3rNVLnjoD4Lp5ERBCkjIvLaQ==
X-Received: by 2002:aa7:8e47:: with SMTP id d7mr11104425pfr.125.1571196834268;
        Tue, 15 Oct 2019 20:33:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l23sm748356pjy.12.2019.10.15.20.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 20:33:53 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH v3 07/11] usb: dwc3: Registering a role switch in the DRD code.
Date:   Wed, 16 Oct 2019 03:33:36 +0000
Message-Id: <20191016033340.1288-8-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016033340.1288-1-john.stultz@linaro.org>
References: <20191016033340.1288-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

The Type-C drivers use USB role switch API to inform the
system about the negotiated data role, so registering a role
switch in the DRD code in order to support platforms with
USB Type-C connectors.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Fix role_sw and role_switch_default_mode descriptions as
    reported by kbuild test robot <lkp@intel.com>

v3: Split out the role-switch-default-host logic into its own
    patch
---
 drivers/usb/dwc3/Kconfig |  1 +
 drivers/usb/dwc3/core.h  |  3 ++
 drivers/usb/dwc3/drd.c   | 66 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 89abc6078703..1104745c41a9 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -44,6 +44,7 @@ config USB_DWC3_DUAL_ROLE
 	bool "Dual Role mode"
 	depends on ((USB=y || USB=USB_DWC3) && (USB_GADGET=y || USB_GADGET=USB_DWC3))
 	depends on (EXTCON=y || EXTCON=USB_DWC3)
+	select USB_ROLE_SWITCH
 	help
 	  This is the default mode of working of DWC3 controller where
 	  both host and gadget features are enabled.
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1c8b349379af..6f19e9891767 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -25,6 +25,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/role.h>
 #include <linux/ulpi/interface.h>
 
 #include <linux/phy/phy.h>
@@ -951,6 +952,7 @@ struct dwc3_scratchpad_array {
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
+ * @role_sw: usb_role_switch handle
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -1084,6 +1086,7 @@ struct dwc3 {
 	struct extcon_dev	*edev;
 	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
+	struct usb_role_switch	*role_sw;
 
 	u32			fladj;
 	u32			irq_gadget;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index c946d64142ad..61d4fd8aead4 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -476,6 +476,52 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	return edev;
 }
 
+static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+	u32 mode;
+
+	switch (role) {
+	case USB_ROLE_HOST:
+		mode = DWC3_GCTL_PRTCAP_HOST;
+		break;
+	case USB_ROLE_DEVICE:
+		mode = DWC3_GCTL_PRTCAP_DEVICE;
+		break;
+	default:
+		mode = DWC3_GCTL_PRTCAP_DEVICE;
+		break;
+	}
+
+	dwc3_set_mode(dwc, mode);
+	return 0;
+}
+
+static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+	unsigned long flags;
+	enum usb_role role;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_HOST:
+		role = USB_ROLE_HOST;
+		break;
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		role = USB_ROLE_DEVICE;
+		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		role = dwc->current_otg_role;
+		break;
+	default:
+		role = USB_ROLE_DEVICE;
+		break;
+	}
+	spin_unlock_irqrestore(&dwc->lock, flags);
+	return role;
+}
+
 int dwc3_drd_init(struct dwc3 *dwc)
 {
 	int ret, irq;
@@ -484,7 +530,22 @@ int dwc3_drd_init(struct dwc3 *dwc)
 	if (IS_ERR(dwc->edev))
 		return PTR_ERR(dwc->edev);
 
-	if (dwc->edev) {
+	if (device_property_read_bool(dwc->dev, "usb-role-switch")) {
+		struct usb_role_switch_desc dwc3_role_switch = {NULL};
+		u32 mode;
+
+		mode = DWC3_GCTL_PRTCAP_DEVICE;
+
+		dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
+		dwc3_role_switch.set = dwc3_usb_role_switch_set;
+		dwc3_role_switch.get = dwc3_usb_role_switch_get;
+		dwc->role_sw = usb_role_switch_register(dwc->dev,
+							&dwc3_role_switch);
+		if (IS_ERR(dwc->role_sw))
+			return PTR_ERR(dwc->role_sw);
+
+		dwc3_set_mode(dwc, mode);
+	} else if (dwc->edev) {
 		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
 		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
 					       &dwc->edev_nb);
@@ -531,6 +592,9 @@ void dwc3_drd_exit(struct dwc3 *dwc)
 {
 	unsigned long flags;
 
+	if (dwc->role_sw)
+		usb_role_switch_unregister(dwc->role_sw);
+
 	if (dwc->edev)
 		extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST,
 					   &dwc->edev_nb);
-- 
2.17.1

