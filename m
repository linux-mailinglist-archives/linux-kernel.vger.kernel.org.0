Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 367F6157D02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 15:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgBJOEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 09:04:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgBJOEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:04:33 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31925206D6;
        Mon, 10 Feb 2020 14:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581343472;
        bh=7fRbMVB8UtpzAcwDa2C7GH4fqkKZBT/U7iNhVYXR1BE=;
        h=From:To:Cc:Subject:Date:From;
        b=tdLgfvi+MwEhD3EQ+OniSWgk5rxOMfpVefeowW9T4nkdFrXEhdP6oXDnqCoBEBuYx
         ObgGrQX7aD137yvFDvLp/DvlFnPPR41dotnWtS4p66QYZc61/ci3ujJXjRHqXebhvT
         PYQIRQ1cI6OMpIXLdo/ewczjp9CCuYx9d6Oj11n8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH] dt-bindings: usb: exynos-usb: Document clock names for DWC3 bindings
Date:   Mon, 10 Feb 2020 15:04:16 +0100
Message-Id: <1581343456-18900-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Exynos DWC3 driver expects certain clock names, depending on used
compatible.  Document this explicitly in the bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/usb/exynos-usb.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index 66c394f9e11f..6aae1544f240 100644
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
@@ -78,7 +78,14 @@ Required properties:
  - ranges: allows valid 1:1 translation between child's address space and
 	   parent's address space
  - clocks: Clock IDs array as required by the controller.
- - clock-names: names of clocks correseponding to IDs in the clock property
+ - clock-names: Names of clocks corresponding to IDs in the clock property.
+                Following clock names shall be provided for different
+                compatibles:
+                 - samsung,exynos5250-dwusb3: "usbdrd30",
+                 - samsung,exynos5433-dwusb3: "aclk", "susp_clk", "pipe_pclk",
+                                              "phyclk",
+                 - samsung,exynos7-dwusb3: "usbdrd30", "usbdrd30_susp_clk",
+                                           "usbdrd30_axius_clk"
  - vdd10-supply: 1.0V powr supply
  - vdd33-supply: 3.0V/3.3V power supply
 
-- 
2.7.4

