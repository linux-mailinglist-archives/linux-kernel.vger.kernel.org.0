Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A33B1853D5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Mar 2020 02:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgCNB1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 21:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgCNB1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 21:27:23 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 006392074C;
        Sat, 14 Mar 2020 01:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584149243;
        bh=swerRyUJxUODfmDzekCjsxd7ozDfqDISTBClgBXOfFE=;
        h=From:To:Cc:Subject:Date:From;
        b=0UHuVr8i+OQnilm7VkRRv1BAqxlT/nxJQAuioO76UwF5jLBW8XshKQhae7T2OxRK+
         5dFmWRdFwKVK3mFLu8doZMimwGHUJJXq0mlUGtEiM/YNIdVDmDk6x07xYWhMQg+1OZ
         lgRrkWdAshDcgU/B+7a8eK+gno3l2yE8DGjnLc1Y=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.6-rc5
Date:   Fri, 13 Mar 2020 18:27:22 -0700
Message-Id: <20200314012722.234270-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 20055448dc1b439c87d0cb602e6d0469b0a3aaad:

  Merge tag 'imx-clk-fixes-5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into clk-fixes (2020-02-25 08:57:00 -0800)

----------------------------------------------------------------
A small collection of fixes. I'll make another sweep soon to look for
more fixes for this -rc series.

 - Mark device node const in of_clk_get_parent APIs to ease landing
   changes in users later
 - Fix flag for Qualcomm SC7180 video clocks where we thought it would
   never turn off but actually hardware takes care of it
 - Remove disp_cc_mdss_rscc_ahb_clk on Qualcomm SC7180 SoCs because this
   clk is always on anyway
 - Correct some bad dt-binding numbers for i.MX8MN SoCs

----------------------------------------------------------------
Anson Huang (1):
      clk: imx8mn: Fix incorrect clock defines

Geert Uytterhoeven (1):
      of: clk: Make of_clk_get_parent_{count,name}() parameter const

Stephen Boyd (1):
      Merge tag 'imx-clk-fixes-5.6' of git://git.kernel.org/.../shawnguo/linux into clk-fixes

Taniya Das (2):
      clk: qcom: videocc: Update the clock flag for video_cc_vcodec0_core_clk
      clk: qcom: dispcc: Remove support of disp_cc_mdss_rscc_ahb_clk

 drivers/clk/clk.c                        |  4 ++--
 drivers/clk/qcom/dispcc-sc7180.c         | 19 -------------------
 drivers/clk/qcom/videocc-sc7180.c        |  2 +-
 include/dt-bindings/clock/imx8mn-clock.h |  4 ++--
 include/linux/of_clk.h                   |  8 ++++----
 5 files changed, 9 insertions(+), 28 deletions(-)

-- 
Sent by a computer, using git, on the internet
