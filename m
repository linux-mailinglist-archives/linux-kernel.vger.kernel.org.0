Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEE9164C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 18:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgBSRkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 12:40:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:47902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgBSRkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:40:18 -0500
Subject: Re: [GIT PULL] sound fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582134018;
        bh=nni+pRE7urJl0FU//cqcQYQSt8EtaasAX3FjQdlt1II=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hj9kwgm4bZIvranYFgPo+Je8JehAU/xHx8pSc42fa4Y+8d6aFgWtULyj1WOiYscl6
         /YZHneI9F3MJWCaEffgRlD0f5O8PJCMTNRUb/f3gjFjgoyh0WaL9hGda6sF2JaJRFE
         /usgWAxC0mElWILUTtnD9tw6rm5AvqsywTfid98A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h36b66erc.wl-tiwai@suse.de>
References: <s5h36b66erc.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h36b66erc.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.6-rc3
X-PR-Tracked-Commit-Id: 385536090b18534967b1073d0f18b5b86d793c30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa079ba8a98ddc1101ddec902e95eea40ef1e0dc
Message-Id: <158213401824.16030.6160226721374696869.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Feb 2020 17:40:18 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Feb 2020 11:41:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa079ba8a98ddc1101ddec902e95eea40ef1e0dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
