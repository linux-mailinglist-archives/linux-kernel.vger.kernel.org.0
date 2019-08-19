Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C83950DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 00:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfHSWgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 18:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbfHSWgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:36:36 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B025F22CE8;
        Mon, 19 Aug 2019 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566254195;
        bh=YEdKyrfzkbI7OTEtQvjZbLAobM0Z+Ql6qeP0XmLivRc=;
        h=From:To:Cc:Subject:Date:From;
        b=Egas0vPRc3YwIvAlXQxEaVphQ5NT/gvtU2FeUaFwC21vMbUO4iY3BVva9UUPNe8FM
         GlG9U3sOlEh9ngmuj5DEkNEvzQG2fG3ZHXxvTOPETWckXvy/aF6b+kP9RReDRvS2bD
         4mLkVyolVIY7cmNvu8xvGIsf+QbyZ5ff9lzXB8R8=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.3-rc5
Date:   Mon, 19 Aug 2019 15:36:35 -0700
Message-Id: <20190819223635.59566-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e1f1ae8002e4b06addc52443fcd975bbf554ae92:

  clk: renesas: cpg-mssr: Fix reset control race condition (2019-07-22 15:04:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 24876f09a7dfe36a82f53d304d8c1bceb3257a0f:

  clk: Fix potential NULL dereference in clk_fetch_parent_index() (2019-08-16 10:30:21 -0700)

----------------------------------------------------------------
A couple fixes to the core framework logic that finds clk parents, a
handful of samsung clk driver fixes for audio and display clks, and a
small fix for the Stratix10 SoC driver that was checking the wrong
register for validity.

----------------------------------------------------------------
Dinh Nguyen (1):
      clk: socfpga: stratix10: fix rate caclulationg for cnt_clks

Marek Szyprowski (1):
      clk: samsung: exynos542x: Move MSCL subsystem clocks to its sub-CMU

Martin Blumenstingl (1):
      clk: Fix potential NULL dereference in clk_fetch_parent_index()

Stephen Boyd (1):
      clk: Fix falling back to legacy parent string matching

Sylwester Nawrocki (2):
      clk: samsung: Change signature of exynos5_subcmus_init() function
      clk: samsung: exynos5800: Move MAU subsystem clocks to MAU sub-CMU

 drivers/clk/clk.c                        |  49 +++++++---
 drivers/clk/samsung/clk-exynos5-subcmu.c |  16 +--
 drivers/clk/samsung/clk-exynos5-subcmu.h |   2 +-
 drivers/clk/samsung/clk-exynos5250.c     |   7 +-
 drivers/clk/samsung/clk-exynos5420.c     | 162 +++++++++++++++++++++----------
 drivers/clk/socfpga/clk-periph-s10.c     |   2 +-
 6 files changed, 163 insertions(+), 75 deletions(-)

-- 
Sent by a computer through tubes
