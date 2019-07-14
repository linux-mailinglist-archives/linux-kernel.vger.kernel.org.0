Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A3680CE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfGNSpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 14:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbfGNSpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 14:45:15 -0400
Subject: Re: [GIT PULL] locking fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563129915;
        bh=/LBQt7u9KtipIw8KosrbsLJpq56zku/rW/i9L5d32oo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sMipD+pCAumCuwdnACJCBeiH2KNZ8JRy+KGz7l15vKATXpXqKdNs/LjCkaUvuP99k
         xADrTB4zEP0TwtCGvmJH/OQH8Caofx6BFnFtENoApqcEY+dFomgNiMm773urWoGQO+
         Aw3ndSMI7fiuSsNjOnR69TviBO9lvyPeBRMO6u50=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190714113621.GA58788@gmail.com>
References: <20190714113621.GA58788@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190714113621.GA58788@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: 68d41d8c94a31dfb8233ab90b9baf41a2ed2da68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c85ce135456a3927f552e738f730c47ac905ac3
Message-Id: <156312991510.23515.9107940505093645984.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Jul 2019 18:45:15 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Jul 2019 13:36:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c85ce135456a3927f552e738f730c47ac905ac3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
