Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE79F705F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 10:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKKJUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 04:20:17 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42238 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfKKJUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:20:16 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A3572200031;
        Mon, 11 Nov 2019 10:20:14 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 93BBD2005D1;
        Mon, 11 Nov 2019 10:20:08 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D7F6F402C7;
        Mon, 11 Nov 2019 17:20:00 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH V3 1/2] ASoC: dt-bindings: fsl_asrc: add compatible string for imx8qm
Date:   Mon, 11 Nov 2019 17:18:22 +0800
Message-Id: <b1c922b3496020f611ecd6ea27d262369646d830.1573462647.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string "fsl,imx8qm-asrc" for imx8qm platform.

There are two asrc modules in imx8qm, the clock mapping is
different for each other, so add new property "fsl,asrc-clk-map"
to distinguish them.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2
-none

changes in v3
-use only one compatible string "fsl,imx8qm-asrc",
-add new property "fsl,asrc-clk-map".

 Documentation/devicetree/bindings/sound/fsl,asrc.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index 1d4d9f938689..02edab7cf3e0 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -8,7 +8,8 @@ three substreams within totally 10 channels.
 
 Required properties:
 
-  - compatible		: Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
+  - compatible		: Contains "fsl,imx35-asrc", "fsl,imx53-asrc",
+			  "fsl,imx8qm-asrc".
 
   - reg			: Offset and length of the register set for the device.
 
@@ -35,6 +36,13 @@ Required properties:
 
    - fsl,asrc-width	: Defines a mutual sample width used by DPCM Back Ends.
 
+   - fsl,asrc-clk-map   : Defines clock map used in driver. which is required
+			  by imx8qm/imx8qxp platform
+			  <0> - select the map for asrc0 in imx8qm
+			  <1> - select the map for asrc1 in imx8qm
+			  <2> - select the map for asrc0 in imx8qxp
+			  <3> - select the map for asrc1 in imx8qxp
+
 Optional properties:
 
    - big-endian		: If this property is absent, the little endian mode
-- 
2.21.0

