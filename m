Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C6A33205
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 16:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfFCOW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 10:22:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34446 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfFCOW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:22:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id A1E642639EE
From:   Helen Koike <helen.koike@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, ezequiel@collabora.com,
        laurent.pinchart@ideasonboard.com,
        manivannan.sadhasivam@linaro.org,
        Helen Koike <helen.koike@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Vicente Bergas <vicencb@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Xie <tony.xie@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: fix isp iommu clocks and power domain
Date:   Mon,  3 Jun 2019 11:22:15 -0300
Message-Id: <20190603142214.24686-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isp iommu requires wrapper variants of the clocks.
noc variants are always on and using the wrapper variants will activate
{A,H}CLK_ISP{0,1} due to the hierarchy.

Also add the respective power domain.

Refer:
 RK3399 TRM v1.4 Fig. 2-4 RK3399 Clock Architecture Diagram
 RK3399 TRM v1.4 Fig. 8-1 RK3399 Power Domain Partition

Signed-off-by: Helen Koike <helen.koike@collabora.com>

---
Hello,

I tested this using the isp patch set (which is not upstream
yet). Without this patch, streaming from the isp stalls.

I'm also enabling the power domain and removing the disable status,
please let me know if this should be done in a separated patch.

Thanks
Helen

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 196ac9b78076..89594a7276f4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1706,11 +1706,11 @@
 		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "isp0_mmu";
-		clocks = <&cru ACLK_ISP0_NOC>, <&cru HCLK_ISP0_NOC>;
+		clocks = <&cru ACLK_ISP0_WRAPPER>, <&cru HCLK_ISP0_WRAPPER>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		power-domains = <&power RK3399_PD_ISP0>;
 		rockchip,disable-mmu-reset;
-		status = "disabled";
 	};
 
 	isp1_mmu: iommu@ff924000 {
@@ -1718,11 +1718,11 @@
 		reg = <0x0 0xff924000 0x0 0x100>, <0x0 0xff925000 0x0 0x100>;
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "isp1_mmu";
-		clocks = <&cru ACLK_ISP1_NOC>, <&cru HCLK_ISP1_NOC>;
+		clocks = <&cru ACLK_ISP1_WRAPPER>, <&cru HCLK_ISP1_WRAPPER>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		power-domains = <&power RK3399_PD_ISP1>;
 		rockchip,disable-mmu-reset;
-		status = "disabled";
 	};
 
 	hdmi_sound: hdmi-sound {
-- 
2.20.1

