Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6B014A139
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 10:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgA0JyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 04:54:15 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:55920 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgA0JyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:54:15 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id vMuD210045USYZQ06MuDBF; Mon, 27 Jan 2020 10:54:13 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iw15w-0003l6-Un; Mon, 27 Jan 2020 10:54:12 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iw15w-0000x1-Qq; Mon, 27 Jan 2020 10:54:12 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for 5.6
Date:   Mon, 27 Jan 2020 10:54:10 +0100
Message-Id: <20200127095410.3611-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.6-tag1

for you to fetch changes up to 6aabc1facdb24e837cfea755ba46a6be22a8860f:

  m68k: Implement copy_thread_tls() (2020-01-14 10:43:38 +0100)

----------------------------------------------------------------
m68k updates for v5.6

  - Wire up clone3() syscall,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (2):
      m68k: defconfig: Update defconfigs for v5.5-rc3
      m68k: Implement copy_thread_tls()

Kars de Jong (1):
      m68k: Wire up clone3() syscall

 arch/m68k/Kconfig                     |  1 +
 arch/m68k/configs/amiga_defconfig     |  8 +++++--
 arch/m68k/configs/apollo_defconfig    |  8 +++++--
 arch/m68k/configs/atari_defconfig     |  8 +++++--
 arch/m68k/configs/bvme6000_defconfig  |  8 +++++--
 arch/m68k/configs/hp300_defconfig     |  8 +++++--
 arch/m68k/configs/mac_defconfig       |  8 +++++--
 arch/m68k/configs/multi_defconfig     |  8 +++++--
 arch/m68k/configs/mvme147_defconfig   |  8 +++++--
 arch/m68k/configs/mvme16x_defconfig   |  8 +++++--
 arch/m68k/configs/q40_defconfig       |  8 +++++--
 arch/m68k/configs/sun3_defconfig      |  6 ++++-
 arch/m68k/configs/sun3x_defconfig     |  8 +++++--
 arch/m68k/include/asm/unistd.h        |  1 +
 arch/m68k/kernel/entry.S              |  7 ++++++
 arch/m68k/kernel/process.c            | 44 +++++++++++++++++++++++++++--------
 arch/m68k/kernel/syscalls/syscall.tbl |  2 +-
 17 files changed, 115 insertions(+), 34 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
