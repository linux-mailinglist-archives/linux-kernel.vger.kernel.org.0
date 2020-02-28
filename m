Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC7E1738F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 14:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgB1Nvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 08:51:51 -0500
Received: from foss.arm.com ([217.140.110.172]:38630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgB1Nvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:51:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31DCFFEC;
        Fri, 28 Feb 2020 05:51:49 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52B763F7B4;
        Fri, 28 Feb 2020 05:51:47 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Robert Richter <rric@kernel.org>, Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 4/5] arm: dts: calxeda: Group port-phys and sgpio-gpio items
Date:   Fri, 28 Feb 2020 13:51:05 +0000
Message-Id: <20200228135106.220620-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228135106.220620-1-andre.przywara@arm.com>
References: <20200228135106.220620-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For proper bindings checks we need to properly group the port-phys and
sgpio-gpio items, so that they match the expected number of items.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/ecx-common.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index b7e74a357471..57a028a69373 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -27,10 +27,11 @@
 			reg = <0xffe08000 0x10000>;
 			interrupts = <0 83 4>;
 			dma-coherent;
-			calxeda,port-phys = <&combophy5 0 &combophy0 0
-					     &combophy0 1 &combophy0 2
-					     &combophy0 3>;
-			calxeda,sgpio-gpio =<&gpioh 5 1 &gpioh 6 1 &gpioh 7 1>;
+			calxeda,port-phys = < &combophy5 0>, <&combophy0 0>,
+					     <&combophy0 1>, <&combophy0 2>,
+					     <&combophy0 3>;
+			calxeda,sgpio-gpio =<&gpioh 5 1>, <&gpioh 6 1>,
+					    <&gpioh 7 1>;
 			calxeda,led-order = <4 0 1 2 3>;
 		};
 
-- 
2.17.1

