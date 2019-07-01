Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B332921AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 17:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfEQPfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 11:35:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:39162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728778AbfEQPfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:35:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA787AF67;
        Fri, 17 May 2019 15:35:17 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 4/5] dts: bcm2837: add per-cpu clock devices
Date:   Fri, 17 May 2019 17:35:06 +0200
Message-Id: <20190517153508.18314-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517153508.18314-1-nsaenzjulienne@suse.de>
References: <20190517153508.18314-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The four CPUs share a same clock source called pllb_arm. The clock can
be scaled through the raspberrypi firmware interface.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/boot/dts/bcm2837.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
index beb6c502dadc..a8fea6696b42 100644
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -44,6 +44,8 @@
 			reg = <0>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0x0 0x000000d8>;
+			clocks = <&clocks BCM2835_PLLB_ARM>;
+			clock-names = "pllb_arm";
 		};
 
 		cpu1: cpu@1 {
@@ -52,6 +54,8 @@
 			reg = <1>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0x0 0x000000e0>;
+			clocks = <&clocks BCM2835_PLLB_ARM>;
+			clock-names = "pllb_arm";
 		};
 
 		cpu2: cpu@2 {
@@ -60,6 +64,8 @@
 			reg = <2>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0x0 0x000000e8>;
+			clocks = <&clocks BCM2835_PLLB_ARM>;
+			clock-names = "pllb_arm";
 		};
 
 		cpu3: cpu@3 {
@@ -68,6 +74,8 @@
 			reg = <3>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0x0 0x000000f0>;
+			clocks = <&clocks BCM2835_PLLB_ARM>;
+			clock-names = "pllb_arm";
 		};
 	};
 };
-- 
2.21.0

