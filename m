Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E210A7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 02:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfK0BaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 20:30:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbfK0BaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:30:14 -0500
Subject: Re: [GIT PULL] perf events updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574818214;
        bh=Nd1Lxa5QpEAqGdE8u4raLOAC3/Z5t4tcpcRrgQCasjE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y5zJVpxVE8iip1dwkEl2Qf/WTzwXYgwSXu4mLVfNr1WK5hzGyxNEwXMmnR/7KEvKn
         jnmr9yTbFwW3aaWbmtegd7JXhEcd/+QLKd/f35JOxrABSG56EgU0QFIlMJUa0QOEbD
         uNNZL28w8R+9hMLmfVMQuCeKt+SrbBzLpg9u3mKA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125123215.GA41816@gmail.com>
References: <20191125123215.GA41816@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125123215.GA41816@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus
X-PR-Tracked-Commit-Id: ceb9e77324fa661b1001a0ae66f061b5fcb4e4e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f59dbcace56fae7e4ed303bab90f1bedadcfdf4
Message-Id: <157481821445.26353.2347531437623395504.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 01:30:14 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 13:32:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f59dbcace56fae7e4ed303bab90f1bedadcfdf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
