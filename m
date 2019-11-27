Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C071010A7F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 02:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfK0BaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 20:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfK0BaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:30:16 -0500
Subject: Re: [GIT PULL] scheduler changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574818215;
        bh=ui2kbH6PhSAotheDzfgbOUYiathAWgpi16xECdEqJh8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Fs82g3Om9TNiyWMy6xvr8w31ALn10Wa8Chv1KBUBjb6nNGJik+vvWu0aiXxWEWzUh
         qmQTBa66vQYLHjgiUu5txCBfyaBwT+uODJAyhfMcLPFjcBhjbsf08unQsGGR9OzCAz
         EN0ssIzZ5XRqJyii93QteH2fqz+HObVsiUfihJNE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125125944.GA22218@gmail.com>
References: <20191125125944.GA22218@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125125944.GA22218@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-core-for-linus
X-PR-Tracked-Commit-Id: de881a341c4143650fa50ce95cf450a5c94faa9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77a05940eee7e9891cd6add7a690a3e762ee21b0
Message-Id: <157481821578.26353.12456507053863410969.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 01:30:15 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 13:59:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77a05940eee7e9891cd6add7a690a3e762ee21b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
