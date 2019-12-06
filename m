Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1971158AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 22:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfLFVfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 16:35:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfLFVfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:35:25 -0500
Subject: Re: [GIT PULL] sound updates #2 for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575668125;
        bh=K3Sn4rHiAUWbb5A9RdGLOW6rugqVcckxhtoK2wV8iSc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sdNGRKYExSySl89BkoNsGCKFTbaziZEyBsDXkXS5TIIA+AwD89ZeYO6YpE4ZTxuu+
         friNNufql8+sr/B6mfTz/XshPYoTTWzdI2iv/7heEe2Nq79ZLR7vxVAXAa2cTQQ+gZ
         ggsq3sKsB34SC4boqfAH3Et7NvoM9ndmF+4u/PZA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h1rthio56.wl-tiwai@suse.de>
References: <s5h1rthio56.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h1rthio56.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-fix-5.5-rc1
X-PR-Tracked-Commit-Id: 4cc8d6505ab82db3357613d36e6c58a297f57f7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cf2890f29ab6fe491361761df558ef9191cb468
Message-Id: <157566812494.4346.1907847064884449254.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Dec 2019 21:35:24 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 06 Dec 2019 14:23:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cf2890f29ab6fe491361761df558ef9191cb468

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
