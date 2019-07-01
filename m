Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531C14FDB1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2019 20:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfFWSpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 14:45:24 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38707 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfFWSpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 14:45:23 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4AA39FF803;
        Sun, 23 Jun 2019 18:45:15 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 1/4] dt-bindings: iio/adc: Add a compatible string for JZ4770 SoC ADC
Date:   Sun, 23 Jun 2019 20:47:29 +0200
Message-Id: <20190623184732.5492-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the ADC controller present on
Ingenic JZ4770 SoC.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
index f01159f20d87..cd9048cf9dcf 100644
--- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible: Should be one of:
   * ingenic,jz4725b-adc
   * ingenic,jz4740-adc
+  * ingenic,jz4770-adc
 - reg: ADC controller registers location and length.
 - clocks: phandle to the SoC's ADC clock.
 - clock-names: Must be set to "adc".
-- 
2.22.0

