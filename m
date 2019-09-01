Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E24A4B2A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfIASaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 14:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbfIASaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 14:30:09 -0400
Subject: Re: [GIT pull] x86/urgent for 5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567362608;
        bh=8Gl8QD30ifFi9NGflENxuMM7k/Z9Dgf/VH8ppTWZL6E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=za4oA3VWR0iRU+CkK1DyLVIdvcw/lu226WRIalvumUJmPvltgARWujiX8SRpDzBfi
         FWlT7xdz1lWdKApLzbt3JdyMz3OpwGitAt2bDfFlrqinELNiHOu6YB7y3z6szFr0Gy
         CFyTKeJ4wKi98xpdkurinlOoaafjz4162wMLzioc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156731805398.16551.14162357872200269955.tglx@nanos.tec.linutronix.de>
References: <156731805398.16551.16721065723173566021.tglx@nanos.tec.linutronix.de>
 <156731805398.16551.14162357872200269955.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156731805398.16551.14162357872200269955.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 7af0145067bc429a09ac4047b167c0971c9f0dc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f159ae07f07fc540290f21937231034f554bdd7
Message-Id: <156736260839.26191.791674724848261400.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Sep 2019 18:30:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 01 Sep 2019 06:07:33 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f159ae07f07fc540290f21937231034f554bdd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
