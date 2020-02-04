Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F291519C4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 12:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBDLUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 06:20:09 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19289 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgBDLUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:20:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e39534d0000>; Tue, 04 Feb 2020 03:19:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 03:20:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Feb 2020 03:20:04 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 11:20:04 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 4 Feb 2020 11:20:03 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3953600002>; Tue, 04 Feb 2020 03:20:03 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V4 19/19] ARM: tegra: Remove USB 2-0 port from Jetson TK1 padctl
Date:   Tue, 4 Feb 2020 16:47:05 +0530
Message-ID: <1580815025-10915-20-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
References: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580815181; bh=UZPndxJaS6exdoWA+8qZB2sYlM6GTteSHhoz8vK44JU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=pv3brgodZD9Z9So0D+oNlB0/adP3C6bCPz7RZfGAkog3ecSZsqBgmfXnQDu1JdWfh
         nLZRyKDXJ1/Q+Oa2MFYQCGXn19xDfGMzBU+lJrk88qClHWeI1fuaGc1az5A8cRZo/H
         8Eo9ON7YwdDQ6XvXpChVIh0E2WKWAKntXVhps2Oj3NqOOU15Qi3E1h6LQSvkuYrU+i
         UcyHRsSPImRg3QuZ8LAsbX8Z/BnGH3D/3ZOBx0W9es+NqA5nBgSZ6rYA5UpZIvSpOE
         UW9+ggGkfeTUBsP7pgOfG8XFKhU20eMA6RkQrEo3j1d9DM4A3vPqkt0k4v/HMcGvY6
         aac5MLR8KCXRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jetson TK1 USB 2-0 port is controlled by phy-tegra-usb driver
rather than padctl driver. Remove the entry for the same.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V4:
 - New patch in the series.
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index d5fd642..54600ff 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1782,12 +1782,6 @@
 		};
 
 		ports {
-			/* Micro A/B */
-			usb2-0 {
-				status = "okay";
-				mode = "otg";
-			};
-
 			/* Mini PCIe */
 			usb2-1 {
 				status = "okay";
-- 
2.7.4

