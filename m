Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D53126F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 22:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfLSVKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 16:10:09 -0500
Received: from node.akkea.ca ([192.155.83.177]:35444 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfLSVKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:10:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 0CD6D4E2006;
        Thu, 19 Dec 2019 21:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576789802; bh=l91r0YDEN+oe9jxf3D6wJpDm6U1PN8Ku0lGaSjCm2s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kKyLSAXL9WXcCaj7tecU6Rnw6SLgMpLvZWifvwRl8R2TWaqu58nuDuO9MGLWQ8cZu
         ODW1yTOzmP5d/pWekQfNsZP+BQME+4lGv1cqagySyIAI80ECVVLRgWYB+/mhVFvvlh
         udmdQIHVqFHb33ZiEThMpFGc5spfm1uONZihw5pk=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lT-jJpG9j64k; Thu, 19 Dec 2019 21:10:01 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 906254E200E;
        Thu, 19 Dec 2019 21:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576789801; bh=l91r0YDEN+oe9jxf3D6wJpDm6U1PN8Ku0lGaSjCm2s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HOlRWkeR3xYnbjNyjFf6ded9lgCi9Q7odWr5GnzBHjKMbLan+8opD04SPESwIGp/Y
         DrPAFmpVWhm2uKN6GPJNz5iEk4C3etcSoO1ZCJCjs+Kd1QfPK1K9i8wXCsobrN/ALt
         wGu1n6kPN6pdieQSh5QEGUgPSQnrvDGGCRnA3jeU=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     broonie@kernel.org
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v3 2/2] dt-bindings: sound: gtm601: add the broadmobi interface
Date:   Thu, 19 Dec 2019 13:09:44 -0800
Message-Id: <20191219210944.18256-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219210944.18256-1-angus@akkea.ca>
References: <20191219210944.18256-1-angus@akkea.ca>
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

