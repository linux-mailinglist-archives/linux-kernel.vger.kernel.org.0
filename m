Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8AEC743
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 18:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfKARKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 13:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbfKARKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:10:05 -0400
Subject: Re: [GIT PULL] sound fixes for 5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572628204;
        bh=tiH2v4tyuVa9ZeECf/rI3BdCW+mFhWxyDmfGnD2hapk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RThLRI2lVou8s5A3/f1jBfsyg1TRPjAtmHbD8MWPyMS+aBnRaWFDyzth4YULdTS3t
         299Cct4QkF8cn5ft5q8iPj7iF7hTD80udh95bPr6ZfgoF5+uWUTGlqulfpbNHXFCI8
         gayIF2NaLVNXnoZrh6y9CDNL5Gc8S0/YuSaJ69fo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hr22tdm5i.wl-tiwai@suse.de>
References: <s5hr22tdm5i.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hr22tdm5i.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.4-rc6
X-PR-Tracked-Commit-Id: a39331867335d4a94b6165e306265c9e24aca073
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2858598006961cd1ec06ebcc0549e7b3bd83f58c
Message-Id: <157262820488.11375.6618077323426311189.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 17:10:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Oct 2019 15:28:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2858598006961cd1ec06ebcc0549e7b3bd83f58c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
