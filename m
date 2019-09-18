Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64686B5916
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 02:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfIRAuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 20:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfIRAuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 20:50:18 -0400
Subject: Re: [GIT PULL] sound updates for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568767818;
        bh=sZzCZ/lTPuZ3JLJbvwi6BsJErXkWfxdOkQzXWEMY2jk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pUpp52rKTJc3rxcn+20b6wiw8jcrilnz9KAU3HLQPJJu8XpkmFfXvLxqozhHDLHxR
         s34MD3AF+MmHGiA5hm4pGRRGA63k3D5qDj+JNrezI5bS3/P9I9Fr5XEvsmC83MbPy3
         XL5sKpGvoFu8K8E9CWnv96DiweQkoHZkhnZbdQ04=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv9tsxy2h.wl-tiwai@suse.de>
References: <s5hv9tsxy2h.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv9tsxy2h.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.4-rc1
X-PR-Tracked-Commit-Id: 9bf9bf5440b99edfba496388c90b52ebcd9df715
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ab8ad31601f29470eb895fd95e5c963e125aa1b
Message-Id: <156876781827.24504.13474401284409648002.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 00:50:18 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:47:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ab8ad31601f29470eb895fd95e5c963e125aa1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
