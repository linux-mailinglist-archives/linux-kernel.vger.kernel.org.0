Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE6AB4970
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbfIQI1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:27:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46886 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbfIQI1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:27:11 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8pJ-0005ZY-02; Tue, 17 Sep 2019 10:27:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 07/13] arm64: dts: rockchip: move px30-evb console output to uart 5
Date:   Tue, 17 Sep 2019 10:26:53 +0200
Message-Id: <20190917082659.25549-7-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917082659.25549-1-heiko@sntech.de>
References: <20190917082659.25549-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The px30-evb exposes uart2 through a uart-to-usb converter on the board
but these pins are shared with the sdmmc controller. With both activated
this results in a race condition depending in the probe order.
Whichever of the two probes first will break the other peripheral.

The px30-evb also exposes uart5 through pin its pin headers, so it's way
saner to use these pins for serial output and keep the sdmmc working in
all cases.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/px30-evb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index 6d50f6abcb48..80524afe94da 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -14,7 +14,7 @@
 	compatible = "rockchip,px30-evb", "rockchip,px30";
 
 	chosen {
-		stdout-path = "serial2:1500000n8";
+		stdout-path = "serial5:115200n8";
 	};
 
 	adc-keys {
@@ -454,7 +454,7 @@
 	status = "okay";
 };
 
-&uart2 {
+&uart5 {
 	status = "okay";
 };
 
-- 
2.20.1

