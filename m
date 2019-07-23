Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 712157141D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 10:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbfGWIlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 04:41:11 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55926 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfGWIlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:41:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F1AD1A02DF;
        Tue, 23 Jul 2019 10:41:08 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 920E31A02D1;
        Tue, 23 Jul 2019 10:41:08 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id AA798205DD;
        Tue, 23 Jul 2019 10:41:07 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     m.felsch@pengutronix.de, shawnguo@kernel.org
Cc:     mark.rutland@arm.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        anson.huang@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, paul.olaru@nxp.com, robh+dt@kernel.org,
        kernel@pengutronix.de, leonard.crestez@nxp.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/5] Add DSP node for i.MX8QXP board to be used by DSP SOF driver
Date:   Tue, 23 Jul 2019 11:40:59 +0300
Message-Id: <20190723084104.12639-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP boards feature an Hifi4 DSP from Tensilica.

This patch series aims on adding the DT node describing the DSP,
but it also contains the Linux SOF DSP driver that will use the DT node
for easier review.

Note that we switched to the new yaml format for bindings documentation.

The DSP will run SOF Firmware [1]. Patches 1,2,3 are adding support
for Linux DSP driver are already sent for review to SOF folks [2]

[1] https://github.com/thesofproject/sof
[2] https://github.com/thesofproject/linux/pull/1048/commits

Changes since v1:
	- removed 'clk: imx8: Add DSP related clocks' as it was already
	  applied by Shawn
	- add patches adding support for Linux DSP driver to make things
	  clear for review
	- add maxItems property for PM in DT bindings doc

Daniel Baluta (5):
  ASoC: SOF: imx: Add i.MX8 HW support
  ASoC: SOF: topology: Add dummy support for i.MX8 DAIs
  ASoC: SOF: Add DT DSP device support
  arm64: dts: imx8qxp: Add DSP DT node
  dt-bindings: dsp: fsl: Add DSP core binding support

 .../devicetree/bindings/dsp/fsl,dsp.yaml      |  87 ++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   4 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |  32 ++
 include/sound/sof/dai.h                       |   2 +
 include/uapi/sound/sof/tokens.h               |   8 +
 sound/soc/sof/Kconfig                         |  10 +
 sound/soc/sof/Makefile                        |   4 +
 sound/soc/sof/imx/Kconfig                     |  21 +
 sound/soc/sof/imx/Makefile                    |   7 +
 sound/soc/sof/imx/imx8.c                      | 464 ++++++++++++++++++
 sound/soc/sof/sof-dt-dev.c                    | 159 ++++++
 sound/soc/sof/topology.c                      |  30 ++
 12 files changed, 828 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
 create mode 100644 sound/soc/sof/imx/Kconfig
 create mode 100644 sound/soc/sof/imx/Makefile
 create mode 100644 sound/soc/sof/imx/imx8.c
 create mode 100644 sound/soc/sof/sof-dt-dev.c

-- 
2.17.1

