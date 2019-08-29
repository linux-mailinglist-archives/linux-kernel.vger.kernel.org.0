Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDF5A1A57
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfH2Moc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Aug 2019 08:44:32 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40567 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfH2Moc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:44:32 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 165B16000B;
        Thu, 29 Aug 2019 12:44:28 +0000 (UTC)
Date:   Thu, 29 Aug 2019 14:44:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for -rc7
Message-ID: <20190829144428.3cb4d481@xps13>
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

This is hopefully the last MTD fixes PR for the 5.3 cycle with a
single change to avoid build failures when compiling Hyperbus support.

Thanks,
Miquèl


The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.3-rc7

for you to fetch changes up to dc9cfd2692225a2164f4f20b7deaf38ca8645de3:

  mtd: hyperbus: fix dependency and build error (2019-08-29 14:31:23 +0200)

----------------------------------------------------------------
Hyperbus:
- Add a 'depends on' in the core Kconfig entry to avoid build errors.

----------------------------------------------------------------
Randy Dunlap (1):
      mtd: hyperbus: fix dependency and build error

 drivers/mtd/hyperbus/Kconfig | 1 +
 1 file changed, 1 insertion(+)
