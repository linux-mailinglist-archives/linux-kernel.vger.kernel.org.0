Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA0E412FCF8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 20:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgACTZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 14:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbgACTZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:25:07 -0500
Subject: Re: [GIT PULL] sound fixes for 5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578079507;
        bh=eIkzej8kQCG0C5j5sDgqo6iczqY0gMrQNGNBYC/qlPA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=glbpvJEQE76Z5O1o68On51rAp1zCXnS/3qOa+C5906FuLbYDCDDA0d3iIqPa2OhAa
         wuHs2kz9KdIrxvv0VXOWG/LJi9sdFKnmYr1PsEpYEinTewjrj9ebEMHiFYWqdyay5o
         PKQR66TcBKqGgfmKTGV+QgFZ1R8YJL3XWj6gU3Tg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hblrlj6yy.wl-tiwai@suse.de>
References: <s5hblrlj6yy.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hblrlj6yy.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.5-rc5
X-PR-Tracked-Commit-Id: 48e01504cf5315cbe6de9b7412e792bfcc3dd9e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e35d0165908ad2d2bdb76773ef77b551763eedbd
Message-Id: <157807950725.16643.6042970373475461519.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 19:25:07 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Jan 2020 09:10:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e35d0165908ad2d2bdb76773ef77b551763eedbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
