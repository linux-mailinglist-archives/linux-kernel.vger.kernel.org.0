Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F64510A483
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 20:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfKZTaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 14:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfKZTaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:13 -0500
Subject: Re: [GIT PULL] x86/entry changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796612;
        bh=byQIi+HbsCOzM+i7IEdMPnB3sn6YrYQJvAezISVV9kA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GSefI8SYIEC3VxYtXd6bQ39IoYTGnmN5L/bb2LyjkYch1s+e1ScSGKBTETfAR5aCF
         1uRhRYAFsnCQH+tkfGbm0dJLasGnKCRsrYCGx3yNtAQPBo5UofsI2sJtADKSO1Nwgk
         SYfbHwlnGNeAppmNX/NpAPFAKZ9PSLNoobI/B0HU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125134922.GA5532@gmail.com>
References: <20191125134922.GA5532@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125134922.GA5532@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus
X-PR-Tracked-Commit-Id: f53e2cd0b8ab7d9e390414470bdbd830f660133f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd4771f7709211082cbc41dc1f5b2be774ef1604
Message-Id: <157479661251.2359.2999823608035580617.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 14:49:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd4771f7709211082cbc41dc1f5b2be774ef1604

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
