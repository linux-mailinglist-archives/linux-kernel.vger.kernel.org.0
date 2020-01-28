Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7217414C0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 20:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgA1TKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 14:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbgA1TKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:10:05 -0500
Subject: Re: [GIT PULL] objtool changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580238605;
        bh=OqFMcHFtkk4/HMA4a/9a4t+73KkjLWmrdctNpRO0894=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hFFxj6y/ftvei06znvM+p1zV6C1V+CEjzloJyxUY7iIWQ0ZPXgdj8COBr24M9HPFy
         pH/CuSKGHd7CTBT8Fja9TKuF5RRGiNc410BuKEOB4KB+aqjIxJoHPz1Ibb6MuF5/z9
         huqq4qn5eKmq//J+U755AY+nF25/8nncqlO4h6VU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128070844.GA6655@gmail.com>
References: <20200128070844.GA6655@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128070844.GA6655@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-objtool-for-linus
X-PR-Tracked-Commit-Id: 22a7fa8848c5e881d87ef2f7f3c2ea77b286e6f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b561778f29766675e88566215aa835fff9dc1f7
Message-Id: <158023860505.9583.12073470521850108384.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 19:10:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 08:08:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-objtool-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b561778f29766675e88566215aa835fff9dc1f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
