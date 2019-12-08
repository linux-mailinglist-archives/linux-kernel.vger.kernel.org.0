Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4318A116279
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2019 15:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfLHOz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 09:55:29 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33338 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfLHOz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:55:28 -0500
Received: from muedsl-82-207-238-043.citykom.de ([82.207.238.43] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1idxy0-00043q-Jl; Sun, 08 Dec 2019 15:55:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 1/3] dt-bindings: gpu: mali-bifrost: Add Rockchip PX30
Date:   Sun,  8 Dec 2019 15:55:06 +0100
Message-Id: <20191208145508.3124-1-heiko@sntech.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Define a compatible string for the Mali Bifrost GPU found in
Rockchip's PX30 SoCs.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 0c426e371e71..4ea6a8789699 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - amlogic,meson-g12a-mali
           - realtek,rtd1619-mali
+          - rockchip,px30-mali
       - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
 
   reg:
-- 
2.24.0

