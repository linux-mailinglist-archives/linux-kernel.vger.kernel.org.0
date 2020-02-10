Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E61515704D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 09:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBJIM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 03:12:28 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18189 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgBJIM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:12:27 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e41105c0000>; Mon, 10 Feb 2020 00:12:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 00:12:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 10 Feb 2020 00:12:26 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 08:12:25 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 10 Feb 2020 08:12:25 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4110660001>; Mon, 10 Feb 2020 00:12:25 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V5 01/21] dt-bindings: phy: tegra-xusb: Add usb-role-switch
Date:   Mon, 10 Feb 2020 13:41:27 +0530
Message-ID: <1581322307-11140-2-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581322332; bh=KI0MwJ32VIem1N3I9WejaXC7P5wx3zetPK2oXU0ys5c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=joXhN+h4QpU0JKbImdgjszv3Fs/nTwEf1r7MGEumtvdxmSTKpV+V7TBv4sc4Vav3l
         1qDRN4uu0+lODU+S5jld1yCTqQ8AAM4tBesRhSbNwqRP8ooQn38KB+9SGuBezriTRC
         sAPVd9+l+YXp28XV2xYJbJz3nqpGfZ7po9vBaQ3TsQQn9TmM3iAeQS7I0IJD2zhmKl
         34l1I8CKH588I7ZZsu6l7eqvZpkzWUBvdY+Kb6f4sgofROowvFre5er9GFDfvEBZK2
         8TKsplEPu2gjgbs2EgxImmvp/9WipM5vR0pYn4oZ2r5TJ4H7TdqoO7aIIh29qVseC4
         63MrCaUbcFXRg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb-role-switch property for Tegra210 and Tegra186 platforms. This
entry is used by XUSB pad controller driver to register for role changes
for OTG/Peripheral capable USB 2 ports.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V5:
 - No changes.
---
V3-V4:
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

