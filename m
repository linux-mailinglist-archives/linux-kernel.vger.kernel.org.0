Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6310DE2EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 12:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438767AbfJXKZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 06:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438721AbfJXKZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:25:08 -0400
Subject: Re: [GIT PULL] sound fixes for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571912708;
        bh=tXRmztpTH++++m+GX9hGSr6ayfLOEjEjKvJZKIyUfaQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=acZgJ0+PVwmxGr9k+68mTRKl9TqXYncNNXq1IuGD1p6wOqesYrwnf4e7xzToWnLvw
         k62+KuJMTL3kjyaQIIRRP7afRaOxX+Hf7pqo5LtCA07ssMnXMRt5gSg1MSGEl/XF0V
         tOdrnm0ujV3zQRLMcqN1ZbANKpoVnwKWGNKsDIqA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv9seoczv.wl-tiwai@suse.de>
References: <s5hv9seoczv.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv9seoczv.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.4-rc5
X-PR-Tracked-Commit-Id: 4750c212174892d26645cdf5ad73fb0e9d594ed3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f632bfaa33ed147ba9eade15f137fc32a13bd4b8
Message-Id: <157191270801.16083.3144518174117540644.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Oct 2019 10:25:08 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Oct 2019 08:48:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f632bfaa33ed147ba9eade15f137fc32a13bd4b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
