Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF829EB26A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 15:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfJaOYA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Oct 2019 10:24:00 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:42394 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfJaOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:24:00 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 6F6CD60CB06;
        Thu, 31 Oct 2019 15:23:58 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 15:23:58 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Thu, 31 Oct 2019 15:23:57 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/11] Add support for more Kontron i.MX6UL/ULL SoMs and
 boards
Thread-Topic: [PATCH v3 00/11] Add support for more Kontron i.MX6UL/ULL SoMs
 and boards
Thread-Index: AQHVj/bVnKli3478oESPylZmD7kmiQ==
Date:   Thu, 31 Oct 2019 14:23:57 +0000
Message-ID: <20191031142112.12431-1-frieder.schrempf@kontron.de>
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
X-SnT-MailScanner-ID: 6F6CD60CB06.A11BE
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

In order to support more of the i.MX6UL/ULL-based SoMs and boards by
Kontron Electronics GmbH, we restructure the devicetrees to share common
parts and add new devicetrees for the missing boards.

Currently there are the following SoM flavors:
  * N6310: SoM with i.MX6UL-2, 256MB RAM, 256MB SPI NAND
  * N6311: SoM with i.MX6UL-2, 512MB RAM, 512MB SPI NAND (new)
  * N6411: SoM with i.MX6ULL, 512MB RAM, 512MB SPI NAND (new)

Each of the SoMs also features 1MB SPI NOR and an Ethernet PHY. The carrier
board for the evalkit is the same for all SoMs.

This series also includes some small fixes for the shared parts of the
devicetrees.
---
Changes for v3:
===============
* Add a patch that removes the snvs-poweroff node as it is not used
* Drop patch to add missing includes for gpio.h and irq.h as it is not needed
* Add Fixes tags to those patches that fix an issue in the existing devicetrees
* Add Reviewed-by tags from Krzysztof
* Minor improvements to commit messages and cover letter

Changes for v2:
===============
* Patch 1: Move the spi-flash node instead of duplicating it
* Patch 3: Add a missing include for dt-bindings/gpio/gpio.h
* Patch 11: Add patch to add missing includes for gpio.h and irq.h
* Add Reviewed-by tags from Krzysztof and Rob
---
Frieder Schrempf (11):
  ARM: dts: imx6ul-kontron-n6310: Move common SoM nodes to a separate
    file
  ARM: dts: Add support for two more Kontron SoMs N6311 and N6411
  ARM: dts: imx6ul-kontron-n6310-s: Move common nodes to a separate file
  ARM: dts: Add support for two more Kontron evalkit boards 'N6311 S'
    and 'N6411 S'
  ARM: dts: imx6ul-kontron-n6x1x: Add 'chosen' node with 'stdout-path'
  ARM: dts: imx6ul-kontron-n6x1x-s: Specify bus-width for SD card and
    eMMC
  ARM: dts: imx6ul-kontron-n6x1x-s: Add vbus-supply and overcurrent
    polarity to usb nodes
  ARM: dts: imx6ul-kontron-n6x1x-s: Remove an obsolete comment and fix
    indentation
  ARM: dts: imx6ul-kontron-n6x1x-s: Disable the snvs-poweroff driver
  dt-bindings: arm: fsl: Add more Kontron i.MX6UL/ULL compatibles
  MAINTAINERS: Add an entry for Kontron Electronics ARM board support

 .../devicetree/bindings/arm/fsl.yaml          |  14 +
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts  | 405 +----------------
 .../boot/dts/imx6ul-kontron-n6310-som.dtsi    |  95 +---
 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts  |  16 +
 .../boot/dts/imx6ul-kontron-n6311-som.dtsi    |  40 ++
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi | 420 ++++++++++++++++++
 .../dts/imx6ul-kontron-n6x1x-som-common.dtsi  | 109 +++++
 arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts |  16 +
 .../boot/dts/imx6ull-kontron-n6411-som.dtsi   |  40 ++
 10 files changed, 663 insertions(+), 498 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi

-- 
2.17.1
