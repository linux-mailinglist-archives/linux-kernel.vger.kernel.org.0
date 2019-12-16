Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A62DA11F51E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 00:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLNX4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 18:56:11 -0500
Received: from node.akkea.ca ([192.155.83.177]:38606 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfLNX4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 18:56:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id C9C0E4E200E;
        Sat, 14 Dec 2019 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576367770; bh=l91r0YDEN+oe9jxf3D6wJpDm6U1PN8Ku0lGaSjCm2s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=E1iamzbfDFUgiQVjPZ5VUjG6MRahIpppFp2Gt/CcK2VlOBIhQP0Goa5ztQLQEu8sV
         9CEzEEufMBp4gv6YUv5XsJH+rZMwa0gAXSfOF0HPyIusv7ofiR13wL2+vX2kAfKRJI
         k4I7GPY8ilZjYP4sMjU7WRdf/FR6SDUSa9FT+1KQ=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id V3F5Ef6DWhwm; Sat, 14 Dec 2019 23:56:10 +0000 (UTC)
Received: from thinkpad-tablet.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 54F364E2003;
        Sat, 14 Dec 2019 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576367770; bh=l91r0YDEN+oe9jxf3D6wJpDm6U1PN8Ku0lGaSjCm2s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=E1iamzbfDFUgiQVjPZ5VUjG6MRahIpppFp2Gt/CcK2VlOBIhQP0Goa5ztQLQEu8sV
         9CEzEEufMBp4gv6YUv5XsJH+rZMwa0gAXSfOF0HPyIusv7ofiR13wL2+vX2kAfKRJI
         k4I7GPY8ilZjYP4sMjU7WRdf/FR6SDUSa9FT+1KQ=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 2/2] dt-bindings: sound: gtm601: add the broadmobi interface
Date:   Sat, 14 Dec 2019 15:55:50 -0800
Message-Id: <20191214235550.31257-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214235550.31257-1-angus@akkea.ca>
References: <20191214235550.31257-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadmobi BM818 uses a different sample rate and channels from the
option modem.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/gtm601.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
index 5efc8c068de0..efa32a486c4a 100644
--- a/Documentation/devicetree/bindings/sound/gtm601.txt
+++ b/Documentation/devicetree/bindings/sound/gtm601.txt
@@ -1,10 +1,16 @@
 GTM601 UMTS modem audio interface CODEC
 
-This device has no configuration interface. Sample rate is fixed - 8kHz.
+This device has no configuration interface. The sample rate and channels are
+based on the compatible string
+	"option,gtm601" = 8kHz mono
+	"broadmobi,bm818" = 48KHz stereo
 
 Required properties:
 
-  - compatible : "option,gtm601"
+  - compatible : one of
+	"option,gtm601"
+	"broadmobi,bm818"
+
 
 Example:
 
-- 
2.17.1

