Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5551484AD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 12:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbgAXLt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 06:49:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57916 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733064AbgAXLt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:49:26 -0500
Received: from localhost.localdomain (p200300CB87166A009DA8F7B8A96C6547.dip0.t-ipconnect.de [IPv6:2003:cb:8716:6a00:9da8:f7b8:a96c:6547])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4D5F229466F;
        Fri, 24 Jan 2020 11:49:25 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
Subject: [PATCH] dt-bindings: fix compilation error of the example in intel,lgm-emmc-phy.yaml
Date:   Fri, 24 Jan 2020 12:49:14 +0100
Message-Id: <20200124114914.27065-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running:
export DT_SCHEMA_FILES=Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
'make dt_binding_check'

gives a compilation error. This is because in the example there
is the label 'emmc-phy' but labels are not allowed to have '-' sing.
Replace the '-' with '_' to fix the error.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
index ff7959c21af0..0de6b0f128b8 100644
--- a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
@@ -46,7 +46,7 @@ examples:
       compatible = "intel,lgm-syscon", "syscon";
       reg = <0xe0200000 0x100>;
 
-      emmc-phy: emmc-phy@a8 {
+      emmc_phy: emmc-phy@a8 {
         compatible = "intel,lgm-emmc-phy";
         reg = <0x00a8 0x10>;
         clocks = <&emmc>;
-- 
2.17.1

