Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20908211FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 04:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfEQCZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 22:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfEQCZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:25:24 -0400
Subject: Re: [GIT PULL] One more clk change for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558059924;
        bh=s2kmQqAn8MSL+gSt8BT0mIrhErZcoqmmSlzM06BVnU0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WQtsHj2smKg1Km30e376IvqFx77NwaYnMbp6ehrQKcxva/albJjvt/ArBDEYtseRM
         Gzihz1FAnKG7zDLqjrg+hsySKBGN84w8aTp6KYlRDs7D81rZzglAMNJpYTPKOOrF0V
         4YfwywyCNvm+hRGkVIUuD1/hKLS3NOvRqoKmNUKM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516230429.124276-1-sboyd@kernel.org>
References: <20190516230429.124276-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516230429.124276-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: 62e59c4e69b3cdbad67e3c2d49e4df4cfe1679e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 815d469d8c9a3360ee0a8b7857dd95352a6c7bde
Message-Id: <155805992427.6110.11663227248164879485.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 02:25:24 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 16:04:29 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/815d469d8c9a3360ee0a8b7857dd95352a6c7bde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
