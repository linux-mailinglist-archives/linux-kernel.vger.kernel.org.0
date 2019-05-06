Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735F31567C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfEFXlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfEFXkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:05 -0400
Subject: Re: [GIT PULL] RSEQ updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186004;
        bh=aCGLvqapF88okb0ZM+5qI7MIXLjg0EoHXvxKaSDB8Sk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=we+bGTJM9aPsWc0AGSSPyOJYWxSA9/pBd52epbQVp6L5uVmy94jm2kBL5CalBRD2P
         9FJvskn7K3Qhi3FCLHpsTbz62/xV01Udx9Ebb8Y5WVO8SmIHwokAsgGT1MRUo5kWWc
         jhy7ekESHjidR9xT0dw76Vymn0WJVBqN797nnGj8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506075842.GA110441@gmail.com>
References: <20190506075842.GA110441@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506075842.GA110441@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rseq-for-linus
X-PR-Tracked-Commit-Id: 83b0b15bcb0f700e7c1d070aae2e7841170a4c33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e50c5d2e725eb7192a62868d4a9987907741ff62
Message-Id: <155718600458.9113.660480017624596526.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 09:58:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rseq-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e50c5d2e725eb7192a62868d4a9987907741ff62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
