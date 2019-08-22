Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62A098B26
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 08:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfHVGCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 02:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730576AbfHVGCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:02:51 -0400
Received: from localhost.localdomain (unknown [194.230.147.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B820233A1;
        Thu, 22 Aug 2019 06:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566453771;
        bh=JIhqcUM9It35GZ1DT2KSNI4eJjJ0/eIEsvqNON5bhB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tSB3ndQ/ki6pd/SHSODQv3ct2dT0GlV9ukz7golGQSPZyesnnUpw7+Fa/biCGFvsI
         kWO3K32uYuZKLtXMcJayAc5ohyhMaXUbHwTggzi9joz1ynYR5fKF7FaiX6VBDkoGoV
         9ua8yR+zZWnl9wRXVNmVXoIc91dMoMOBBTFbrHCY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v7 2/4] dt-bindings: eeprom: at25: Add Anvo ANV32E61W
Date:   Thu, 22 Aug 2019 08:02:36 +0200
Message-Id: <20190822060238.3887-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822060238.3887-1-krzk@kernel.org>
References: <20190822060238.3887-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for ANV32E61W 64kb Serial SPI non-volatile SRAM.
Although it is a SRAM device, it can be accessed through EEPROM
interface. At least until there is no proper SRAM driver support for
it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

Changes since v5:
1. None

Changes since v4:
1. Update commit msg.
---
 Documentation/devicetree/bindings/eeprom/at25.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
index b3bde97dc199..42577dd113dd 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.txt
+++ b/Documentation/devicetree/bindings/eeprom/at25.txt
@@ -3,6 +3,7 @@ EEPROMs (SPI) compatible with Atmel at25.
 Required properties:
 - compatible : Should be "<vendor>,<type>", and generic value "atmel,at25".
   Example "<vendor>,<type>" values:
+    "anvo,anv32e61w"
     "microchip,25lc040"
     "st,m95m02"
     "st,m95256"
-- 
2.17.1

