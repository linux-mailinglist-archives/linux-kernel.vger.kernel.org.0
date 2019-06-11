Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC42B3C6C0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 10:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404794AbfFKI47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 04:56:59 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4405 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403860AbfFKI45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:56:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cff6cd80000>; Tue, 11 Jun 2019 01:56:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 11 Jun 2019 01:56:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 11 Jun 2019 01:56:57 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Jun
 2019 08:56:55 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 11 Jun 2019 08:56:55 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cff6cd50000>; Tue, 11 Jun 2019 01:56:55 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 2/2] arm64: tegra: enable ACONNECT, ADMA and AGIC
Date:   Tue, 11 Jun 2019 14:26:46 +0530
Message-ID: <1560243406-2535-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560243406-2535-1-git-send-email-spujar@nvidia.com>
References: <1560243406-2535-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560243417; bh=i08Sth6W613Uv+n/ePA6o5AaEI7MMdaXzUWGD3NqbKg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=dmJeGLLIhuJIwnU42cwFk3pgnK7PhBpSISOg2oEWwQPYv7X/LYIbormQvW1IJH8Cl
         GDxNXsscZMTafBsJ7XUFbQKTuWgL4YZ7q8q3ElA8LtbYDSzjh/pCHd/Jiy5W/0aMlJ
         zRfqSoKEy0rUcXe0hiG/ZUh68+eTjKiC472NFwkkkcvoolB5sSTp48Md+BWrD1Nh1r
         wOfJyNedEEgmO0rsNT+IBpkm167OhxDCrmPp6xe0M5JPp8xzi8YpKGEvRIXeQNS/hy
         raodp+U0gk/efI/U8jzXDlaz5AoM/vshfatYpDVO+OrKF0vPStCRT+kwFF4Xwd4JEl
         vAVDkZfZFCWaQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ACONNECT, ADMA and AGIC devices for following platforms
  * Jetson TX2
  * Jetson Xavier

Verified driver probe path and devices get registered fine.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
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

