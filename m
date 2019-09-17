Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96182B4973
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbfIQI1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:27:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46808 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbfIQI1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:27:09 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8pI-0005ZY-1h; Tue, 17 Sep 2019 10:27:08 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 04/13] arm64: dts: rockchip: add default px30 emmc pinctrl
Date:   Tue, 17 Sep 2019 10:26:50 +0200
Message-Id: <20190917082659.25549-4-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917082659.25549-1-heiko@sntech.de>
References: <20190917082659.25549-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

emmc chips are normally hooked up in standard ways using the full 8bit
bus connection, so there should be no need for all future boards to define
this on their own. So add default pin setups for 8bit busses and special
boards really only needing 4 or 1 bit connections can override.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index a178d6e2c279..f2bbdfa0e4aa 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -794,6 +794,8 @@
 		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
 		power-domains = <&power PX30_PD_MMC_NAND>;
 		status = "disabled";
 	};
-- 
2.20.1

