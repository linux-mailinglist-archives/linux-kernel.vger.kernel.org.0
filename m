Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0149174779
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 15:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgB2Otc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 09:49:32 -0500
Received: from mail.manjaro.org ([176.9.38.148]:38932 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgB2Otb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 09:49:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 581173C40D8B;
        Sat, 29 Feb 2020 15:49:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LUE0dUV5ZXet; Sat, 29 Feb 2020 15:49:28 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Alexis Ballier <aballier@gentoo.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Xie <nick@khadas.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Tobias Schramm <t.schramm@manjaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: Add doc for pine64 Pinebook Pro
Date:   Sat, 29 Feb 2020 15:48:16 +0100
Message-Id: <20200229144817.355678-2-t.schramm@manjaro.org>
In-Reply-To: <20200229144817.355678-1-t.schramm@manjaro.org>
References: <20200229144817.355678-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a compatible for the Pinebook Pro.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 874b0eaa2a75..482a0cbfb18a 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -402,6 +402,11 @@ properties:
           - const: phytec,rk3288-phycore-som
           - const: rockchip,rk3288
 
+      - description: Pine64 Pinebook Pro
+        items:
+          - const: pine64,pinebook-pro
+          - const: rockchip,rk3399
+
       - description: Pine64 Rock64
         items:
           - const: pine64,rock64
-- 
2.24.1

