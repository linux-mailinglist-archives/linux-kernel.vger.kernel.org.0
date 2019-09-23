Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 285BFBBBFF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 21:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733209AbfIWTFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 15:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733093AbfIWTFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:05:24 -0400
Subject: Re: [GIT PULL] SELinux patches for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569265523;
        bh=U76FJwtKT0mkJl01AD/IYvcwyuNp6Ikc5Mdzd38gUN4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OQcwLYMVleEQgb3Cl4gMsNKZr9PCCjqvGgp8ISnT7GDlHubtDkmvKMVHfg8KeMgVr
         uz2HLp9pYvKnvNGPtXEmm8lxmC0IUz5Et/jZJ10oqcMFrsyH6KSMeYs/QWVr+ztNaZ
         RW9GdMUjLN9XeAhfdmOhpHgXM8BokAoVOdiFVSl0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhT1n=zwWJRSqF+OLzQq2r_8Bf0TjO-1QEe3yfLHAnomfA@mail.gmail.com>
References: <CAHC9VhT1n=zwWJRSqF+OLzQq2r_8Bf0TjO-1QEe3yfLHAnomfA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhT1n=zwWJRSqF+OLzQq2r_8Bf0TjO-1QEe3yfLHAnomfA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190917
X-PR-Tracked-Commit-Id: 15322a0d90b6fd62ae8f22e5b87f735c3fdfeff7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5825a95fe92566ada2292a65de030850b5cff1da
Message-Id: <156926552365.25044.12209568315799352743.pr-tracker-bot@kernel.org>
Date:   Mon, 23 Sep 2019 19:05:23 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 15:38:05 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190917

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5825a95fe92566ada2292a65de030850b5cff1da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
