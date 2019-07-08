Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C897461B82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 10:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfGHIAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 04:00:12 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:48920 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfGHIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:00:11 -0400
Received: from ramsan ([84.194.98.4])
        by baptiste.telenet-ops.be with bizsmtp
        id a8092000905gfCL01809mD; Mon, 08 Jul 2019 10:00:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hkOZG-0005UX-2Y; Mon, 08 Jul 2019 10:00:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hkOZG-0005wb-01; Mon, 08 Jul 2019 10:00:10 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [git pull] m68k updates for 5.3
Date:   Mon,  8 Jul 2019 10:00:05 +0200
Message-Id: <20190708080005.22806-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.3-tag1

for you to fetch changes up to 69878ef47562f32e02d0b7975c990e1c0339320d:

  m68k: Implement arch_dma_prep_coherent() (2019-07-01 11:17:00 +0200)

----------------------------------------------------------------
m68k updates for v5.3

  - Switch to using the generic remapping DMA allocator,
  - Defconfig updates.

----------------------------------------------------------------
Christoph Hellwig (2):
      m68k: Use the generic dma coherent remap allocator
      m68k: Implement arch_dma_prep_coherent()

Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v5.2-rc1

 arch/m68k/Kconfig                    |  3 ++
 arch/m68k/configs/amiga_defconfig    | 17 +++++------
 arch/m68k/configs/apollo_defconfig   | 17 +++++------
 arch/m68k/configs/atari_defconfig    | 17 +++++------
 arch/m68k/configs/bvme6000_defconfig | 17 +++++------
 arch/m68k/configs/hp300_defconfig    | 17 +++++------
 arch/m68k/configs/mac_defconfig      | 17 +++++------
 arch/m68k/configs/multi_defconfig    | 17 +++++------
 arch/m68k/configs/mvme147_defconfig  | 17 +++++------
 arch/m68k/configs/mvme16x_defconfig  | 17 +++++------
 arch/m68k/configs/q40_defconfig      | 17 +++++------
 arch/m68k/configs/sun3_defconfig     | 17 +++++------
 arch/m68k/configs/sun3x_defconfig    | 17 +++++------
 arch/m68k/kernel/dma.c               | 57 +++++++-----------------------------
 14 files changed, 98 insertions(+), 166 deletions(-)

Thanks for pulling!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
