Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D43CB15705C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 09:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgBJIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 03:12:47 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3662 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgBJIMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:12:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e41103d0000>; Mon, 10 Feb 2020 00:11:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 00:12:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Feb 2020 00:12:43 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 08:12:40 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 10 Feb 2020 08:12:40 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4110750000>; Mon, 10 Feb 2020 00:12:39 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V5 05/21] phy: tegra: xusb: Add support to get companion USB 3 port
Date:   Mon, 10 Feb 2020 13:41:31 +0530
Message-ID: <1581322307-11140-6-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581322301; bh=eBnuefhuFya1eFMImrrioIcd8pR6hTz5yEIVQS0im1I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=fsmaMYVuDAS00TQhzAPtgbIjE7bIF8cVtuBIGFKDb3R72zPfbhz1pp+Dl68887aDM
         WklamtwgA4vjDAGzR3UnP4viCc3My6BxEPDh7Af0ZTUPPvfls/UJ5Ry6XPViB4gO/x
         LOIX0p/0xjiIhJ3W/RWq4chsBWN5HeeM3mUqPkwWkZs1yofMCuPo4NIblTWA4BXuCo
         6CuOL7m6Ktp99oWbkSTVqrmVHgwDCqvk7YqumToxUektYomta+jMziQ2Gmv9mdL9XX
         G4lSXmXZ35u3WpXIG6PHmFwsEB0zkUy8BXnPBe8F948BBoWW3w4cbyOXijAEC4UIrg
         JKpgWRLgxTVFA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra XUSB host, device mode driver requires the USB 3 companion port
number for corresponding USB 2 port. Add API to retrieve the same.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Reviewed-by: JC Kuo <jckuo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V5:
 - No changes.
---
V4:
 - Addressed comment from Thierry.
 - Added Acked-by info.
---
V3:
 - Added Reviewed-by updates to commit message.
---
V2:
 - Added -ENODEV as return instead of -1, to sync other errors.
---
 drivers/phy/tegra/xusb.c       | 21 +++++++++++++++++++++
 include/linux/phy/tegra/xusb.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 2c0e29c..a8f0a0b 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -1294,6 +1294,27 @@ int tegra_phy_xusb_utmi_port_reset(struct phy *phy)
 }
 EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_port_reset);
 
+int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
+				    unsigned int port)
+{
+	struct tegra_xusb_usb2_port *usb2;
+	struct tegra_xusb_usb3_port *usb3;
+	int i;
+
+	usb2 = tegra_xusb_find_usb2_port(padctl, port);
+	if (!usb2)
+		return -EINVAL;
+
+	for (i = 0; i < padctl->soc->ports.usb3.count; i++) {
+		usb3 = tegra_xusb_find_usb3_port(padctl, i);
+		if (usb3 && usb3->port == usb2->base.index)
+			return usb3->base.index;
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_usb3_companion);
+
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("Tegra XUSB Pad Controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.h
index 1235865..71d9569 100644
--- a/include/linux/phy/tegra/xusb.h
+++ b/include/linux/phy/tegra/xusb.h
@@ -21,4 +21,6 @@ int tegra_xusb_padctl_usb3_set_lfps_detect(struct tegra_xusb_padctl *padctl,
 int tegra_xusb_padctl_set_vbus_override(struct tegra_xusb_padctl *padctl,
 					bool val);
 int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
+int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
+					 unsigned int port);
 #endif /* PHY_TEGRA_XUSB_H */
-- 
2.7.4

