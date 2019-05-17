Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34A4121F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 23:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfEQVZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 17:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfEQVZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:25:21 -0400
Subject: Re: [GIT PULL] sound fixes for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558128321;
        bh=iTJVr0+Z92ghTJkARF3jX5Reqp8kneaC5xaYepWzVfM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YntguTNlnXnBreYZou7TCviyU63i+dmEii3lhWPruJl4+s+7AaFW19WWoah1eaTDH
         2fd0X3uAf8pC4qlAjbd9RJo6pJCem8Mqj2cfEqqiwjj3+smnGVCX0CjXSeOVWC+CKQ
         nmdMpUi1bIZFwiuDLlPCqO1vn+9rnLoYrboN1sEU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hmujlfdmb.wl-tiwai@suse.de>
References: <s5hmujlfdmb.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hmujlfdmb.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-fix-5.2-rc1
X-PR-Tracked-Commit-Id: 56df90b631fc027fe28b70d41352d820797239bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72cf0b07418a9c8349aa9137194b1ccba6e54a9d
Message-Id: <155812832130.2706.15644825041128394742.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 21:25:21 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 May 2019 14:51:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72cf0b07418a9c8349aa9137194b1ccba6e54a9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
