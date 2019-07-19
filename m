Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30E76EB42
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 21:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbfGSTp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 15:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387573AbfGSTp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:45:26 -0400
Subject: Re: [GIT PULL] tracing: Fix user stack trace "??" output
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563565525;
        bh=vWRPReZFbl+fQBujRz2eAovwyLAgFh282Yy3mDKjR1o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K5OWXYcgMr34jZZFkn42lx0FE+vy9ilF485F0BRZtm5YY5GOmYkrJ3Jg8iuhdav8y
         ac2isJbH+fNQ2r1+nSc7Ge6hzQmKMfCksEzGftcwu3A20Ev8K7FI5IQkgw0SypO/Uw
         1ky9EehGvrOZorTPu2Wc16qouHNOUL3HamaH2igw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190719121813.4b113efd@gandalf.local.home>
References: <20190719121813.4b113efd@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190719121813.4b113efd@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.3-2
X-PR-Tracked-Commit-Id: 6d54ceb539aacc3df65c89500e8b045924f3ef81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41ba485ef1d0dca98c5b194b8fb19201e123a08d
Message-Id: <156356552591.25668.1158656745829989869.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jul 2019 19:45:25 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eiichi Tsukata <devel@etsukata.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jul 2019 12:18:13 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41ba485ef1d0dca98c5b194b8fb19201e123a08d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
