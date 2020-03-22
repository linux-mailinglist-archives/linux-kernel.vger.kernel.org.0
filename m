Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2A18E7AB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 09:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCVI5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 04:57:16 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:36875 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgCVI5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 04:57:15 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B8AE0200003;
        Sun, 22 Mar 2020 08:57:11 +0000 (UTC)
Date:   Sun, 22 Mar 2020 09:57:11 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: defconfig for 5.7
Message-ID: <20200322085711.GA208700@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

A single patch enabling the sama5d4 watchdog driver in
at91_dt_defconfig.

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.7-defconfig

for you to fetch changes up to 91d14ab8d913e798b3f68663ffc2e1f7dc8c4a8b:

  ARM: configs: at91: enable sama5d4 compatible watchdog (2020-02-12 12:29:22 +0100)

----------------------------------------------------------------
AT91 defconfig for 5.7

 - Add sama5d4 watchdog to at91_dt_defconfig as it is present on sam9x60

----------------------------------------------------------------
Eugen Hristev (1):
      ARM: configs: at91: enable sama5d4 compatible watchdog

 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
