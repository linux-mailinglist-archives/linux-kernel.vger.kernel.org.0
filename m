Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D210F9C531
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 19:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfHYRkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 13:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728660AbfHYRkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:40:08 -0400
Subject: Re: [GIT pull] perf/urgent for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566754807;
        bh=0K+9YbNjzIExNJnS44VTb3ggOLH/GwZ1nY71ZopQOw0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xnFekjW4iQGkHTXFLf1nYPXxPRyFDRKJynV7iSQpQdAVJNPHAcLZ4tGm1Zr2UuCYR
         OdPaSd32cKKdTk7m3E5i3eEKHfkyELrR7g32PczwveejqeS7qt8qifwN7JdX4rNi8O
         PMq2ni6Awv/3lgrmZU4icYN2ZsYbfngwAN7D1VL0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156672618029.19810.8453030714221422841.tglx@nanos.tec.linutronix.de>
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.8453030714221422841.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156672618029.19810.8453030714221422841.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: f1c6ece23729257fb46562ff9224cf5f61b818da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05bbb9360a000f509537a84554d69fb891fa7332
Message-Id: <156675480757.29384.17831955844204907489.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Aug 2019 17:40:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Aug 2019 09:43:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05bbb9360a000f509537a84554d69fb891fa7332

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
