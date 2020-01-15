Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8BCC13CD47
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 20:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgAOTmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 14:42:32 -0500
Received: from mailoutvs39.siol.net ([185.57.226.230]:43708 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726310AbgAOTmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:42:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 35DD652291C;
        Wed, 15 Jan 2020 20:42:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gsgDiaGgE7Zw; Wed, 15 Jan 2020 20:42:28 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E985F522899;
        Wed, 15 Jan 2020 20:42:27 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A614152291C;
        Wed, 15 Jan 2020 20:42:25 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: sunxi: add OrangePi 3 with eMMC
Date:   Wed, 15 Jan 2020 20:42:15 +0100
Message-Id: <20200115194216.173117-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115194216.173117-1-jernej.skrabec@siol.net>
References: <20200115194216.173117-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OrangePi 3 can optionally have eMMC. Add a compatible for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
index 327ce6730823..c1e447915c59 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -763,6 +763,11 @@ properties:
           - const: xunlong,orangepi-3
           - const: allwinner,sun50i-h6
=20
+      - description: Xunlong OrangePi 3 (with eMMC)
+        items:
+          - const: xunlong,orangepi-3-emmc
+          - const: allwinner,sun50i-h6
+
       - description: Xunlong OrangePi Lite
         items:
           - const: xunlong,orangepi-lite
--=20
2.24.1

