Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD02F62D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 03:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfGIBpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 21:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfGIBpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:45:06 -0400
Subject: Re: [GIT PULL] locking changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636705;
        bh=+GPAZg4Y8mf4kxQTGgapsdz3fUid/7IC4kwCpo2ZurE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zC8gfxGPUfLUorqOCHm60DnCw6tlPNyI/J+17Kmo8PryS6TN+uDnlWouHE4qMXOZl
         OBX6mhKzFtcYMwN+/isGmqojiy/PucWJIyzWrQhN+MP8VCPjOD9n+y7Cn7uv+Tgz3k
         mgHfTxoxTEF0enhM62c3CBd3Vj75DmVSsQJTLk0U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708093516.GA57558@gmail.com>
References: <20190708093516.GA57558@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708093516.GA57558@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-core-for-linus
X-PR-Tracked-Commit-Id: 9156e545765e467e6268c4814cfa609ebb16237e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1928328699a582a540b105e5f4c160832a7fdcb
Message-Id: <156263670579.17382.15644756693175491737.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 01:45:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 11:35:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1928328699a582a540b105e5f4c160832a7fdcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
