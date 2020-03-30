Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52AE91986EF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 00:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgC3WFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 18:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbgC3WFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:05:10 -0400
Subject: Re: [GIT PULL] regmap update for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585605910;
        bh=AuL+ISc2eSx42CFZAzL/KFMAP0lU7x4vIjfMwUTY4VM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F/9lY+IJsrWcXx0qywyws0EUxyD/3CsDwfLcWpLn/vNvlGMPC7RqB9rStnuOr8FXW
         R1OUaMEbK7uS0KJQkuvPkbZykY3eF1FZOSJhS4/Tde5oc/W7BfgZ1gQwMOfXuiIBnw
         O0d230W+ajk8Hq7UiBTdBGS3/datObjPzoOxzByE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330114919.GG4792@sirena.org.uk>
References: <20200330114919.GG4792@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330114919.GG4792@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 tags/regmap-v5.7
X-PR-Tracked-Commit-Id: ad5906bd6e9aa3e156dcac8fc070b153648e8b68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e129940938d84d8b71074e40a9cc4f69278eb1e1
Message-Id: <158560590993.3338.12403265191033867331.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 22:05:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 12:49:19 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e129940938d84d8b71074e40a9cc4f69278eb1e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
