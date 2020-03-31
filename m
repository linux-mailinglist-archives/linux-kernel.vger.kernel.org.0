Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B985D1988DF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 02:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgCaAZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 20:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729648AbgCaAZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:25:13 -0400
Subject: Re: [GIT PULL] scheduler changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585614312;
        bh=iw7Z0AIQsg2l4FInJKgHqE43QtRw5KyJL/+lQ4I2eC8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WnTQ0KBhIzzVNgKAfAYCTJpvUxYpK3K+9Wmc9sKHmGbLCUoiYRL0D+sCUbriEAKy9
         ncP0c7aNpv3qdlWOxVx14LOZ6ZPkJBRQzoDYN8Y7ujRtW+xxycCgvKOHT8y9Q7NOj0
         poRoAv2OuHln6YklhtDAiKjB95jogj5KlX100mvs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330173159.GA128106@gmail.com>
References: <20200330173159.GA128106@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330173159.GA128106@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-core-for-linus
X-PR-Tracked-Commit-Id: 313f16e2e35abb833eab5bdebc6ae30699adca18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 642e53ead6aea8740a219ede509a5d138fd4f780
Message-Id: <158561431275.380.11330233809755788411.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 00:25:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 19:31:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/642e53ead6aea8740a219ede509a5d138fd4f780

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
