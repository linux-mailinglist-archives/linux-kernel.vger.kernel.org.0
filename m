Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9785147F17
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 11:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgAXK6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 05:58:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57392 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgAXK6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:58:03 -0500
Received: from localhost.localdomain (p200300CB87166A009DA8F7B8A96C6547.dip0.t-ipconnect.de [IPv6:2003:cb:8716:6a00:9da8:f7b8:a96c:6547])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8D520293601;
        Fri, 24 Jan 2020 10:58:01 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
Subject: [PATCH] dt-bindings: fix compilation error of the example in marvell,mmp3-hsic-phy.yaml
Date:   Fri, 24 Jan 2020 11:57:53 +0100
Message-Id: <20200124105753.15976-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running `make dt_binging_check`, gives the error:

DTC     Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.example.dt.yaml
Error: Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.example.dts:20.41-42 syntax error
FATAL ERROR: Unable to parse input tree

This is because the example uses the macro GPIO_ACTIVE_HIGH which
is defined in gpio.h but the include of this header is missing.
Add the include to fix the error.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
index 7917a95cda78..5ab436189f3b 100644
--- a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
@@ -33,6 +33,7 @@ required:
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     hsic-phy@f0001800 {
             compatible = "marvell,mmp3-hsic-phy";
             reg = <0xf0001800 0x40>;
-- 
2.17.1

