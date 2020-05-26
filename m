Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2D719A7DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 10:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbgDAIxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 04:53:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38090 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732064AbgDAIxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:53:21 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F24791A0D3B;
        Wed,  1 Apr 2020 10:53:19 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D41881A0D75;
        Wed,  1 Apr 2020 10:53:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 070F640297;
        Wed,  1 Apr 2020 16:53:03 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/7] ASoC: dt-bindings: fsl_asrc: Add new property fsl,asrc-format
Date:   Wed,  1 Apr 2020 16:45:35 +0800
Message-Id: <47fcf06689d1a086141ce4d80f7ea7af7958dc89.1585726761.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1585726761.git.shengjiu.wang@nxp.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1585726761.git.shengjiu.wang@nxp.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
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
 Documentation/devicetree/bindings/sound/fsl,asrc.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index cb9a25165503..998b4c8a7f78 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -51,6 +51,10 @@ Optional properties:
 			  will be in use as default. Otherwise, the big endian
 			  mode will be in use for all the device registers.
 
+   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
+			  Ends, which can replace the fsl,asrc-width.
+			  The value is 2 (S16_LE), or 6 (S24_LE).
+
 Example:
 
 asrc: asrc@2034000 {
-- 
2.21.0

