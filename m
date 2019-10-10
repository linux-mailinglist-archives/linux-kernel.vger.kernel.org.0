Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAAD3153
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 21:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfJJT0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 15:26:17 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:51124 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfJJT0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MwcU21sAN23PMIeSNVMb6B47OMp0NvPmhAUVkc8gq7A=; b=BC6mxSZ+07ih/TCqbztKjoZMwa
        UnrV2G1fRGkXOawuew8re13gyJPntX9QOIrUcqpKCw4Ct+y8df+wjsoBPTdu67N3neUXpVtGCSDUy
        /YPSwWU33jYTZZ/3JxX/UK8SOmypQtuSknxNvO5LemeUgyiaKj8XLCTT8CcOzNs3pWGM=;
Received: from p200300ccff13bb001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff13:bb00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iIe4e-0007Jq-Ec; Thu, 10 Oct 2019 21:26:11 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1iIe4e-0007GY-3y; Thu, 10 Oct 2019 21:26:08 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, marex@denx.de, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: add compatible string for Kobo Clara HD
Date:   Thu, 10 Oct 2019 21:23:55 +0200
Message-Id: <20191010192357.27884-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191010192357.27884-1-andreas@kemnade.info>
References: <20191010192357.27884-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a compatible string for the Kobo Clara HD eBook reader.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2: reordered, was 2/3
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7294ac36f4c0b..afa3bfeca0c08 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -148,6 +148,7 @@ properties:
         items:
           - enum:
               - fsl,imx6sll-evk
+              - kobo,clarahd
           - const: fsl,imx6sll
 
       - description: i.MX6SX based Boards
-- 
2.20.1

