Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928D91320C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfECQUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 12:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbfECQUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:20:04 -0400
Subject: Re: [GIT PULL] clk fixes for v5.1-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556900404;
        bh=0TOi0hn8u9WyZwvvcKPTuoqrDLTuYajHK1BwAZ3utwE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sQ1PmsKeWfHJQ8TgnO0e59uwlDzRmA97Y+UqroSuf5qU1FsyT0J4Tsk17tbhR+l2p
         fK4KbrSU042N/TPeqR0x4c/BLggfxJkzDrTRiKjCmitqYFfhQESsTuKI8ecVDM6Rvp
         Rk28I2wWfaU6nMUYIj2OetfH9pjOMjjpWmNVCSCQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190502204640.26046-1-sboyd@kernel.org>
References: <20190502204640.26046-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190502204640.26046-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: b88c9f4129dcec941e5a26508e991c08051ed1ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f76216c80c299ab8074b8658b73faa3815c6f39
Message-Id: <155690040418.31408.11383572186306889556.pr-tracker-bot@kernel.org>
Date:   Fri, 03 May 2019 16:20:04 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  2 May 2019 13:46:40 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f76216c80c299ab8074b8658b73faa3815c6f39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
