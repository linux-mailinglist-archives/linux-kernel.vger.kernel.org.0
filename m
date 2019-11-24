Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8947A1084DB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2019 20:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKXT6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Nov 2019 14:58:36 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:21127 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfKXT6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 14:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574625511;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=iSO7OSFSi9+a8PsQWpqFjY4N0FXkjXOq4T1wZeOcwIw=;
        b=a1obUzXYiQfoeEOVesiLnIjpVzBtfwUnHTxWkePbYfFJ5xBmZlZcGt8kLKtEjltLnY
        s4olsUiS9heZp5Pru9ZtycQPDgKmHeb49kYIspzEUAEVK8Xnm6RRCX2cisWWRwe3C08k
        fahAFaAk1kBdpdKxB5cGGHWTwQFSrGIOPQAOUQXpkhA/sVTg6bRamK013QItwLk17ef0
        C4OfvS7/Lh9QswvxguzPKqhBkGmLPMnOCYBydoOHJ4TEqoQeB5W5xWajxz2XjT/OMwiX
        9XmiV/clFBTP+wW7FJu1BnCocecr5xzfVja8sFk/QUANGxlPlhMPzi42wCDk8k92/n7q
        rh2A==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7IOGU5qzCBwY93scQxp"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAOJwRCTn
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 24 Nov 2019 20:58:27 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] ARM: dts: ux500: Add "simple-bus" compatible to soc node
Date:   Sun, 24 Nov 2019 20:57:28 +0100
Message-Id: <20191124195728.32226-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "soc" node in the Ux500 device tree does not need any special
handling - it is just a simple I/O bus that can be accessed without
additional configuration.

Therefore we can additionally describe it as compatible with "simple-bus".
This can be used by platforms to probe devices under the soc node without
special handling for our custom "stericsson,db8500" compatible
(e.g. in U-Boot).

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index bda454d12150..51ac65b78be0 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -93,7 +93,7 @@
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "stericsson,db8500";
+		compatible = "stericsson,db8500", "simple-bus";
 		interrupt-parent = <&intc>;
 		ranges;
 
-- 
2.24.0

