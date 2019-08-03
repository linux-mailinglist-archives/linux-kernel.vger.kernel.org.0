Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3774E807B4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 20:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfHCSZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 14:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbfHCSZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 14:25:12 -0400
Subject: Re: [GIT pull] timers/urgent for 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564856711;
        bh=LMthmdbM1K76gB+Mn9DMZMCihNDZ358uu0aC5W5rKXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=saBVH2y5i/f6Jyh7+Ym2qnPZTTjl5QkQFG5BnyliYXqyre7kUnL9qS8XEHyRKg1ds
         /uvQ4UUxwlZ0emBtvoTDVfc8R7fSyPprDtji8BqYn56pOT/3jsKQjaPKfxiTn7JRSK
         7h6Y4bmKHrSV1A1vwxrcM2C3ve6Z4G5rCBdiVN/g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156485021326.28964.11252649669292370361.tglx@nanos.tec.linutronix.de>
References: <156485021326.28964.12573754498454150320.tglx@nanos.tec.linutronix.de>
 <156485021326.28964.11252649669292370361.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156485021326.28964.11252649669292370361.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: 33a58980ff3cc5dbf0bb1b325746ac69223eda0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0432a0a066b05361b6d4d26522233c3c76c9e5da
Message-Id: <156485671141.25774.6566940390178800355.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Aug 2019 18:25:11 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 03 Aug 2019 16:36:53 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0432a0a066b05361b6d4d26522233c3c76c9e5da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
