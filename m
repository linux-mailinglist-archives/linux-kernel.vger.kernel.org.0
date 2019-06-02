Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95DC3248A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfFBSPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 14:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbfFBSPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 14:15:16 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559499315;
        bh=mtOd0AZpbPOH9FwCCIC6oH0f/N6idUJfZ2UzJJSdSpA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IYy+CUkuAEo7Dt8iPePHcZOr5KlUMgYlwpXrEShdXJ1FM4lgTvMWDS0yOR9SPhimF
         bKz8DiSQEQbT+fcfrUArAwQyKU3juL444S66SPwq1uYL2QG/RE3llHj7nYAqtdK3BL
         Sz6NAPDvK8gC7ENyjmKzfk947o1pacvHGE8IF3Os=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190602173953.GA109592@gmail.com>
References: <20190602173953.GA109592@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190602173953.GA109592@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 849e96f30068d4f6f8352715e02a10533a46deba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6751b8d91af515a5dc5196fe305eee0a635e2ea2
Message-Id: <155949931564.4617.10259334963196169819.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jun 2019 18:15:15 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Jun 2019 19:39:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6751b8d91af515a5dc5196fe305eee0a635e2ea2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
