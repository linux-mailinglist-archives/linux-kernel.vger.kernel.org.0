Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E81D182C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 10:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCLJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 05:10:36 -0400
Received: from mail.netbsd.org ([199.233.217.200]:65135 "EHLO mail.netbsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLJKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:10:36 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 05:10:35 EDT
Received: by mail.netbsd.org (Postfix, from userid 1220)
        id 9D11D84DCE; Thu, 12 Mar 2020 09:03:50 +0000 (UTC)
From:   Nick Hudson <skrll@netbsd.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nick Hudson <skrll@netbsd.org>
Subject: [PATCH] ARM: bcm2835-rpi-zero-w: Add missing pinctrl name
Date:   Thu, 12 Mar 2020 09:03:45 +0000
Message-Id: <20200312090345.8352-1-skrll@netbsd.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the sdhci pinctrl state as "default" so it gets applied
correctly and to match all other RPis.

Fixes: 2c7c040c73e9 ("ARM: dts: bcm2835: Add Raspberry Pi Zero W")
Signed-off-by: Nick Hudson <skrll@netbsd.org>
---
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
index b75af21069f9..4c3f606e5b8d 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -112,6 +112,7 @@
 &sdhci {
 	#address-cells = <1>;
 	#size-cells = <0>;
+	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_gpio34 &gpclk2_gpio43>;
 	bus-width = <4>;
 	mmc-pwrseq = <&wifi_pwrseq>;
-- 
2.17.1

