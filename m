Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C981909BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 22:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfHPUy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 16:54:29 -0400
Received: from mailoutvs60.siol.net ([185.57.226.251]:38626 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727667AbfHPUy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:54:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 211A8522353;
        Fri, 16 Aug 2019 22:54:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7DONUwvlBGav; Fri, 16 Aug 2019 22:54:25 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id D9B1A52227B;
        Fri, 16 Aug 2019 22:54:25 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 9C810522331;
        Fri, 16 Aug 2019 22:54:23 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        wens@csie.org
Cc:     jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: sunxi: Add compatible for Tanix TX6 board
Date:   Fri, 16 Aug 2019 22:53:41 +0200
Message-Id: <20190816205342.29552-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190816205342.29552-1-jernej.skrabec@siol.net>
References: <20190816205342.29552-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new Oranth Tanix TX6 board compatible string to the bindings
documentation.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
index 000a00d12d6a..6afeb1be3a44 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -671,6 +671,11 @@ properties:
           - const: sinlinx,sina33
           - const: allwinner,sun8i-a33
=20
+      - description: Tanix TX6
+        items:
+          - const: oranth,tanix-tx6
+          - const: allwinner,sun50i-h6
+
       - description: TBS A711 Tablet
         items:
           - const: tbs-biometrics,a711
--=20
2.22.1

