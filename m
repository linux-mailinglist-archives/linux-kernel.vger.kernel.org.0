Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DF97DF51
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 17:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfHAPqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 11:46:46 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:38384 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfHAPqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:46:46 -0400
Received: from dslb-094-223-182-030.094.223.pools.vodafone-ip.de ([94.223.182.30] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1htDHs-0008SJ-5a; Thu, 01 Aug 2019 17:46:40 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/8] move native-mode inside display-timings
Date:   Thu,  1 Aug 2019 17:46:20 +0200
Message-Id: <20190801154628.1624-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For display descriptions in the device tree, native-mode is a property
of the display-timings node.

Fix this for the boards that got it wrong and added native-mode on the
same level as display-timings.

Martin Kaiser (8):
  ARM: dts: imx27 phyCARD-S: native-mode is part of display-timings
  ARM: dts: imx25: mbimxsd25: native-mode is part of display-timings
  ARM: dts: eukrea-mbimxsd27: native-mode is part of display-timings
  ARM: dts: mbimxsd25: native-mode is part of display-timings
  ARM: dts: imx27-phytec-phycore-rdk: native-mode is part of display-timings
  ARM: dts: edb7211: native-mode is part of display-timings
  ARM: dts: apf27dev: native-mode is part of display-timings
  ARM: dts: imx25: mbimxsd25: native-mode is part of display-timings

 arch/arm/boot/dts/ep7211-edb7211.dts                            | 2 +-
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts | 2 +-
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts | 2 +-
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts  | 2 +-
 arch/arm/boot/dts/imx27-apf27dev.dts                            | 2 +-
 arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts          | 2 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts                | 2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts                  | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.11.0

