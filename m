Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD4E14AA69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 20:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgA0TZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 14:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgA0TZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:25:04 -0500
Subject: Re: [GIT PULL] regmap updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580153103;
        bh=iGF0aK/RynG/U0YuGKDfJBEoler3HdkIjZ0/gk9tqJ0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lHQ87PPGmtj9lMxLHmUDTJOYThsQnJM36kFc3FcBOZek/LGZl+wUXvMdnloUOVG8r
         yfFl9libdKs3psgxsKzH+p5ZMK52PkAbyfKQJLJ/NtQFKP8pTH2epbKYH4NtrziMNt
         z4J9nR8Vj31gH7lNkQ5eq2hoQfuTTLXZgsH24APQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127165502.GB3763@sirena.org.uk>
References: <20200127165502.GB3763@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127165502.GB3763@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 tags/regmap-v5.6
X-PR-Tracked-Commit-Id: ea87683909bcda665527a828505c5e9c6a625429
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e83a0ed2a6a3f6e67630d1580f1ade97a54c524f
Message-Id: <158015310380.9462.7084802220012117339.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 19:25:03 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 16:55:02 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e83a0ed2a6a3f6e67630d1580f1ade97a54c524f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
