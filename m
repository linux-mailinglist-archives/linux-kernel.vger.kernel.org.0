Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21AA463BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfFNQPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 12:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfFNQPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:15:07 -0400
Subject: Re: [GIT PULL] sound fixes for 5.2-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560528906;
        bh=LD0P9yJbUH+yccaTwlHYlz+rF70nBq9iMFDZCCpQIAc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aX7Njcg8guZapTT3sbDGUDzay3yqVc/HH0/SSbFTJWXUHtoxBC3DRewaPwcoEVfyw
         r8dRO4i0r/QyINgSC4z0QITiGEtOjNKcipSGECeME5i6wQFp81WaQPERy4LpYjJSg7
         ziQe8cCDrx591u/VOlPjfphgzOTrTNztOMTD2JuY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hk1dok01g.wl-tiwai@suse.de>
References: <s5hk1dok01g.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hk1dok01g.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.2-rc5
X-PR-Tracked-Commit-Id: 17d304604a88cf20c8dfd2c95d3decb9c4f8bca4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bcb46a0e0e5c79291ffbc1e4b5d1d3d119e0f984
Message-Id: <156052890681.10292.4607630287290977443.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jun 2019 16:15:06 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jun 2019 11:07:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bcb46a0e0e5c79291ffbc1e4b5d1d3d119e0f984

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
