Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87755B8F50
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 13:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438326AbfITLwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 07:52:31 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:48852 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438309AbfITLwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 07:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1568980347; x=1571572347;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mfFBMMfelPcYt0HozABPa7ZrKOpTUktgFSot938sgWs=;
        b=R2H94MLTZNypuq+uJsQh0bNajJY5p2BqcJiV1n8TQwNh76MaWNNSesemEjR1ef90
        4qf8g0S/nmixIfae/jQzx3Za4ubcd5R5oLdAS/M8+nEUarVZKuk/Zrf2V4H0Optw
        vs0pu2sdxvYKKiI3k/zUQB7kWobGTo+jlXQz0iAUrjA=;
X-AuditID: c39127d2-e31ff70000001af2-9c-5d84bd7a3605
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A3.19.06898.A7DB48D5; Fri, 20 Sep 2019 13:52:26 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019092013522631-76272 ;
          Fri, 20 Sep 2019 13:52:26 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Andrew Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-imx@nxp.com, Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH v2 2/2] dt-bindings: arm: fsl: Add PHYTEC i.MX6 devicetree bindings
Date:   Fri, 20 Sep 2019 13:52:26 +0200
Message-Id: <1568980346-385840-2-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568980346-385840-1-git-send-email-s.riedmueller@phytec.de>
References: <1568980346-385840-1-git-send-email-s.riedmueller@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 20.09.2019 13:52:26,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 20.09.2019 13:52:26,
        Serialize complete at 20.09.2019 13:52:26
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWyRoCBS7dqb0uswfpJZhbNHbYW84+cY7V4
        eNXfYtPja6wWXb9WMltc3jWHzeJuSyerxdLrF5ksWvceYbf4u30Ti8WLLeIO3B5r5q1h9Ng5
        6y67x6ZVnWwed67tYfPYvKTeY+O7HUwe/X8NPD5vkgvgiOKySUnNySxLLdK3S+DK+DF/BVvB
        Z7GK/zc3sDcwThToYuTkkBAwkZi99R5bFyMXh5DADkaJ+fePMkI45xgl3l/bxQxSxSZgJLFg
        WiMTiC0ioCExpesxO0gRs8BUZonGP0tZQRLCAsES09b/AitiEVCVWNPWwgZi8wp4SPw4dYoV
        Yp2cxM1znWBDOQU8Jd5fX8wOYgsB1TQdOsUCMlRCoJFJYsWmbcwQDUISpxefZZ7AyLeAkWEV
        o1BuZnJ2alFmtl5BRmVJarJeSuomRmCgHp6ofmkHY98cj0OMTByMhxglOJiVRHjnmDbFCvGm
        JFZWpRblxxeV5qQWH2KU5mBREufdwFsSJiSQnliSmp2aWpBaBJNl4uCUamDsefHz9ro8NbFl
        Z4NCrHYy2i7qSX/Is6VRdefnpIel3t1PZAsrngUr6CZFd4f80PEunv786NE+mbd3Hd+oVPq3
        zlnaVHEh8l6506YXL6zLl92IS9hbMLN88duqPCedzGntr6YULzoTvN7od7RO+tvN537tSW9h
        FOzxrJzptkJg1orEr70/j69TYinOSDTUYi4qTgQAW8AidEICAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for i.MX6 based phyCORE-i.MX6, phyBOARD-Mira and
phyFLEX-i.MX6.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
Changes in v2:
 - Use seperate description for each board instead of squashing them into
   the standard board.
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index c926ff6eac67..7dbb45cebb86 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -116,6 +116,21 @@ properties:
               - technologic,imx6q-ts7970
           - const: fsl,imx6q
 
+      - description: i.MX6Q PHYTEC phyBOARD-Mira
+        items:
+          - enum:
+              - phytec,imx6q-pbac06-emmc  # PHYTEC phyBOARD-Mira eMMC RDK
+              - phytec,imx6q-pbac06-nand  # PHYTEC phyBOARD-Mira NAND RDK
+          - const: phytec,imx6q-pbac06    # PHYTEC phyBOARD-Mira
+          - const: phytec,imx6qdl-pcm058  # PHYTEC phyCORE-i.MX6
+          - const: fsl,imx6q
+
+      - description: i.MX6Q PHYTEC phyFLEX-i.MX6
+        items:
+          - const: phytec,imx6q-pbab01    # PHYTEC phyFLEX carrier board
+          - const: phytec,imx6q-pfla02    # PHYTEC phyFLEX-i.MX6 Quad
+          - const: fsl,imx6q
+
       - description: i.MX6QP based Boards
         items:
           - enum:
@@ -123,6 +138,13 @@ properties:
               - fsl,imx6qp-sabresd        # i.MX6 Quad Plus SABRE Smart Device Board
           - const: fsl,imx6qp
 
+      - description: i.MX6QP PHYTEC phyBOARD-Mira
+        items:
+          - const: phytec,imx6qp-pbac06-nand
+          - const: phytec,imx6qp-pbac06   # PHYTEC phyBOARD-Mira
+          - const: phytec,imx6qdl-pcm058  # PHYTEC phyCORE-i.MX6
+          - const: fsl,imx6qp
+
       - description: i.MX6DL based Boards
         items:
           - enum:
@@ -138,6 +160,21 @@ properties:
               - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
           - const: fsl,imx6dl
 
+      - description: i.MX6DL PHYTEC phyBOARD-Mira
+        items:
+          - enum:
+              - phytec,imx6dl-pbac06-emmc # PHYTEC phyBOARD-Mira eMMC RDK
+              - phytec,imx6dl-pbac06-nand # PHYTEC phyBOARD-Mira NAND RDK
+          - const: phytec,imx6dl-pbac06   # PHYTEC phyBOARD-Mira
+          - const: phytec,imx6qdl-pcm058  # PHYTEC phyCORE-i.MX6
+          - const: fsl,imx6dl
+
+      - description: i.MX6DL PHYTEC phyFLEX-i.MX6
+        items:
+          - const: phytec,imx6dl-pbab01   # PHYTEC phyFLEX carrier board
+          - const: phytec,imx6dl-pfla02   # PHYTEC phyFLEX-i.MX6 Quad
+          - const: fsl,imx6dl
+
       - description: i.MX6SL based Boards
         items:
           - enum:
-- 
2.7.4

