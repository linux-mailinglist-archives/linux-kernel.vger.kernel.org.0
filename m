Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979DB178664
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 00:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgCCXfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 18:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbgCCXfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:35:05 -0500
Subject: Re: [GIT PULL] EFI fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583278505;
        bh=MnS0UHMUIcEQBjjyuVFier/SbSGK8nuHszJUY8+dirc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xozMcNGSiJTvbN8o61To2EtjVypIWvxRVJDz6QBFvLVRXIPWNmq/u/U6G/+nXb+0y
         1rLwE7fC8hwJ7HwKvOxv+aWn+eXvjPYxlcQoDej/WN3nGCbdNQQeX0/6dz7RdoXCKo
         MYMPli8V+5frXMMrUJ2QU4nzU4oxD2kMqzJW7ZeI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200302071023.GA7775@gmail.com>
References: <20200302071023.GA7775@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200302071023.GA7775@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-for-linus
X-PR-Tracked-Commit-Id: be36f9e7517e17810ec369626a128d7948942259
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e130a920f69399777062f9fe7763abe895d386b0
Message-Id: <158327850508.6555.15271327699290926424.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Mar 2020 23:35:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Mar 2020 08:10:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e130a920f69399777062f9fe7763abe895d386b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
