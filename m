Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71DC258F71
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 02:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfF1AzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 20:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfF1AzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:55:04 -0400
Subject: Re: [GIT PULL] clk fixes for v5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561683304;
        bh=o13rGM6vMulkP8kdptU6Ib8+Sz0AFNP2C5JcJSAx74k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MjYoVMLt6cZxv1Aw4RUNt0fES5yaD0W1sLgr3Z+2hU89dZ067vH/VuyHG6fXRCQ05
         VsaDcH3faw8SBfR63eJIVDtCDf5AK1AaIyHjhI2zgRmM9kDhfuXIVTtnsrcobO2yMR
         dF0YjkhvfkhbKOOaHF+LYGQFVl1ifgYNLBifpL94=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190627202549.45667-1-sboyd@kernel.org>
References: <20190627202549.45667-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190627202549.45667-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 74684cce5ebd567b01e9bc0e9a1945c70a32f32f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 556e2f6020bf90f63c5dd65e9a2254be6db3185b
Message-Id: <156168330422.8716.170645861291830293.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jun 2019 00:55:04 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Jun 2019 13:25:49 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/556e2f6020bf90f63c5dd65e9a2254be6db3185b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
