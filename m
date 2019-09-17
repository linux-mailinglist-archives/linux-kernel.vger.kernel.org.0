Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C1B45A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 04:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403987AbfIQCzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 22:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392091AbfIQCzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:55:24 -0400
Subject: Re: [GIT PULL] x86/mm changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568688923;
        bh=AclS88jxhzyJJE2UfrOKrXQ7FdVaz97VGPFXbtX2h2A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L/Nvynat0vMdKifI8zq5TYfQWjYTrWNrQXo3dfvRc4x749USdWiEac3lhaH7Gl+0z
         ZPCAHz7sKWyAx/T+2bnB+dZLJp77D0jq6NDN6ZDwIVAU9qZW2XcVmFTLsMX4z65QjR
         s/h5AP25mBok1B9vhrzA9bsSm3JKZIAI9Q4xuzOk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916132510.GA28017@gmail.com>
References: <20190916132510.GA28017@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916132510.GA28017@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus
X-PR-Tracked-Commit-Id: bc04a049f058a472695aa22905d57e2b1f4c77d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac51667b5b95f1209aa97af780cecf0cf6f4003f
Message-Id: <156868892385.5285.686055463690499671.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 02:55:23 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 15:25:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac51667b5b95f1209aa97af780cecf0cf6f4003f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
