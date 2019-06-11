Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97EE3CDF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 16:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391514AbfFKOF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 10:05:28 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55769 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390059AbfFKOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:05:03 -0400
Received: from [167.98.27.226] (helo=happy.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hahOV-0003vU-Ml; Tue, 11 Jun 2019 15:04:59 +0100
From:   Michael Drake <michael.drake@codethink.co.uk>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Drake <michael.drake@codethink.co.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
Subject: [PATCH v1 10/11] dt-bindings: display/bridge: Add config property for ti949
Date:   Tue, 11 Jun 2019 15:04:11 +0100
Message-Id: <20190611140412.32151-11-michael.drake@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611140412.32151-1-michael.drake@codethink.co.uk>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config property can be used to provide an array of
register addresses and values to be written to configure
the device for the board.

Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Nate Case <ncase@tesla.com>
---
 .../bindings/display/bridge/ti,ds90ub949.txt        | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt
index 3ba3897d5e81..b1e38d732f17 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt
+++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt
@@ -12,6 +12,8 @@ Required properties:
 Optional properties:
 
 - regulators: List of regulator name strings to enable for operation of device.
+- config: List of <register address>,<value> pairs to be set to configure
+  device on powerup.  The register addresses and values are 8bit.
 
 Example
 -------
@@ -21,4 +23,15 @@ ti949: ds90ub949@0 {
 
 	regulators: "vcc",
 	            "vcc_hdmi";
+	config:
+	        /* GPIO0 is an output with remote value */
+	        <0x0D>, <0x25>,
+	        /* GPIO3 is an input for XRES */
+	        <0x0F>, <0x03>,
+	        /* GPIO2 is an input for backlight PWM */
+	        <0x0E>, <0x30>,
+	        /* Enables forward channel I2C pass through */
+	        <0x17>, <0x9e>,
+	        /* Enables PORT1 registers I2C access */
+	        <0x1E>, <0x04>;
 };
-- 
2.20.1

