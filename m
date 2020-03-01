Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F17A174B72
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 06:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCAFai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 00:30:38 -0500
Received: from inva020.nxp.com ([92.121.34.13]:32874 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgCAFah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 00:30:37 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 738A11A09C0;
        Sun,  1 Mar 2020 06:30:35 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 30C241A09C6;
        Sun,  1 Mar 2020 06:30:26 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 03A8D40299;
        Sun,  1 Mar 2020 13:30:14 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] ASoC: dt-bindings: fsl_asrc: Change asrc-width to asrc-format
Date:   Sun,  1 Mar 2020 13:24:12 +0800
Message-Id: <872c2e1082de6348318e14ccd31884d62355c282.1583039752.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1583039752.git.shengjiu.wang@nxp.com>
References: <cover.1583039752.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1583039752.git.shengjiu.wang@nxp.com>
References: <cover.1583039752.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asrc_format is more inteligent, which is align with the alsa
definition snd_pcm_format_t, we don't need to convert it to
format in driver, and it can distinguish S24_LE & S24_3LE.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,asrc.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index cb9a25165503..0cbb86c026d5 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -38,7 +38,9 @@ Required properties:
 
    - fsl,asrc-rate	: Defines a mutual sample rate used by DPCM Back Ends.
 
-   - fsl,asrc-width	: Defines a mutual sample width used by DPCM Back Ends.
+   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
+			  Ends. The value is one of SNDRV_PCM_FORMAT_XX in
+			  "include/uapi/sound/asound.h"
 
    - fsl,asrc-clk-map   : Defines clock map used in driver. which is required
 			  by imx8qm/imx8qxp platform
-- 
2.21.0

