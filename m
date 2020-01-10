Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D277013707C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 16:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgAJPAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 10:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgAJPAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:00:04 -0500
Received: from ziggy.de (unknown [95.169.227.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F8620721;
        Fri, 10 Jan 2020 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578668404;
        bh=uEFWL8Sp0xQJUtMRMWMVwcDeHzR9cLPTg7JzfnCCzmc=;
        h=From:To:Cc:Subject:Date:From;
        b=lyIoNDR04h6TwzT8PpJpApOSLC6PKjoSIeo/vkcNB0+YtRsOnbLqZiVEwDAclxzJO
         DSQnte96xky5o4rWq10SZZohQx3tFDPBM2LV2QSlZcTaWMKabCkMEM6PLRWqIcEWPI
         dUu5Zl1X6molO3iwqX6F97nF1GlQguu1zdwbnpts=
From:   matthias.bgg@kernel.org
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: mfd: mediatek: Add MT6397 Pin Controller
Date:   Fri, 10 Jan 2020 15:59:51 +0100
Message-Id: <20200110145952.9720-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The MT6397 mfd includes a pin controller. Add binding
a description for it.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

---

 Documentation/devicetree/bindings/mfd/mt6397.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index a9b105ac00a8..ce22fca9d48b 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -54,6 +54,11 @@ Optional subnodes:
 		- compatible: "mediatek,mt6323-pwrc"
 	For details, see ../power/reset/mt6323-poweroff.txt
 
+- pin-controller
+	Required properties:
+		- compatible: "mediatek,mt6397-pinctrl"
+	For details, see ../pinctrl/pinctrl-mt65xx.txt
+
 Example:
 	pwrap: pwrap@1000f000 {
 		compatible = "mediatek,mt8135-pwrap";
-- 
2.24.0

