Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16444B56BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfIQUPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 16:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfIQUPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:15:17 -0400
Subject: Re: [GIT pull] timers/urgent for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568751317;
        bh=maR3imO56er/bQiue8LKfdIegqeTtGTkJ9VsZPZIjP0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EGDep1+FCtXdNsg5LVDqkG674IE5Vc5HiCzslyPtH2gCofeQKwxxMk8zYRwFRefBd
         qHAyxiUAde048uM9OiMgwRi8d/G4OACHhkVnzVdh7/XK0I2BqhBw91kUf6QQSWuBcH
         lfI8B20cTYgiil7DdTWMDOAxbc1t8gg1DqEn+7tM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156864062018.3407.10822767012822306757.tglx@nanos.tec.linutronix.de>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062018.3407.10822767012822306757.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156864062018.3407.10822767012822306757.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: f18ddc13af981ce3c7b7f26925f099e7c6929aba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16208cd6c36ac558c2c09042feb2b61e1e58f78a
Message-Id: <156875131716.8483.9319184235002731121.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 20:15:17 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:30:20 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16208cd6c36ac558c2c09042feb2b61e1e58f78a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
