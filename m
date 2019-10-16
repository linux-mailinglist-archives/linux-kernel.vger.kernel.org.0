Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9003D92EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 15:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405541AbfJPNtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 09:49:55 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:39698 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405519AbfJPNtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:49:53 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 1EB01A26C9;
        Wed, 16 Oct 2019 15:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1571233792;
        bh=erasMNJVDzkpqE/Lkt54LFkKCs93IkeeRqS23J8cd9A=;
        h=From:To:Cc:Subject:Date:From;
        b=meg7KkdydlXzbCYQcmxPojik1y6ceyJQoGpApWAA/mUpnuawE8vFM1G0D7J7Gopxa
         afFlvNJ3+tzY9lmY6qJhqdWU/BoIhNZfZ5oHmnUhffw9YOjsAoZYK/emGI1H1F1e9m
         fky2lG8YBZp8j0IHEkBVsG87PXIa29xFBaw+mVnU=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH] ARM: dts: imx6dl-yapp4: Enable the I2C3 bus on all board variants
Date:   Wed, 16 Oct 2019 15:49:49 +0200
Message-Id: <1571233789-4491-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx6dl-yapp4 Draco and Ursa boards use the I2C3 bus to control some
external devices through the /dev files.

So enable the I2C3 bus on all board variants, not just on Hydra.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 +-
 arch/arm/boot/dts/imx6dl-yapp4-hydra.dts   | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 663a72a96b6c..e2991a02f30f 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -308,7 +308,7 @@
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "disabled";
+	status = "okay";
 
 	oled: oled@3d {
 		compatible = "solomon,ssd1305fb-i2c";
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts b/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
index f97927064750..264f9271895d 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
+++ b/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
@@ -25,10 +25,6 @@
 	status = "okay";
 };
 
-&i2c3 {
-	status = "okay";
-};
-
 &leds {
 	status = "okay";
 };
-- 
2.1.4

