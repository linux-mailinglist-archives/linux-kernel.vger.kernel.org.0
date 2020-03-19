Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0C18AC75
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 06:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCSF4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 01:56:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39063 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCSF4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 01:56:53 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jEoAh-0000dw-ED; Thu, 19 Mar 2020 06:56:47 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jEoAZ-0001zC-P2; Thu, 19 Mar 2020 06:56:39 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 0/5] mainline Protonic boards
Date:   Thu, 19 Mar 2020 06:56:31 +0100
Message-Id: <20200319055636.7573-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v2:
- squash PRTI6Q patches

Oleksij Rempel (5):
  dt-bindings: vendor-prefixes: Add an entry for Protonic Holland
  ARM: dts: add Protonic PRTI6Q board
  ARM: dts: add Protonic WD2 board
  ARM: dts: add Protonic VT7 board
  ARM: dts: add Protonic RVT board

 .../devicetree/bindings/arm/fsl.yaml          |   4 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   4 +
 arch/arm/boot/dts/imx6dl-prtrvt.dts           | 108 ++++
 arch/arm/boot/dts/imx6dl-prtvt7.dts           | 390 ++++++++++++++
 arch/arm/boot/dts/imx6q-prti6q.dts            | 286 ++++++++++
 arch/arm/boot/dts/imx6q-prtwd2.dts            | 242 +++++++++
 arch/arm/boot/dts/imx6qdl-prti6q.dtsi         | 489 ++++++++++++++++++
 8 files changed, 1525 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-prtrvt.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-prtvt7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-prti6q.dts
 create mode 100644 arch/arm/boot/dts/imx6q-prtwd2.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-prti6q.dtsi

-- 
2.25.1

