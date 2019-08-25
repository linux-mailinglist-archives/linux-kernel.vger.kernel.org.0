Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC0C9C61A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 22:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfHYUcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 16:32:25 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:58945 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfHYUcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 16:32:25 -0400
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EA8E8200003;
        Sun, 25 Aug 2019 20:32:22 +0000 (UTC)
Date:   Sun, 25 Aug 2019 22:32:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: SoC for 5.4
Message-ID: <20190825203222.GA22800@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A non urgent fix for the generated header in mach-at91 and mostly
MAINTAINERS updates.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.4-soc

for you to fetch changes up to 2cb831e0f152e483ab797b44787a4ff426267fbc:

  mailmap: map old company name to new one @microchip.com (2019-08-23 21:53:40 +0200)

----------------------------------------------------------------
AT91 SoC for 5.4

 - MAINTAINERS updates
 - a generated headers parallel build fix

----------------------------------------------------------------
Masahiro Yamada (1):
      ARM: at91: move platform-specific asm-offset.h to arch/arm/mach-at91

Nicolas Ferre (3):
      MAINTAINERS: at91: Collect all pinctrl/gpio drivers in same entry
      MAINTAINERS: at91: remove the TC entry
      mailmap: map old company name to new one @microchip.com

 .mailmap                        |  1 +
 MAINTAINERS                     | 14 +-------------
 arch/arm/mach-at91/.gitignore   |  1 +
 arch/arm/mach-at91/Makefile     |  5 +++--
 arch/arm/mach-at91/pm_suspend.S |  2 +-
 5 files changed, 7 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/mach-at91/.gitignore

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
