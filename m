Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6945115677
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfEFXkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfEFXkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:06 -0400
Subject: Re: [GIT PULL] core/stacktrace updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186006;
        bh=ByB5r5VrENzoixGbIVGUDEBKnlm2LDA0usZQMgy+5kQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F6/X+eWK95zJWBqG1ly1tXC8OAQnVl+zf9tuajbP/9Lo9sj1YvPFJxNEj1sed9b0w
         RQMrwPTK9SINnUHimQ4DkoAgGmTK2MqYKKN4UYQ25gZ1I1zexW1wD392ajTvMCgjVY
         SRNsKrj1uJ82vf+uhGitQVJaVZM23VfxDenoapJs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506081234.GA69602@gmail.com>
References: <20190506081234.GA69602@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506081234.GA69602@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-stacktrace-for-linus
X-PR-Tracked-Commit-Id: 3599fe12a125fa7118da2bcc5033d7741fb5f3a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c6a392cddacde153865b15e8295ad0a35ed3c02
Message-Id: <155718600597.9113.7317041980043007638.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 10:12:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-stacktrace-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c6a392cddacde153865b15e8295ad0a35ed3c02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
