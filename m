Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18EB4502
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 03:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbfIQBAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 21:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387693AbfIQBAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:00:19 -0400
Subject: Re: [GIT PULL] RCU changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568682019;
        bh=4Fi7Q4akMuKB230KlbxHjSZ0yxIDktMbfmLEp7+kxD8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R2twZIk3NiDdyhRNd2+gMImvpUgWdFV7T6O0I325qeeCmwpebeBUA0Wx3TR7alTxH
         byIUILOBqTahprwjcD9O4NlZmBjSBGcQJ/orhGkxju3EG6FqU/6Tx/VfF0mpwHTotx
         OnsbFVASvSJJUqzXxW6vTquajb7wqxuyOqWpiits=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916112641.GA127977@gmail.com>
References: <20190916112641.GA127977@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916112641.GA127977@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus
X-PR-Tracked-Commit-Id: 4a0fa886ab79ea85e8d1be2b0df143d8249779be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94d18ee9340e00ee3455bb45661484093e3b2674
Message-Id: <156868201944.3683.5562827237146240964.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 01:00:19 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:26:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94d18ee9340e00ee3455bb45661484093e3b2674

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
