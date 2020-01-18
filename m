Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA7761419C5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 22:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgARVFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 16:05:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbgARVFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:05:07 -0500
Subject: Re: [GIT PULL] timers fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579381506;
        bh=5UNsG6b8eKT54dbdJgrxXmwer7DqaPjncA/zgmAJx70=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lDUhOns9hnuuJd9Hl9B9fmWL1t1wgQs4JrfR6j3j64wceBzi/Tv/bbyh4W0FgEWtm
         +vrp2yykGElxqgXBOofyXi9O4BGwAyuf8q6PpRf8aDG4CH1d1uYsC9hwEw4Xyse2sj
         VrTfSB0Xj8tmqOoN76RTzJ0gN9wTEj16avZJd1Hc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118184746.GA120588@gmail.com>
References: <20200118184746.GA120588@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118184746.GA120588@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: de95a991bb72e009f47e0c4bbc90fc5f594588d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ff15cd0458c288afa954de843bb1903c723e5b3
Message-Id: <157938150666.20598.4806338542994973489.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 21:05:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 19:47:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ff15cd0458c288afa954de843bb1903c723e5b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
