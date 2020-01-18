Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6524D1419C2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 22:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgARVFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 16:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgARVFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:05:06 -0500
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579381505;
        bh=0JrYfAiZwU5PTmw/1JuchdxouxtQX9QDVl3RgLS4Otg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ntc+TzOJWnnsOBYyKs9qEqprftd5862i2frqwa+dJ4lhDa+EBouPbpLODcK2/Giu6
         SlvmDxrutjaj5AUswrNpcErqWwqQWJhkTMUlOUPciYTHh7Jbbr/K29r6t/cTJ1Yr/D
         yixUQqZyl//PD3ev0SGteffCwvCrW10nn59Vr+SI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118175828.GA88066@gmail.com>
References: <20200118175828.GA88066@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118175828.GA88066@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 2167f1625c2f04a33145f325db0de285630f7bd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b07b9e8d631856c9e42af79900527509449206f4
Message-Id: <157938150552.20598.14405727147418549848.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 21:05:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 18:58:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b07b9e8d631856c9e42af79900527509449206f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
