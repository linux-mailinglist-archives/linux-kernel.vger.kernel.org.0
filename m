Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F70A12524D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 20:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfLRTuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 14:50:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfLRTuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:50:13 -0500
Subject: Re: [GIT PULL] sound fixes for 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576698612;
        bh=hYuDFFkQZgXH4Uxz27uH1SrltG0+wxpKQfnVBGSAk7E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zRwkBMHTNKxADMxsrM2iE7nVUtSukDRq2hG4nm5UJP2qvfthkqDH/kJMT0u6pQIve
         hqLKtd7F2Gs750Uk8C+CuH+ovToHt8v2BxPSzsfj2HPwbIsxnlsn92g+1GXIFqtgWZ
         11zLXr4g5tLY0oBKPVR7Helcwgz0q5sJxSz9DhqE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv9qd7joq.wl-tiwai@suse.de>
References: <s5hv9qd7joq.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv9qd7joq.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.5-rc3
X-PR-Tracked-Commit-Id: 7c497d799267134786afdf719d9230b7d6f77d84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80a0c2e511a97e11d82e0ec11564e2c3fe624b0d
Message-Id: <157669861263.12558.9566179418368849066.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Dec 2019 19:50:12 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Dec 2019 16:11:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80a0c2e511a97e11d82e0ec11564e2c3fe624b0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
