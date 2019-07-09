Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D52DB62DA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 03:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfGIBpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 21:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfGIBpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:45:11 -0400
Subject: Re: [GIT PULL] x86/platform changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636711;
        bh=fgJlOy8iGl2AokGZp7DNgzjcWPyhr3Y9SV6LdKg2dmM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MV7Fca5jOMvHQ8Qu+fZmOs1UdFTRF3nDANhHK8p+f1XKfK8KTJDxMgwia6Z9Mq9Lp
         xT6TccLARyp9+VGeHDqvYLYLkSpbAuCfahymHxQNsRnIVyu5zxyimRag+goyJqX89e
         mw6jif1JHL/HYQuFUGaJq61jB3PEU1SgNGO2/Axw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708161951.GA27443@gmail.com>
References: <20190708161951.GA27443@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708161951.GA27443@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-platform-for-linus
X-PR-Tracked-Commit-Id: d97ee99bf225d35a50ed8812c3d037b2ba7ad2ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8faef7125d02c0bbd7a1ceb4e3b599a9b8c42e58
Message-Id: <156263671127.17382.16635578012276290819.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 01:45:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 18:19:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8faef7125d02c0bbd7a1ceb4e3b599a9b8c42e58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
