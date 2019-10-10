Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCE0AD3192
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 21:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfJJToM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 15:44:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54390 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJToL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:44:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 3CFF828FC8E
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
        Ezequiel Garcia <ezequiel@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/3] dt-bindings: display: rockchip: document VOP gamma LUT address
Date:   Thu, 10 Oct 2019 16:43:49 -0300
Message-Id: <20191010194351.17940-2-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191010194351.17940-1-ezequiel@collabora.com>
References: <20191010194351.17940-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the register specifier description for an
optional gamma LUT address.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v4:
* None.
Changes from v3:
* None.
Changes from v2:
* None.
Changes from v1:
* Drop reg-names, suggested by Doug.
---
 .../devicetree/bindings/display/rockchip/rockchip-vop.txt   | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
index 4f58c5a2d195..8b3a5f514205 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
@@ -20,6 +20,10 @@ Required properties:
 		"rockchip,rk3228-vop";
 		"rockchip,rk3328-vop";
 
+- reg: Must contain one entry corresponding to the base address and length
+	of the register space. Can optionally contain a second entry
+	corresponding to the CRTC gamma LUT address.
+
 - interrupts: should contain a list of all VOP IP block interrupts in the
 		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
 		 format depends on the interrupt controller used.
@@ -48,7 +52,7 @@ Example:
 SoC specific DT entry:
 	vopb: vopb@ff930000 {
 		compatible = "rockchip,rk3288-vop";
-		reg = <0xff930000 0x19c>;
+		reg = <0x0 0xff930000 0x0 0x19c>, <0x0 0xff931000 0x0 0x1000>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
-- 
2.22.0

