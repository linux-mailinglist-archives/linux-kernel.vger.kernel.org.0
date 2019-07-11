Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9678464609
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfGJMLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 08:11:25 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:36118 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGJMLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:11:25 -0400
Received: from ramsan ([84.194.98.4])
        by baptiste.telenet-ops.be with bizsmtp
        id b0BN2000K05gfCL010BNyC; Wed, 10 Jul 2019 14:11:22 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hlBRS-0004Ke-82; Wed, 10 Jul 2019 14:11:22 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hlBRS-0002us-6o; Wed, 10 Jul 2019 14:11:22 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [git pull] m68k updates for 5.3 (take two)
Date:   Wed, 10 Jul 2019 14:11:20 +0200
Message-Id: <20190710121120.11156-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 69878ef47562f32e02d0b7975c990e1c0339320d:

  m68k: Implement arch_dma_prep_coherent() (2019-07-01 11:17:00 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.3-tag2

for you to fetch changes up to f28a1f16135c9c6366f3d3f20f2e58aefc99afa0:

  m68k: Don't select ARCH_HAS_DMA_PREP_COHERENT for nommu or coldfire (2019-07-09 09:13:24 +0200)

----------------------------------------------------------------
m68k updates for v5.3 (take two)

  - Don't select ARCH_HAS_DMA_PREP_COHERENT for nommu or coldfire.

This is a fix for an issue detected in next, to avoid introducing build
failures when merging Christoph's dma-mapping tree later.

Thanks for pulling!

----------------------------------------------------------------
Christoph Hellwig (1):
      m68k: Don't select ARCH_HAS_DMA_PREP_COHERENT for nommu or coldfire

 arch/m68k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
