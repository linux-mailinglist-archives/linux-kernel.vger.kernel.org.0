Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8F19A125
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 23:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgCaVq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 17:46:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50432 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731511AbgCaVqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:46:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 80572297179
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     mark.rutland@arm.com, ck.hu@mediatek.com, sboyd@kernel.org,
        ulrich.hecht+renesas@gmail.com
Cc:     matthias.bgg@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-clk@vger.kernel.org, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: mt8173: Fix mmsys node name
Date:   Tue, 31 Mar 2020 23:46:09 +0200
Message-Id: <20200331214609.1742152-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200331214609.1742152-1-enric.balletbo@collabora.com>
References: <20200331214609.1742152-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node names are supposed to match the class of the device, mmsys is a
system controller (syscon) not a clock controller, so change the node
name accordingly.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 8b4e806d5119..a55e8c177832 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -908,7 +908,7 @@ u2port1: usb-phy@11291000 {
 			};
 		};
 
-		mmsys: clock-controller@14000000 {
+		mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8173-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
-- 
2.25.1

