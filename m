Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1CB617A6ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 15:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCEN7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 08:59:46 -0500
Received: from inva021.nxp.com ([92.121.34.21]:49438 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgCEN7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:59:44 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D7F7200715;
        Thu,  5 Mar 2020 14:59:42 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C631200713;
        Thu,  5 Mar 2020 14:59:42 +0100 (CET)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D08F62059D;
        Thu,  5 Mar 2020 14:59:41 +0100 (CET)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: crypto: caam: use generic node name
Date:   Thu,  5 Mar 2020 15:59:07 +0200
Message-Id: <20200305135909.8180-4-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200305135909.8180-1-horia.geanta@nxp.com>
References: <20200305135909.8180-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6UL example uses a specific node name for the crypto node.
Let's fix it so we avoid this propagating further.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
index 2fe245ca816a..8f359f473ada 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
@@ -138,7 +138,7 @@ iMX6QDL/SX requires four clocks
 
 iMX6UL does only require three clocks
 
-	crypto: caam@2140000 {
+	crypto: crypto@2140000 {
 		compatible = "fsl,sec-v4.0";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.17.1

