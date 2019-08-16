Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB06C905CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfHPQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 12:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfHPQaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:30:07 -0400
Subject: Re: [GIT PULL] sound fixes for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565973006;
        bh=MQ9BKNfShGfCLFriDVM6MJCdFr2oLfQmXLpwg2mbr9w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l5rHjY2YnG/FEtX+hCQPFWsNiaG4fqmH+SCf8WqiZ8U0pg+rR8eWcEkQKiuYL87gw
         t7TzBgL0xuENpjr1dTtinB7RkBZgTLrAL1AF4FzBhvcZG3mGIXIoF1cOW3+WSFOZSK
         2jXpidbiLrdi+M6TrhVe8tfWkNUeWg73T2Nx3Hgc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5ha7c9a2pp.wl-tiwai@suse.de>
References: <s5ha7c9a2pp.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5ha7c9a2pp.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.3-rc5
X-PR-Tracked-Commit-Id: 19bce474c45be69a284ecee660aa12d8f1e88f18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfa0bb2aef998a64d5ad2c065be8511ad98d5d79
Message-Id: <156597300613.15122.14009769892580538461.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Aug 2019 16:30:06 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Aug 2019 11:17:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfa0bb2aef998a64d5ad2c065be8511ad98d5d79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
