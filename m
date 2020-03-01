Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25222174B66
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 06:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCAFaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 00:30:39 -0500
Received: from inva021.nxp.com ([92.121.34.21]:55958 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgCAFai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 00:30:38 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E2F8C200A2E;
        Sun,  1 Mar 2020 06:30:33 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A1F7C200A2D;
        Sun,  1 Mar 2020 06:30:24 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 813FD40294;
        Sun,  1 Mar 2020 13:30:13 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] ASoC: Add new module driver for new ASRC
Date:   Sun,  1 Mar 2020 13:24:11 +0800
Message-Id: <cover.1583039752.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new module driver for new ASRC in i.MX8MN, several commits
are added for change DT binding asrc-width to asrc-format

Shengjiu Wang (8):
  ASoC: dt-bindings: fsl_asrc: Change asrc-width to asrc-format
  ARM: dts: imx6qdl: Change asrc-width to asrc-format
  ASoC: fsl-asoc-card: Change asrc-width to asrc-format
  ASoC: fsl_asrc: Change asrc_width to asrc_format
  ASoC: fsl_asrc: rename asrc_priv to asrc
  ASoC: fsl_asrc: Move common definition to fsl_asrc_common
  ASoC: dt-bindings: fsl_easrc: Add document for EASRC
  ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and platform drivers

changes in v4
- Add several commit for changing DT binding asrc-width to asrc-format
- rename asrc_priv to asrc

changes in v3
- add new commit "ASoC: fsl_asrc: Change asrc_width to asrc_format"
- modify binding doc to yaml format
- remove fsl_easrc_dma.c, make fsl_asrc_dma.c useable for easrc.

changes in v2
- change i.MX815 to i.MX8MN
- Add changes in Kconfig and Makefile

 .../devicetree/bindings/sound/fsl,asrc.txt    |    4 +-
 .../devicetree/bindings/sound/fsl,easrc.yaml  |   96 +
 arch/arm/boot/dts/imx6qdl.dtsi                |    2 +-
 sound/soc/fsl/Kconfig                         |   11 +
 sound/soc/fsl/Makefile                        |    2 +
 sound/soc/fsl/fsl-asoc-card.c                 |    9 +-
 sound/soc/fsl/fsl_asrc.c                      |  282 +--
 sound/soc/fsl/fsl_asrc.h                      |   74 +-
 sound/soc/fsl/fsl_asrc_common.h               |  105 +
 sound/soc/fsl/fsl_asrc_dma.c                  |   54 +-
 sound/soc/fsl/fsl_easrc.c                     | 2111 +++++++++++++++++
 sound/soc/fsl/fsl_easrc.h                     |  651 +++++
 12 files changed, 3169 insertions(+), 232 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml
 create mode 100644 sound/soc/fsl/fsl_asrc_common.h
 create mode 100644 sound/soc/fsl/fsl_easrc.c
 create mode 100644 sound/soc/fsl/fsl_easrc.h

-- 
2.21.0

