Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A601817D864
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 05:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgCIEFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 00:05:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37758 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgCIEFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 00:05:30 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D73822015B5;
        Mon,  9 Mar 2020 05:05:28 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BF7AD2015AB;
        Mon,  9 Mar 2020 05:05:21 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A4786402CA;
        Mon,  9 Mar 2020 12:05:12 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/7] ASoC: dt-bindings: fsl_asrc: Add new property fsl,asrc-format
Date:   Mon,  9 Mar 2020 11:58:28 +0800
Message-Id: <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1583725533.git.shengjiu.wang@nxp.com>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1583725533.git.shengjiu.wang@nxp.com>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support new EASRC and simplify the code structure,
We decide to share the common structure between them. This bring
a problem that EASRC accept format directly from devicetree, but
ASRC accept width from devicetree.

In order to align with new ESARC, we add new property fsl,asrc-format.
The fsl,asrc-format can replace the fsl,asrc-width, then driver
can accept format from devicetree, don't need to convert it to
format through width.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,asrc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index cb9a25165503..780455cf7f71 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -51,6 +51,11 @@ Optional properties:
 			  will be in use as default. Otherwise, the big endian
 			  mode will be in use for all the device registers.
 
+   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
+			  Ends, which can replace the fsl,asrc-width.
+			  The value is SNDRV_PCM_FORMAT_S16_LE, or
+			  SNDRV_PCM_FORMAT_S24_LE
+
 Example:
 
 asrc: asrc@2034000 {
-- 
2.21.0

