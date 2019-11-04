Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A167FEE1AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 14:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfKDNyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 08:54:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:35632 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729006AbfKDNyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:54:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05295AE07;
        Mon,  4 Nov 2019 13:54:47 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: bcm2711: force CMA into first GB of memory
Date:   Mon,  4 Nov 2019 14:54:11 +0100
Message-Id: <20191104135412.32118-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104135412.32118-1-nsaenzjulienne@suse.de>
References: <20191104135412.32118-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 places the CMA in ZONE_DMA32, which is not good enough for the
Raspberry Pi 4 since it contains peripherals that can only address the
first GB of memory. Explicitly place the CMA into that area.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index cccc1ccd19be..3c7833e9005a 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -19,6 +19,25 @@
 		reg = <0 0 0>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		/*
+		 * arm64 reserves the CMA by default somewhere in ZONE_DMA32,
+		 * that's not good enough for the Raspberry Pi 4 as some
+		 * devices can only address the lower 1G of memory (ZONE_DMA).
+		 */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x2000000>; /* 32MB */
+			alloc-ranges = <0x0 0x00000000 0x40000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
 	leds {
 		act {
 			gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;
-- 
2.23.0

