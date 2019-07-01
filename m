Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE72E841
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 00:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfE2W3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 18:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfE2W3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:29:17 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D8E12429C;
        Wed, 29 May 2019 22:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559168957;
        bh=sRuDFYFvafjXzg4Zs8n3IU0+t0X6gJgAOUfxV/kpjgw=;
        h=From:To:Cc:Subject:Date:From;
        b=am2vgzaqmJF9GMOAx47qRRaowbVYqHHgryyBB9+6F5I258o6ec6Wlmj9OSTJtoBsx
         OQ34W2C+iqwZ2jHCLU58F67DHmaRuiqjpcQUZaS8Ur0ixUEp3QZ1RErUa+CuNNIh7E
         vCL0zwXeiPZHQlqkGhplHONjU4EqD17BKVrch4Kg=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.2-rc2
Date:   Wed, 29 May 2019 15:29:16 -0700
Message-Id: <20190529222916.57086-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 1cc54078d104f5b4d7e9f8d55362efa5a8daffdb:

  clk: ti: clkctrl: Fix clkdm_clk handling (2019-05-21 11:43:40 -0700)

----------------------------------------------------------------
A few clk driver fixes

 - Don't expose the SiFive clk driver on non-RISCV architectures

 - Fix some bits describing clks in the imx8mm driver

 - Always call clk domain code in the TI driver so non-legacy platforms
   work

----------------------------------------------------------------
Paul Walmsley (1):
      clk: sifive: restrict Kconfig scope for the FU540 PRCI driver

Peng Fan (1):
      clk: imx: imx8mm: fix int pll clk gate

Tony Lindgren (1):
      clk: ti: clkctrl: Fix clkdm_clk handling

 drivers/clk/imx/clk-imx8mm.c | 12 ++++++------
 drivers/clk/sifive/Kconfig   |  1 +
 drivers/clk/ti/clkctrl.c     |  8 ++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

-- 
Sent by a computer through tubes
