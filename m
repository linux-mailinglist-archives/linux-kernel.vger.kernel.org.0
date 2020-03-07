Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED83D17CEB4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 15:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgCGOaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 09:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgCGOaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 09:30:06 -0500
Subject: Re: [GIT PULL] sound fixes for 5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583591406;
        bh=YK2iYjY2OyJchLdfEj3t1RjmhKKNq8QSY+m55FWCQIQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OnSVXk1pcC39Y4r/PJ4jbgb22LRwMhhGk6YrddJE07nhJAlVoJIiqWUjjioi+BjTj
         05eOF3M5fdcRXL7Q/63qDCjD4dfBXpjjky8/1kDdXdcJGPuy7/JUJF6sH9CZ/pLZ6I
         d8/YJg82bGvP3hhTKOSspqcJiepCqju33DbFhyC4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hftekczh0.wl-tiwai@suse.de>
References: <s5hftekczh0.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hftekczh0.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.6-rc5
X-PR-Tracked-Commit-Id: 5a56996b0f13b9a5db0ca60528d13c661d37377a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 676fc8de319335b840934c57ec75bdbbf049b738
Message-Id: <158359140594.13770.17745866697936026478.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Mar 2020 14:30:05 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 07 Mar 2020 09:59:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/676fc8de319335b840934c57ec75bdbbf049b738

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
