Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13794EDF3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 12:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfKDLyV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Nov 2019 06:54:21 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:51798 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfKDLyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:54:17 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id E384360038F;
        Mon,  4 Nov 2019 12:54:13 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 4 Nov 2019
 12:54:13 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 4 Nov 2019 12:54:13 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/9] ARM: dts: imx6ul-kontron-n6x1x: Add 'chosen' node with
 'stdout-path'
Thread-Topic: [PATCH v4 6/9] ARM: dts: imx6ul-kontron-n6x1x: Add 'chosen' node
 with 'stdout-path'
Thread-Index: AQHVkwaTeRRZFHGW4UG8zlJmKJZv9A==
Date:   Mon, 4 Nov 2019 11:54:13 +0000
Message-ID: <20191104115352.8728-7-frieder.schrempf@kontron.de>
References: <20191104115352.8728-1-frieder.schrempf@kontron.de>
In-Reply-To: <20191104115352.8728-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: E384360038F.AE84F
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The Kontron N6x1x SoMs all use uart4 as a debug serial interface.
Therefore we set it in the 'chosen' node.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
index a843e028bcde..a17af4d9bfdf 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
@@ -7,6 +7,12 @@
 
 #include <dt-bindings/gpio/gpio.h>
 
+/ {
+	chosen {
+		stdout-path = &uart4;
+	};
+};
+
 &ecspi2 {
 	cs-gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
-- 
2.17.1
