Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085E7835FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbfHFP5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 11:57:55 -0400
Received: from vps.xff.cz ([195.181.215.36]:55402 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387493AbfHFP5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1565107071; bh=1WLK5mVFKFuv1g4gs40+VCmjvdPbojsyFq5tU/7xRNw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=En0Lsg9MSZMhN5LVrV5ajakQGazmxXH2790lmj21RVWwqGRKVUaYb2Ok/E+4f2sds
         +YclFbmClg3rpIYnCPF1DLeG8WuXXBlfhpYaloESxdumT7segy9d43Qilgvm/+pazg
         ceL5eHOb1ddah4PrChZZUG/4QKxZ+j1mzZBCrasg=
From:   megous@megous.com
To:     linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Ondrej Jirman <megous@megous.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 2/4] dt-bindings: display: hdmi-connector: Support DDC bus enable
Date:   Tue,  6 Aug 2019 17:57:41 +0200
Message-Id: <20190806155744.10263-3-megous@megous.com>
In-Reply-To: <20190806155744.10263-1-megous@megous.com>
References: <20190806155744.10263-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Some Allwinner SoC using boards (Orange Pi 3 for example) need to enable
on-board voltage shifting logic for the DDC bus using a gpio to be able
to access DDC bus. Use ddc-en-gpios property on the hdmi-connector to
model this.

Add binding documentation for optional ddc-en-gpios property.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/connector/hdmi-connector.txt     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt b/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
index 508aee461e0d..aeb07c4bd703 100644
--- a/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
+++ b/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
@@ -9,6 +9,7 @@ Optional properties:
 - label: a symbolic name for the connector
 - hpd-gpios: HPD GPIO number
 - ddc-i2c-bus: phandle link to the I2C controller used for DDC EDID probing
+- ddc-en-gpios: signal to enable DDC bus
 
 Required nodes:
 - Video port for HDMI input
-- 
2.22.0

