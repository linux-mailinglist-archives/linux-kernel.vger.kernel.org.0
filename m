Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B27C042
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 13:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfGaLmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 07:42:07 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:37016 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfGaLmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:42:06 -0400
Received: from ramsan ([84.194.98.4])
        by albert.telenet-ops.be with bizsmtp
        id jPi32000L05gfCL06Pi30Y; Wed, 31 Jul 2019 13:42:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hsmzb-0008E1-7K; Wed, 31 Jul 2019 13:42:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hsmzb-00023x-6D; Wed, 31 Jul 2019 13:42:03 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] dt-bindings: arm-boards: Update pointer to ARM CPU bindings
Date:   Wed, 31 Jul 2019 13:42:01 +0200
Message-Id: <20190731114201.7884-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM CPU DT bindings were converted from plain text to YAML, but not
all referrers were updated.

Fixes: 672951cbd1b70a9e ("dt-bindings: arm: Convert cpu binding to json-schema")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
v2:
  - Add Acked-by.
---
 Documentation/devicetree/bindings/arm/arm-boards | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 6758ece324b1c259..b2a9f9f8430bacf4 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -199,7 +199,7 @@ The description for the board must include:
      A detailed description of the bindings used for "psci" nodes is present
      in the psci.yaml file.
    - a "cpus" node describing the available cores and their associated
-     "enable-method"s. For more details see cpus.txt file.
+     "enable-method"s. For more details see cpus.yaml file.
 
 Example:
 
-- 
2.17.1

