Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910571039E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 13:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfKTMTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 07:19:00 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:26632 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbfKTMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574252338;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=8bNbmxi3KvdKXR9c7NN+7STy6Idi0+mrpOteADbs+zU=;
        b=ksg8vnZvoRu1Z4YzarAS7KrsqLlU2qCgZ0rvZZY9Nmj7xNeppUg11LNW9UxGHCYZ/f
        0v4klL6NuLiubehf8/IMH6IPrOLsAYJxapx3eYFFXeo8nJawNCuZ5whcuAGP7IWmatNz
        KSUsVIn2xN5nt2ZykdwQLbH6CIlI0gRBfQRRMDsOS9Rg36jgo8c9Kv1hnT+nPkzc8G17
        GZKTtRduErbupDoIvkm8qLP6rOtgIxxdGSwYI5DdrlB0VC4f3Rpn2+wua7cMUgnJHmGT
        f6nixXe3fy6h39+48qwRd+53xFc6HY2Z/rKbMBAExByAnKVy5obkHZqZppwUO2PbdIMa
        7SnQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8Lvtn4="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAKCIvsCJ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Nov 2019 13:18:57 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/3] dt-bindings: vendor-prefixes: Add "calaosystems" for CALAO Systems SAS
Date:   Wed, 20 Nov 2019 13:17:19 +0100
Message-Id: <20191120121720.72845-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120121720.72845-1-stephan@gerhold.net>
References: <20191120121720.72845-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Snowball SBC supported by arch/arm/boot/dts/ste-snowball.dts
was made by CALAO Systems and uses the "calaosystems,snowball-a9500"
compatible. Prepare for documenting the compatible by adding
"calaosystems" to the list of vendor prefixes.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c9b0bab8ed23..cfc3376309b9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -157,6 +157,8 @@ patternProperties:
     description: B&R Industrial Automation GmbH
   "^bticino,.*":
     description: Bticino International
+  "^calaosystems,.*":
+    description: CALAO Systems SAS
   "^calxeda,.*":
     description: Calxeda
   "^capella,.*":
-- 
2.24.0

