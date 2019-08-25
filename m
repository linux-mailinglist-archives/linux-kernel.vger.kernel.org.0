Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13A69C616
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 22:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfHYU0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 16:26:46 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54403 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfHYU0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 16:26:45 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 2DD261C0003;
        Sun, 25 Aug 2019 20:26:43 +0000 (UTC)
Date:   Sun, 25 Aug 2019 22:26:42 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 5.4
Message-ID: <20190825202642.GA18853@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few DT changes affecting only the style but not the DTB output. There
may be some late DT changes a bit later (but hopefully not too late).

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.4-dt

for you to fetch changes up to bb3e9c767c6134a5761470038e8c75cdb6f04867:

  ARM: dts: at91: at91sam9x5dm.dtsi: Style cleanup (2019-08-21 18:41:36 +0200)

----------------------------------------------------------------
AT91 DT for 5.4

 - style cleanup for at91sam9x5 based boards
 - avoid colliding node and property names

----------------------------------------------------------------
Rob Herring (1):
      ARM: dts: at91: Avoid colliding 'display' node and property names

Uwe Kleine-König (10):
      dt-bindings: add vendor prefix "acme" for "Acme Systems srl"
      ARM: dts: at91: Add label for sam9x5's internal RTC
      ARM: dts: at91: ariag25: Style cleanup
      ARM: dts: at91: ariettag25: style cleanup
      ARM: dts: at91: cosino: Style cleanup
      ARM: dts: at91: kizboxmini: Style cleanup
      ARM: dts: at91: at91sam9g15: Style cleanup
      ARM: dts: at91: at91sam9xx5ek: Style cleanup
      ARM: dts: at91: at91sam9x5_lcd.dtsi: Style cleanup
      ARM: dts: at91: at91sam9x5dm.dtsi: Style cleanup

 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm/boot/dts/at91-ariag25.dts                 | 255 ++++++++++----------
 arch/arm/boot/dts/at91-ariettag25.dts              | 100 ++++----
 arch/arm/boot/dts/at91-cosino.dtsi                 | 203 ++++++++--------
 arch/arm/boot/dts/at91-cosino_mega2560.dts         |  93 ++++----
 arch/arm/boot/dts/at91-kizboxmini.dts              | 179 +++++++-------
 arch/arm/boot/dts/at91sam9261ek.dts                |   2 +-
 arch/arm/boot/dts/at91sam9263ek.dts                |   2 +-
 arch/arm/boot/dts/at91sam9g15.dtsi                 |  28 +--
 arch/arm/boot/dts/at91sam9g15ek.dts                |  12 +-
 arch/arm/boot/dts/at91sam9g25ek.dts                |  89 ++++---
 arch/arm/boot/dts/at91sam9g35ek.dts                |  22 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |   2 +-
 arch/arm/boot/dts/at91sam9rlek.dts                 |   2 +-
 arch/arm/boot/dts/at91sam9x25ek.dts                |  36 ++-
 arch/arm/boot/dts/at91sam9x35ek.dts                |  43 ++--
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   2 +-
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi              | 194 +++++++--------
 arch/arm/boot/dts/at91sam9x5dm.dtsi                |  86 ++++---
 arch/arm/boot/dts/at91sam9x5ek.dtsi                | 265 ++++++++++-----------
 20 files changed, 785 insertions(+), 832 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
