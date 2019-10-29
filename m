Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 472A5E90B3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 21:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfJ2URq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 16:17:46 -0400
Received: from vps.xff.cz ([195.181.215.36]:37728 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfJ2URp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1572380264; bh=wW5JFIsIsJu0qPYpAaTlE7obxGziUNClJYFMYvv4v04=;
        h=From:To:Cc:Subject:Date:From;
        b=Dj0yQWOTPdD26/mFn0ZEgxk2VXGGM6MomYqE+KAtPCZjp2/fHu+uNncetcslpRtrj
         +06T0cawiwc4SOgkF32JWGQOE4Q5KV0T2QLSPJqy4j3qmbwSy6GauIIdPBqsaP52HE
         GdIxDfnxZqnmv74Jw8xQVxF4znG7RaGAPPwCc1wI=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ondrej Jirman <megous@megous.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] Add USB 3 support for H6 and Orange Pi 3
Date:   Tue, 29 Oct 2019 21:17:37 +0100
Message-Id: <20191029201741.3820913-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements USB 3 support for Xunlong Orange Pi 3 board.

This is a re-hash of the Icenowy's earlier USB3 work[1] without code
that caused controversy previously. Orange Pi 3 board doesn't need vbus
supply to be dynamically enabled, so that code is not needed to support
USB3 on this board.

Most of patches are already reviewed. I've converted dt-bindings to yaml
format, and added the Orange Pi 3 board modifications.

Hopefully with this series we can get USB3 support into mainline for
Orange Pi 3, and build on it later to support more boards, where
supporting them is more complicated.

Please take a look.

thank you and regards,
  Ondrej Jirman

[1] https://lore.kernel.org/patchwork/patch/1058919/

Changes in v3:
- Added DT reviewed-by tag
- more sun50i / H6 name clarifications (Kconfig, ...)
- dropped USB_COMMON and linux/usb/of.h

Changes in v2:
- Added Maxime's Acked-By's
- Fixed title of DT bindings file

Changes since Icenowy v5 series:
- use earlier patches that did not include VBUS regulator/connector
  code
- converted dt bindings to yaml
- added patch to enable usb3 on Orange Pi 3

Icenowy Zheng (2):
  phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
  arm64: dts: allwinner: h6: add USB3 device nodes

Ondrej Jirman (2):
  dt-bindings: Add bindings for USB3 phy on Allwinner H6
  arm64: dts: allwinner: orange-pi-3: Enable USB 3.0 host support

 .../phy/allwinner,sun50i-h6-usb3-phy.yaml     |  47 +++++
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |   8 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  32 +++
 drivers/phy/allwinner/Kconfig                 |  11 +
 drivers/phy/allwinner/Makefile                |   1 +
 drivers/phy/allwinner/phy-sun50i-usb3.c       | 190 ++++++++++++++++++
 6 files changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
 create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c

-- 
2.23.0

