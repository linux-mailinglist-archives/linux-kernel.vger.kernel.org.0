Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1078C948A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 01:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfJBXAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 19:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJBXAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:00:17 -0400
Subject: Re: [GIT PULL] membarrier fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570057217;
        bh=vONXL17em5UB+nro01cYXPD21vKvunDRIiy41UJNEbo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rJ9SewITYFN5sKku/qiZwBCrkTisNOav0imiBHx5jCQt/ho+cMCcDELSkZyjJXol2
         oPjUCyMcDXqWQYwmko8DIFaR/a7X+VSDbaEksmMyfrdHBiupHDhptq4QVdd3ma46Xo
         tlTPaZkBbwbs0l9qmhz7zLvmMyuJw+Y7ec/66Z8U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191002220406.GA50484@gmail.com>
References: <20191002220406.GA50484@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191002220406.GA50484@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 73956fc07dd7b25d4a33ab3fdd6247c60d0b237c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 714366f87336b2a3f1cca9a6ba8632d6403283ad
Message-Id: <157005721714.372.7336279851109350503.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Oct 2019 23:00:17 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Oct 2019 00:04:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/714366f87336b2a3f1cca9a6ba8632d6403283ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
