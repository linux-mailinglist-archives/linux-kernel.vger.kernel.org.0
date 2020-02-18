Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 373B416210E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 07:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgBRGqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 01:46:12 -0500
Received: from inva020.nxp.com ([92.121.34.13]:42276 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgBRGqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 01:46:12 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CF2281A3775;
        Tue, 18 Feb 2020 07:46:10 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C29CD1A3778;
        Tue, 18 Feb 2020 07:46:03 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5C3E540345;
        Tue, 18 Feb 2020 14:45:26 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add new module driver for new ASRC
Date:   Tue, 18 Feb 2020 14:39:34 +0800
Message-Id: <cover.1582007379.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new module driver for new ASRC in i.MX8MN.

Shengjiu Wang (3):
  ASoC: fsl_asrc: Move common definition to fsl_asrc_common
  ASoC: dt-bindings: fsl_easrc: Add document for EASRC
  ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and platform drivers

changes in v2
- change i.MX815 to i.MX8MN
- Add changes in Kconfig and Makefile

 .../devicetree/bindings/sound/fsl,easrc.txt   |   57 +
 sound/soc/fsl/Kconfig                         |   10 +
 sound/soc/fsl/Makefile                        |    2 +
 sound/soc/fsl/fsl_asrc.h                      |   11 +-
 sound/soc/fsl/fsl_asrc_common.h               |   22 +
 sound/soc/fsl/fsl_easrc.c                     | 2265 +++++++++++++++++
 sound/soc/fsl/fsl_easrc.h                     |  668 +++++
 sound/soc/fsl/fsl_easrc_dma.c                 |  440 ++++
 8 files changed, 3465 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.txt
 create mode 100644 sound/soc/fsl/fsl_asrc_common.h
 create mode 100644 sound/soc/fsl/fsl_easrc.c
 create mode 100644 sound/soc/fsl/fsl_easrc.h
 create mode 100644 sound/soc/fsl/fsl_easrc_dma.c

-- 
2.21.0

