Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89609D5266
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 22:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbfJLU3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 16:29:19 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:60774 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfJLU3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 16:29:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 682C4609D2F2;
        Sat, 12 Oct 2019 22:29:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DCpYQgfqV-ok; Sat, 12 Oct 2019 22:29:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1E788609D2F1;
        Sat, 12 Oct 2019 22:29:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2rXCj63ki4Po; Sat, 12 Oct 2019 22:29:17 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E0AAF609D2C6;
        Sat, 12 Oct 2019 22:29:16 +0200 (CEST)
Date:   Sat, 12 Oct 2019 22:29:16 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Message-ID: <1615396520.21318.1570912156820.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] mtd: Fixes for v5.4-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Index: smKon1qr3Q9KM5c1y0Y1Qg5DoWAx3A==
Thread-Topic: Fixes for v5.4-rc3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/fixes-for-5.4-rc3

for you to fetch changes up to df8fed831cbcdce7b283b2d9c1aadadcf8940d05:

  mtd: rawnand: au1550nd: Fix au_read_buf16() prototype (2019-10-07 09:56:36 +0200)

----------------------------------------------------------------
This pull request contains two fixes for MTD:

- spi-nor: Fix for a regression in write_sr()
- rawnand: Regression fix for the au1550nd driver

----------------------------------------------------------------
Paul Burton (1):
      mtd: rawnand: au1550nd: Fix au_read_buf16() prototype

Tudor Ambarus (1):
      mtd: spi-nor: Fix direction of the write_sr() transfer

 drivers/mtd/nand/raw/au1550nd.c | 5 ++---
 drivers/mtd/spi-nor/spi-nor.c   | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)
