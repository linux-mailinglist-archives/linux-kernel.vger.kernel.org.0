Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E6AB49C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfIQIrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:47:46 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47524 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbfIQIrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:47:46 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8pK-0005ZY-GI; Tue, 17 Sep 2019 10:27:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 11/13] dt-bindings: document PX30 usb2phy General Register Files
Date:   Tue, 17 Sep 2019 10:26:57 +0200
Message-Id: <20190917082659.25549-11-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917082659.25549-1-heiko@sntech.de>
References: <20190917082659.25549-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the separate General Register Files contains the registers for
controlling the usb2phy, so add the necessary binding compatible for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
index 46e27cd69f18..d7debec26ba4 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
@@ -30,6 +30,7 @@ Required Properties:
 - compatible: SGRF should be one of the following
    - "rockchip,rk3288-sgrf", "syscon": for rk3288
 - compatible: USB2PHYGRF should be one of the followings
+   - "rockchip,px30-usb2phy-grf", "syscon": for px30
    - "rockchip,rk3328-usb2phy-grf", "syscon": for rk3328
 - compatible: USBGRF should be one of the following
    - "rockchip,rv1108-usbgrf", "syscon": for rv1108
-- 
2.20.1

