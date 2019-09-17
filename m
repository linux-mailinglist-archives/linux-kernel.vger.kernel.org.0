Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03509B499E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbfIQIge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:36:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47426 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388965AbfIQIge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:36:34 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8yO-0005lE-Jo; Tue, 17 Sep 2019 10:36:32 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] arm64: dts: rockchip: add missing #msi-cells to rk3399
Date:   Tue, 17 Sep 2019 10:36:25 +0200
Message-Id: <20190917083625.25818-1-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3399 gic-its was missing the #msi-cells property as found by
dt-schema checks, so add it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index b5a5ef5ff449..788a7ed62e19 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -520,6 +520,7 @@
 		its: interrupt-controller@fee20000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0xfee20000 0x0 0x20000>;
 		};
 
-- 
2.20.1

