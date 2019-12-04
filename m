Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAFB112ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 13:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfLDMCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 07:02:41 -0500
Received: from inva021.nxp.com ([92.121.34.21]:33584 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbfLDMCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:02:41 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 79266200421;
        Wed,  4 Dec 2019 13:02:36 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 69C7F20010B;
        Wed,  4 Dec 2019 13:02:30 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 086AC402AD;
        Wed,  4 Dec 2019 20:02:22 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] ASoC: dt-bindings: fsl_asrc: add compatible string for imx8qm & imx8qxp
Date:   Wed,  4 Dec 2019 20:00:18 +0800
Message-Id: <b9352edb014c1ee8530c0fd8829c2b044b3da649.1575452454.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string "fsl,imx8qm-asrc" for imx8qm platform,
"fsl,imx8qxp-asrc" for imx8qxp platform.

There are two asrc modules in imx8qm & imx8qxp, the clock mapping is
different for each other, so add new property "fsl,asrc-clk-map"
to distinguish them.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2
-none

changes in v3
-use only one compatible string "fsl,imx8qm-asrc",
-add new property "fsl,asrc-clk-map".

changes in v4
-add "fsl,imx8qxp-asrc"

changes in v5
-refine the comments for compatible

 Documentation/devicetree/bindings/sound/fsl,asrc.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index 1d4d9f938689..cb9a25165503 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -8,7 +8,12 @@ three substreams within totally 10 channels.
 
 Required properties:
 
-  - compatible		: Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
+  - compatible		: Compatible list, should contain one of the following
+			  compatibles:
+			  "fsl,imx35-asrc",
+			  "fsl,imx53-asrc",
+			  "fsl,imx8qm-asrc",
+			  "fsl,imx8qxp-asrc",
 
   - reg			: Offset and length of the register set for the device.
 
@@ -35,6 +40,11 @@ Required properties:
 
    - fsl,asrc-width	: Defines a mutual sample width used by DPCM Back Ends.
 
+   - fsl,asrc-clk-map   : Defines clock map used in driver. which is required
+			  by imx8qm/imx8qxp platform
+			  <0> - select the map for asrc0 in imx8qm/imx8qxp
+			  <1> - select the map for asrc1 in imx8qm/imx8qxp
+
 Optional properties:
 
    - big-endian		: If this property is absent, the little endian mode
-- 
2.21.0

