Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA523B10A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 16:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfILOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 10:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732084AbfILOFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:05:06 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568297105;
        bh=x2wJ/8kLKrOWhvcUZa3v/mabztyYtzLd4bnARPcCYVw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zhvVRwTwSoMsn3jrcwO9rMM1EC56x4mBCNdqbe11Fb2PwTyiETiHhOEnDKG9AwAzc
         2tNoEnfKOVGzgLvRPiVhMquCbjhAKNKNHDPhqxd19SKdsmu2ojSGVvn8v1FNntgWfa
         462SZiReFSGfmtE8RNL89fjL/Xb7Q1tcGVjHQ1n4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190912125710.GA21080@gmail.com>
References: <20190912125710.GA21080@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190912125710.GA21080@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: afa8b475c1aec185a8e106c48b3832e0b88bc2de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95217783b7f6f331e7a6675e0a31fb9a5a1b9a36
Message-Id: <156829710583.915.3788896406350040227.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Sep 2019 14:05:05 +0000
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

The pull request you sent on Thu, 12 Sep 2019 14:57:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95217783b7f6f331e7a6675e0a31fb9a5a1b9a36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
