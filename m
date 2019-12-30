Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E2612CF16
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 12:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfL3LNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 06:13:43 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19387 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfL3LNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:13:43 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e09dbd80000>; Mon, 30 Dec 2019 03:13:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Dec 2019 03:13:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Dec 2019 03:13:42 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Dec
 2019 11:13:41 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Dec
 2019 11:13:41 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 30 Dec 2019 11:13:41 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e09dbe10001>; Mon, 30 Dec 2019 03:13:40 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nagarjuna Kristam" <nkristam@nvidia.com>
Subject: [Patch V3 01/18] dt-bindings: phy: tegra-xusb: Add usb-role-switch
Date:   Mon, 30 Dec 2019 16:39:38 +0530
Message-ID: <1577704195-2535-2-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577704408; bh=pIhpctDZk5ukwrY3bdm4OpkbLlO+2RCGqj63xVbHkfE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=sEIG6U4GS884i8yYykWHepu+7ny216vRg15QKyl1J3WmdZwFbszVRiXFC270URIe2
         DTh2V9GXYCyQuPJs3BTBAhlcMyAYhYflC5kLbZQUjqiDzkBc/1eeMTrSZr1m97cyKQ
         3YBiByJ/dyD0WluCsMa/g31aj66aWTrj/Wq2GT4t+0AVStie1tX1ueH1l4hp7c/xXs
         Xit63YEc/2GZVVWK0xo/B9Oqs7PxbvF5hOFtATAVkd8FpmF5fc1ULjw4eyxGuWLfrC
         v115TkC60hc/VSc2VIXQQ2lFG+TLASlv55YpApGEayAGFzungog2S8ZuoZMRw1hoyz
         7AsHULPyY+OjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb-role-switch property for Tegra210 and Tegra186 platforms. This
entry is used by XUSB pad controller driver to register for role changes
for OTG/Peripheral capable USB 2 ports.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V3:
 - Added Acked-by updates to commit message.
---
V2:
 - Moved usb-role-switch to seperate Required section as suggested by Thierry.
 - Added reference to usb/usb-conn-gpio.txt for connector subnode.
---
 .../devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
index 9fb682e..23bf354 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
@@ -174,6 +174,12 @@ Required properties:
   - "device": for USB device mode
   - "otg": for USB OTG mode
 
+Required properties for OTG/Peripheral capable USB2 ports:
+- usb-role-switch: Boolean property to indicate that the port support OTG or
+  peripheral mode. If present, the port supports switching between USB host
+  and peripheral roles. Connector should be added as subnode.
+  See usb/usb-conn-gpio.txt.
+
 Optional properties:
 - nvidia,internal: A boolean property whose presence determines that a port
   is internal. In the absence of this property the port is considered to be
-- 
2.7.4

