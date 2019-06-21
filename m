Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEDA4F076
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 23:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfFUVWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 17:22:51 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41911 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 17:22:50 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 129BFFF806;
        Fri, 21 Jun 2019 21:22:46 +0000 (UTC)
Date:   Fri, 21 Jun 2019 23:22:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 5.3
Message-ID: <20190621212246.GA30172@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Still very few updates. It is mostly about removing DTC warnings by
switching the sckc to the proper bindings and converting the atmel
bindings to json-schema.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.3-dt

for you to fetch changes up to 271839b0a819cbb76ef3ce5c7237d6cb624b3eba:

  dt-bindings: arm: Convert Atmel board/soc bindings to json-schema (2019-06-20 11:13:52 +0200)

----------------------------------------------------------------
AT91 DT for 5.3

 - switch to new sckc bindings
 - convert soc bindings to json-schema

----------------------------------------------------------------
Alexandre Belloni (5):
      ARM: dts: at91sam9261ek: remove unused chosen nodes
      ARM: dts: at91: at91sam9x5: switch to new sckc bindings
      ARM: dts: at91: at91sam9g45: switch to new sckc bindings
      ARM: dts: at91: at91sam9rl: switch to new sckc bindings
      ARM: dts: at91: sama5d3: switch to new sckc bindings

Rob Herring (1):
      dt-bindings: arm: Convert Atmel board/soc bindings to json-schema

 .../devicetree/bindings/arm/atmel-at91.txt         |  73 -----------
 .../devicetree/bindings/arm/atmel-at91.yaml        | 134 +++++++++++++++++++++
 arch/arm/boot/dts/at91-wb50n.dtsi                  |   2 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |   8 --
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  25 +---
 arch/arm/boot/dts/at91sam9rl.dtsi                  |  25 +---
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  23 +---
 arch/arm/boot/dts/sama5d3.dtsi                     |  27 +----
 8 files changed, 148 insertions(+), 169 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.yaml

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
