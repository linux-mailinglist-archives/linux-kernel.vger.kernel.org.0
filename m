Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D760193FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 14:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgCZNoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 09:44:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:50210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbgCZNo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:44:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 09B2EAB3D;
        Thu, 26 Mar 2020 13:44:28 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: bcm283x: Add cells encoding format to firmware bus
Date:   Thu, 26 Mar 2020 14:44:13 +0100
Message-Id: <20200326134413.12298-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of 55c7c0621078 ("ARM: dts: bcm283x: Fix vc4's
firmware bus DMA limitations") the firmware bus has to comply with
/soc's DMA limitations. Ultimately linking both buses to a same
dma-ranges property. The patch (and author) missed the fact that a bus'
#address-cells and #size-cells properties are not inherited, but set to
a fixed value which, in this case, doesn't match /soc's. This, although
not breaking Linux's DMA mapping functionality, generates ugly dtc
warnings.

Fix the issue by adding the correct address and size cells properties
under the firmware bus.

Fixes: 55c7c0621078 ("ARM: dts: bcm283x: Fix vc4's firmware bus DMA limitations")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index fd2c766e0f71..f7ae5a4530b8 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -14,6 +14,9 @@ act {
 	soc {
 		firmware: firmware {
 			compatible = "raspberrypi,bcm2835-firmware", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
 			mboxes = <&mailbox>;
 			dma-ranges;
 		};
-- 
2.25.1

