Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8090B43E97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389584AbfFMPvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:51:52 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15429 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731654AbfFMJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:11:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d02132b0000>; Thu, 13 Jun 2019 02:11:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 02:11:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Jun 2019 02:11:07 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 09:11:06 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 09:11:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 13 Jun 2019 09:11:06 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0213280000>; Thu, 13 Jun 2019 02:11:06 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 2/2] arm64: tegra: enable ACONNECT, ADMA and AGIC
Date:   Thu, 13 Jun 2019 14:40:53 +0530
Message-ID: <1560417053-2966-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560417053-2966-1-git-send-email-spujar@nvidia.com>
References: <1560417053-2966-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560417067; bh=13+0cSwopl1Sxe+pUYtpwZjyS/pU8FJ+NU50iOgIpYA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=rwvPf8GddSEN5gqmvdfmfsHiOdTQyB+87EXqRms8Zc2od5PgHzXwR9lgXEC//dxwa
         ivXRbFwl8J7urKVauFe/Wf6xIE6gIAj67/UbxRTuCjA7eg0xC/hwzZEsuXCa2O960n
         o0STiXgpScXwPxsc01bS5e02lyqCf04AeppFe7T8LPRTCMrv+eVYEasyGHX1I9MJ08
         yALbOgNRMKkFK3il/HYyViDA3ks2PBGEg6C4FQlOjo7n+E8PZ9kyop6AnOQAiSrZ7P
         DVOEqi3nsuHnQuPJYmP81GbZpXo/bY2trBwx4uoe5Ozn0PF6GW+9vuX2jXpaKbgX8K
         pf8QEq+JtkDYw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ACONNECT, ADMA and AGIC devices for following platforms
  * Jetson TX2
  * Jetson Xavier

Verified driver probe path and devices get registered fine.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
 changes in current revision - None

 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 12 ++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index 5102de1..b818355 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -298,4 +298,16 @@
 			vin-supply = <&vdd_5v0_sys>;
 		};
 	};
+
+	aconnect@2a41000 {
+		status = "okay";
+
+		dma-controller@2930000 {
+			status = "okay";
+		};
+
+		agic@2a41000 {
+			status = "okay";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 6e6df65..d1cc028 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -167,4 +167,16 @@
 			};
 		};
 	};
+
+	aconnect@2a41000 {
+		status = "okay";
+
+		dma-controller@2930000 {
+			status = "okay";
+		};
+
+		agic@2a41000 {
+			status = "okay";
+		};
+	};
 };
-- 
2.7.4

