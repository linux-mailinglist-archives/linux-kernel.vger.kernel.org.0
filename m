Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62CEFD319B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 21:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfJJToV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 15:44:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54468 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJToU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:44:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 2DE062909A7
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v5 3/3] ARM: dts: rockchip: Add RK3288 VOP gamma LUT address
Date:   Thu, 10 Oct 2019 16:43:51 -0300
Message-Id: <20191010194351.17940-4-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191010194351.17940-1-ezequiel@collabora.com>
References: <20191010194351.17940-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3288 SoC VOPs have optional support Gamma LUT setting,
which requires specifying the Gamma LUT address in the devicetree.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes from v4:
* None.
Changes from v3:
* None.
Changes from v2:
* None.
Changes from v1:
* Drop reg-names, as suggested by Doug.
---
 arch/arm/boot/dts/rk3288.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index cc893e154fe5..c6fc633ace80 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1023,7 +1023,7 @@
 
 	vopb: vop@ff930000 {
 		compatible = "rockchip,rk3288-vop";
-		reg = <0x0 0xff930000 0x0 0x19c>;
+		reg = <0x0 0xff930000 0x0 0x19c>, <0x0 0xff931000 0x0 0x1000>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
@@ -1073,7 +1073,7 @@
 
 	vopl: vop@ff940000 {
 		compatible = "rockchip,rk3288-vop";
-		reg = <0x0 0xff940000 0x0 0x19c>;
+		reg = <0x0 0xff940000 0x0 0x19c>, <0x0 0xff941000 0x0 0x1000>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
-- 
2.22.0

