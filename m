Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9FF6D0D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 17:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390783AbfGRPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 11:13:51 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36966 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727756AbfGRPNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:13:51 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 58CCF200031;
        Thu, 18 Jul 2019 17:13:49 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 48FF4200009;
        Thu, 18 Jul 2019 17:13:49 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B4B9205C7;
        Thu, 18 Jul 2019 17:13:48 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        daniel.baluta@nxp.com, shengjiu.wang@nxp.com, paul.olaru@nxp.com,
        aisheng.dong@nxp.com, leonard.crestez@nxp.com, anson.huang@nxp.com,
        peng.fan@nxp.com, Frank.Li@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org
Subject: [PATCH 0/3] Add DSP node on i.MX8QXP board
Date:   Thu, 18 Jul 2019 18:13:43 +0300
Message-Id: <20190718151346.3523-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP boards feature an Hifi4 DSP from Tensilica. This patch series
adds the DT node.

Note that we switched to the new yaml format for bindings documentation.

The DSP will run SOF Firmware [1]. Patches adding support for Linux DSP
driver are already sent for review to SOF folks [2].

This patch series also contains a patch introducing DT related clocks.

The patch was already reviewed here:
	https://lkml.org/lkml/2019/7/17/975

but I added it in this patch series because it wasn't yet picked by
Shawn so patches 2/3 will not compiled without patch 1.

[1] https://github.com/thesofproject/sof
[2] https://github.com/thesofproject/linux/pull/1048/commits

Daniel Baluta (3):
  clk: imx8: Add DSP related clocks
  arm64: dts: imx8qxp: Add DSP DT node
  dt-bindings: dsp: fsl: Add DSP core binding support

 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 87 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  4 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 32 +++++++
 drivers/clk/imx/clk-imx8qxp-lpcg.c            |  5 ++
 include/dt-bindings/clock/imx8-clock.h        |  6 +-
 5 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml

-- 
2.17.1

