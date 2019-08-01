Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 921D67E12C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 19:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfHARgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 13:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbfHARgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:36:20 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E241E205F4;
        Thu,  1 Aug 2019 17:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564680979;
        bh=IC9xio7VdV0hRMdTF8SOBbacb/r4U2sEiKW4rGKr+0s=;
        h=From:To:Cc:Subject:Date:From;
        b=1c7r2jPY5MRd1SQAcR92n6XYXf4vAY6Ogn9AgizZnsfs+cnQV0HvZq7hNJ2NY1+/X
         liwf9CTwoZGtjKegVKjZO21XFPUKiMKB/YlIYjU/b6/FJrMwTayZgZ/moEBSBKUNzf
         8lH8Hrs2SOUUqpZXXH57OKG4z0ACWDW5/gs2uIeI=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.3-rc2
Date:   Thu,  1 Aug 2019 10:36:18 -0700
Message-Id: <20190801173618.245393-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to e1f1ae8002e4b06addc52443fcd975bbf554ae92:

  clk: renesas: cpg-mssr: Fix reset control race condition (2019-07-22 15:04:54 -0700)

----------------------------------------------------------------
A few fixes for code that came in during the merge window or
that started getting exercised differently this time around:

 - Select regmap MMIO kconfig in spreadtrum driver to avoid compile
   errors
 - Complete kerneldoc on devm_clk_bulk_get_optional()
 - Register an essential clk earlier on mediatek mt8183 SoCs so
   the clocksource driver can use it
 - Fix divisor math in the at91 driver
 - Plug a race in Renesas reset control logic

----------------------------------------------------------------
Chunyan Zhang (1):
      clk: sprd: Select REGMAP_MMIO to avoid compile errors

Codrin Ciubotariu (1):
      clk: at91: generated: Truncate divisor to GENERATED_MAX_DIV + 1

Geert Uytterhoeven (1):
      clk: renesas: cpg-mssr: Fix reset control race condition

Sylwester Nawrocki (1):
      clk: Add missing documentation of devm_clk_bulk_get_optional() argument

Weiyi Lu (1):
      clk: mediatek: mt8183: Register 13MHz clock earlier for clocksource

 drivers/clk/at91/clk-generated.c       |  2 ++
 drivers/clk/mediatek/clk-mt8183.c      | 46 +++++++++++++++++++++++++---------
 drivers/clk/renesas/renesas-cpg-mssr.c | 16 ++----------
 drivers/clk/sprd/Kconfig               |  1 +
 include/linux/clk.h                    |  1 +
 5 files changed, 40 insertions(+), 26 deletions(-)

-- 
Sent by a computer through tubes
