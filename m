Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79020BA909
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 21:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391500AbfIVTKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 15:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393794AbfIVTKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:10:23 -0400
Subject: Re: [GIT PULL] hsi changes for hsi-5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569179422;
        bh=V1reMLSGjw9s7BYOmYPwjhBvV2o54hjG51I+J+Wcl1U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k0fc3vR+F91jss4EHfyHhVc7eO4N+pcBJZPwHPQv32eW36XucomNlbCKGGhIxsDbE
         6jREFMBRvXbW59NtD4skk9ypTcmBk8Ph2+OURKnwjjNDeBP/zSsKcKTG1yeNJxksx7
         utodoHae0sDmOBb7qWKzGP/wjTm4xFKlzfltNs1Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190922160206.qqsrupqvtly4akhn@earth.universe>
References: <20190922160206.qqsrupqvtly4akhn@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190922160206.qqsrupqvtly4akhn@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git
 tags/hsi-for-5.4
X-PR-Tracked-Commit-Id: c1030cd456198a2c58f718c3c4b215698d635553
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57f1c3caf5137d4493fcd1d07c3ae4a5636f4949
Message-Id: <156917942288.29484.18265056100390989150.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Sep 2019 19:10:22 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Sep 2019 18:02:06 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57f1c3caf5137d4493fcd1d07c3ae4a5636f4949

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
