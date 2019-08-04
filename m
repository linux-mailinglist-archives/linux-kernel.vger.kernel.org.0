Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F5280CBC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2019 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfHDVau convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 4 Aug 2019 17:30:50 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34247 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfHDVau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 17:30:50 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B57961BF206;
        Sun,  4 Aug 2019 21:30:45 +0000 (UTC)
Date:   Sun, 4 Aug 2019 23:30:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for 5.3-rc4
Message-ID: <20190804232928.08b4b69a@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here are three MTD fixes for the next -rc.

Thanks,
Miquèl


The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.3-rc3

for you to fetch changes up to 2b372a9685a757a1d3ab30615ef42b2db7c45298:

  mtd: hyperbus: Add hardware dependency to AM654 driver (2019-08-03 02:11:52 +0200)

----------------------------------------------------------------
NAND:
- Fix Micron driver as some chips enable internal ECC correction
  during their discovery while they advertize they do not have any.

Hyperbus:
- Restrict the build to only ARM64 SoCs (and compile testing) which is
  what should have been done since the beginning.
- Fix Kconfig issue by selection something instead of implying it.

----------------------------------------------------------------
Jean Delvare (1):
      mtd: hyperbus: Add hardware dependency to AM654 driver

Marco Felsch (1):
      mtd: rawnand: micron: handle on-die "ECC-off" devices correctly

Vignesh Raghavendra (1):
      mtd: hyperbus: Kconfig: Fix HBMC_AM654 dependencies

 drivers/mtd/hyperbus/Kconfig       |  3 ++-
 drivers/mtd/nand/raw/nand_micron.c | 14 +++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)
