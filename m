Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12556D5780
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfJMTAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 15:00:20 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39270 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729362AbfJMTAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:00:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 70AEB20073C;
        Sun, 13 Oct 2019 21:00:17 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6DEBC20014F;
        Sun, 13 Oct 2019 21:00:17 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D896B2059D;
        Sun, 13 Oct 2019 21:00:16 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        kuninori.morimoto.gx@renesas.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH 2/2] ASoC: simple-card: Add documentation for force-dpcm property
Date:   Sun, 13 Oct 2019 22:00:14 +0300
Message-Id: <20191013190014.32138-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013190014.32138-1-daniel.baluta@nxp.com>
References: <20191013190014.32138-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property can be global in which case all links created will be DPCM
or present in certian dai-link subnode in which case only that specific
link is forced to be DPCM.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 79954cd6e37b..15e6f5329857 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -63,6 +63,7 @@ Optional dai-link subnode properties:
 - mclk-fs             			: Multiplication factor between stream
 					  rate and codec mclk, applied only for
 					  the dai-link.
+- force-dpcm				: Indicates dai-link is always DPCM.
 
 For backward compatibility the frame-master and bitclock-master
 properties can be used as booleans in codec subnode to indicate if the
-- 
2.17.1

