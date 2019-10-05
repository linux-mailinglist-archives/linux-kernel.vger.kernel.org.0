Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01DC9CCA06
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfJENKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 09:10:08 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:36646 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbfJENKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 09:10:07 -0400
Received: from ipservice-092-217-086-168.092.217.pools.vodafone-ip.de ([92.217.86.168] helo=reykholt.kaiser.cx)
        by viti.kaiser.cx with esmtpa (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1iGjou-0003SB-BX; Sat, 05 Oct 2019 15:10:00 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexander Shiyan <shc_work@mail.ru>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 2/2] dt-bindings: display: clps711x-fb: fix native-mode setting
Date:   Sat,  5 Oct 2019 15:09:21 +0200
Message-Id: <20191005130921.12874-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191005130921.12874-1-martin@kaiser.cx>
References: <20190918193853.25689-1-martin@kaiser.cx>
 <20191005130921.12874-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the native-mode setting inside the display-timing node. Outside of
display-timing, it is ignored.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
changes in v2
 fix the example in this binding as well

 Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt b/Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt
index b0e506610400..0ab5f0663611 100644
--- a/Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt
+++ b/Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt
@@ -27,11 +27,11 @@ Example:
 
 	display: display {
 		model = "320x240x4";
-		native-mode = <&timing0>;
 		bits-per-pixel = <4>;
 		ac-prescale = <17>;
 
 		display-timings {
+			native-mode = <&timing0>;
 			timing0: 320x240 {
 				hactive = <320>;
 				hback-porch = <0>;
-- 
2.11.0

