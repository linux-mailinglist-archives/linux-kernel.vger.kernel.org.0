Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC70F2B9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 10:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbfKGJ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 04:56:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:40806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387827AbfKGJ4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:56:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A81ECB2E5;
        Thu,  7 Nov 2019 09:56:19 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] ARM: dts: bcm2711: force CMA into first GB of memory
Date:   Thu,  7 Nov 2019 10:56:10 +0100
Message-Id: <20191107095611.18429-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107095611.18429-1-nsaenzjulienne@suse.de>
References: <20191107095611.18429-1-nsaenzjulienne@suse.de>
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

Changes since v1:
  - Move into bcm2711.dtsi

Changes since v1:
  - s/Raspberry Pi/bcm2711

 arch/arm/boot/dts/bcm2711.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index ac83dac2e6ba..667658497898 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -12,6 +12,26 @@
 
 	interrupt-parent = <&gicv2>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		/*
+		 * arm64 reserves the CMA by default somewhere in ZONE_DMA32,
+		 * that's not good enough for bcm2711 as some devices can
+		 * only address the lower 1G of memory (ZONE_DMA).
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
+
 	soc {
 		/*
 		 * Defined ranges:
-- 
2.23.0

