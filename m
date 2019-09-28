Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC8F4C122A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 22:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfI1UuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 16:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfI1UuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 16:50:23 -0400
Subject: Re: [GIT PULL] scheduler fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569703823;
        bh=jlhlkjjRQm+PDoEiCFnHa57XQq2DCbj0/++iL96fBv0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z08R07BOKzkjV9YA/1DKWyc45JgrsZGclsdpuXEj6gKWH5Jft1+IZkinoMgI8jiFz
         wdBEiHBtXq2HP5pkHX3WRd5T/GQvRVXqCHWHuZC6DXdXW1Ps4TeB611FizEevoik/a
         8//iIYe/OI/aSbmkCuMHlguIrsk6K32NEsNYua/k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190928123905.GA97048@gmail.com>
References: <20190928123905.GA97048@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190928123905.GA97048@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 4892f51ad54ddff2883a60b6ad4323c1f632a9d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c5efe9ae7df78600c0ee7bcce27516eb687fa6e
Message-Id: <156970382322.9125.3632092850439512798.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Sep 2019 20:50:23 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Sep 2019 14:39:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c5efe9ae7df78600c0ee7bcce27516eb687fa6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
