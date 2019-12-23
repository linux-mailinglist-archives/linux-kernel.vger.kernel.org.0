Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56AF0129B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 22:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLWVon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 16:44:43 -0500
Received: from lists.gateworks.com ([108.161.130.12]:55770 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfLWVom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 16:44:42 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=rjones.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <rjones@gateworks.com>)
        id 1ijVk9-0007o6-Pq; Mon, 23 Dec 2019 22:00:01 +0000
From:   Robert Jones <rjones@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH v3 0/4] ARM: dts: imx: Add GW59xx Gateworks specials
Date:   Mon, 23 Dec 2019 13:44:08 -0800
Message-Id: <20191223214412.12259-1-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds board support for the GW59xx Gateworks Ventana family
specials.

Changes in v2:
 - Generalized node names
 - Removed unnecessary labels
 - Expanded patch subject
 - Removed undocumented compatible string in dts**

** I realize that the "gw,ventana" still exists here, but that cant be removed
without breaking a conditional check in arch/arm/mach-imx/mach-imx6q.c

Changes in v3:
 - Fixed a conflict in arch/arm/boot/dts/Makefile

Robert Jones (3):
  ARM: dts: imx: Add GW5907 board support
  ARM: dts: imx: Add GW5913 board support
  ARM: dts: imx: Add GW5912 board support

Tim Harvey (1):
  ARM: dts: imx: Add GW5910 board support

 arch/arm/boot/dts/Makefile            |   8 +
 arch/arm/boot/dts/imx6dl-gw5907.dts   |  14 +
 arch/arm/boot/dts/imx6dl-gw5910.dts   |  14 +
 arch/arm/boot/dts/imx6dl-gw5912.dts   |  13 +
 arch/arm/boot/dts/imx6dl-gw5913.dts   |  14 +
 arch/arm/boot/dts/imx6q-gw5907.dts    |  14 +
 arch/arm/boot/dts/imx6q-gw5910.dts    |  14 +
 arch/arm/boot/dts/imx6q-gw5912.dts    |  13 +
 arch/arm/boot/dts/imx6q-gw5913.dts    |  14 +
 arch/arm/boot/dts/imx6qdl-gw5907.dtsi | 399 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi | 491 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw5912.dtsi | 461 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw5913.dtsi | 348 ++++++++++++++++++++++++
 13 files changed, 1817 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5907.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5910.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5912.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5913.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5907.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5910.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5912.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5913.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5907.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5910.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5912.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5913.dtsi

-- 
2.9.2

