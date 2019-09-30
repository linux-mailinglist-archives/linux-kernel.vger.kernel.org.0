Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 395E7C282C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 23:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbfI3VF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 17:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732497AbfI3VFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:05:55 -0400
Subject: Re: [GIT PULL] MMC updates for v5.4 take 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569864621;
        bh=mHVTh4+1hSJf1xt/ZltF4EnnljfjYyuQSG9nVKGXJwA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z0Mtcew0N4C8YqZkZ25yUY94OFb/3hBramvpJCvJ/yU6S2OWykXDG4Np3OywVt1hc
         FOcM6Lk5x6yeHMRylH17Zf+0FlfMzxG3AmyXEU9gKdAq+iP3xtLc7NHz6InyZKc2Cd
         RhVGRopRNiLXk65NS7Nd/kapUUk9QCgvlP7ODcfg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190929193810.2551-1-ulf.hansson@linaro.org>
References: <20190929193810.2551-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190929193810.2551-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-2
X-PR-Tracked-Commit-Id: e51df6ce668a8f75ce27f83ce0f60103c568c375
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c710364f78afdef8c2ed07556d0743c5a30ed429
Message-Id: <156986462175.9141.2830072160556301661.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Sep 2019 17:30:21 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Sep 2019 21:38:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c710364f78afdef8c2ed07556d0743c5a30ed429

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
