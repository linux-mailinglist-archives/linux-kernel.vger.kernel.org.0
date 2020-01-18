Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307E5141A02
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 23:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgARWNQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 18 Jan 2020 17:13:16 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59575 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgARWNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 17:13:15 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 26821C0002;
        Sat, 18 Jan 2020 22:13:11 +0000 (UTC)
Date:   Sat, 18 Jan 2020 23:13:07 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for 5.5-rc7 or final
Message-ID: <20200118231006.6776f277@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is hopefully the last 4 MTD fixes that we would like to have in
v5.5.

Thanks,
Miquèl


The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

  Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.5-rc7

for you to fetch changes up to d70486668cdf51b14a50425ab45fc18677a167b2:

  mtd: rawnand: gpmi: Restore nfc timing setup after suspend/resume (2020-01-17 22:45:09 +0100)

----------------------------------------------------------------
Raw NAND:
* GPMI: Fix the suspend/resume

SPI-NOR:
* Fix quad enable on Spansion like flashes
* Fix selection of 4-byte addressing opcodes on Spansion

----------------------------------------------------------------
Esben Haabendal (2):
      mtd: rawnand: gpmi: Fix suspend/resume problem
      mtd: rawnand: gpmi: Restore nfc timing setup after suspend/resume

Michael Walle (1):
      mtd: spi-nor: Fix quad enable for Spansion like flashes

Vignesh Raghavendra (1):
      mtd: spi-nor: Fix selection of 4-byte addressing opcodes on Spansion

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 11 ++++++++++-
 drivers/mtd/spi-nor/spi-nor.c              |  6 +++---
 2 files changed, 13 insertions(+), 4 deletions(-)
