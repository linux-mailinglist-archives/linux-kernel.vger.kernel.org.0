Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82784104325
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 19:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfKTSTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 13:19:51 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:23457 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfKTSTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574273988;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=gXkh0esBwT/dyH0bN+vrTGIOZ5B8ydk2eOUXb6B8DMg=;
        b=j4Vh50/tqvROXFuPUNBdY2qzTKi1rnq0YUm2wGghUXHaDBF5nlvb7U+7jkOhfwGynk
        x8Yve7ybpLCXcGF9jwFl/+tR/HC/6+0nGwTFuu5NoS3K5PHY4ymHXpVbEzVXF93eow17
        qPQjJzBiYNWOXS8jXcjY8dzNid6i1Hg5QFj80ZIO7ffmB9ChjHUeocU/DOXg5IoRZoVc
        Lt3RCih1AqyVvdbDEMc02k2KP0AK6CE1rQhNqcLNl22EcvbWPW9ItQhQfBqiNXoUFO1k
        nh6oZXlcoJfgJC59rXtFNTqMvwV7WAO/swti0OMnpQ/jE/IP/bCIMQMyf8tu6ZwAyfFA
        A2KQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8Lvtn4="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAKIJmvAa
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Nov 2019 19:19:48 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 3/4] dt-bindings: vendor-prefixes: Add "calaosystems" for CALAO Systems SAS
Date:   Wed, 20 Nov 2019 19:18:56 +0100
Message-Id: <20191120181857.97174-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120181857.97174-1-stephan@gerhold.net>
References: <20191120181857.97174-1-stephan@gerhold.net>
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
Changes in v2: none
v1: https://lore.kernel.org/linux-devicetree/20191120121720.72845-2-stephan@gerhold.net/
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 490b5cc6b8e6..b72af2e11b73 100644
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

