Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E394F179AFC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 22:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbgCDVbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 16:31:07 -0500
Received: from mail.manjaro.org ([176.9.38.148]:48192 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDVbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:31:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 9C0823701125;
        Wed,  4 Mar 2020 22:31:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fkagLefmcj9V; Wed,  4 Mar 2020 22:31:03 +0100 (CET)
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
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Emmanuel Vadot <manu@freebsd.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: Add doc for Pine64 Pinebook Pro
Date:   Wed,  4 Mar 2020 22:30:22 +0100
Message-Id: <20200304213023.689983-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Vadot <manu@freebsd.org>

Add a compatible for Pine64 Pinebook Pro

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 874b0eaa2a75..17f0ab0b8832 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -415,6 +415,11 @@ properties:
           - const: pine64,rockpro64
           - const: rockchip,rk3399
 
+      - description: Pine64 PinebookPro
+        items:
+          - const: pine64,pinebook-pro
+          - const: rockchip,rk3399
+
       - description: Radxa Rock
         items:
           - const: radxa,rock
-- 
2.24.1

