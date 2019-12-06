Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD73114F50
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 11:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLFKwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 05:52:19 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18853 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfLFKwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:52:17 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dea32cf0000>; Fri, 06 Dec 2019 02:51:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 06 Dec 2019 02:52:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 06 Dec 2019 02:52:16 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 10:52:15 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Dec 2019 10:52:15 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dea32dc0000>; Fri, 06 Dec 2019 02:52:15 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH 14/18] arm64: tegra: update OTG port entries for jetson-tx2
Date:   Fri, 6 Dec 2019 16:20:17 +0530
Message-ID: <1575629421-7039-15-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575629519; bh=YpPrTGx4QC7t8LtKekD034NsHhTHQfNLwF9quApPOIk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=UzhrO8aJ0YWjLPuKFiPq5wDtboJNXMtsUuYhUU6H2qWT475MzHYqIpR4StgeS2Aw+
         OroW6d8qioXNK2jqH+G2fzqYpHrzYoGwnrk8ZbCJS6t9wGNZkenNe+S/QHVoQP/Jku
         4g9U4MOLKTxmpCPAj9+wKb5BqrYdds/+SdqJ2mQMP1Bq2YV54b43YQw0l1tXVBHQ8Q
         BweV1JyJhyBRbgT7i4qMJqRJVAtDmbjPUDP7oYIVNFtGOovx8EFHQgrNbIcxQhrK4x
         ZIRY1rVwePpOKp1Dn2UvBT7E345Zmt15y5E8gt9goT5rvmSFkmrqmqFXs1bnxVGkOl
         XvwrRnunY8KQg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb-role-switch entry to OTG usb port and add corresponding connector
details.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index f1de4ff..a1dcdb9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -174,8 +174,20 @@
 			usb2-0 {
 				status = "okay";
 				mode = "otg";
-
 				vbus-supply = <&vdd_usb0>;
+
+				usb-role-switch;
+				connector {
+					compatible = "usb-b-connector",
+						     "gpio-usb-b-connector";
+					label = "micro-USB";
+					type = "micro";
+					vbus-gpio = <&gpio
+						     TEGRA186_MAIN_GPIO(X, 7)
+						     GPIO_ACTIVE_LOW>;
+					id-gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
+				};
+
 			};
 
 			usb2-1 {
-- 
2.7.4

