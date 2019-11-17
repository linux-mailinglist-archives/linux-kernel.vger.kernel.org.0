Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A908DFF632
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 01:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfKQAfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 19:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfKQAfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 19:35:06 -0500
Subject: Re: [GIT PULL] timer fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573950905;
        bh=uQaQbkC+3iH865hWeSZHC2kBKlzRUyZgz8Qck1QnomM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M1ft2UGA+lo/oP/lg8fqeamCJTf7n0hE7hu5CCahAoVItIpICn0w60C6//oMavt6Z
         6vb6tZV81SpldyqMxL4Tj1lbxoG2nBgn/TC0lCmpuG2rKqdonAgIjzU/QfrPfqP2t/
         i26gMv4u1PxsjKV7aG4YbXhsmPd5fqbwV+U40pvE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191116213854.GA48947@gmail.com>
References: <20191116213854.GA48947@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191116213854.GA48947@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: 2f5841349df281ecf8f81cc82d869b8476f0db0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3278b3b6782c562079a3e0af0979968fd94d141c
Message-Id: <157395090587.15664.3874771514591627307.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Nov 2019 00:35:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Nov 2019 22:38:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3278b3b6782c562079a3e0af0979968fd94d141c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
