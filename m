Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA4F63C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 21:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfGITzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 15:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbfGITzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:55:10 -0400
Subject: Re: [GIT PULL] perf changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562702109;
        bh=oJP5RIZwuBnmYdm6MfLaNU2wznL77jDOaUf6EIPlhVo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YjsMixOsiDiBibMPplX2yamz2oiTDmjcZY75Sv2+4sEam5tZWCj+dB9PO6W0eLw+l
         sGRqnAhzpN+vKKc1+dTK4BV36bZyaNn/V0y1LkAs9mOhYajCq5g1WAFH4PJJlU7uCv
         Px+Kz7xz5GI99kxg16/I6hULB2atQXUSTg9KzfSg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190709113819.GA97140@gmail.com>
References: <20190709113819.GA97140@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190709113819.GA97140@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus
X-PR-Tracked-Commit-Id: d1d59b817939821bee149e870ce7723f61ffb512
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 608745f12462e2d8d94d5cc5dc94bf0960a881e3
Message-Id: <156270210969.21525.469833570686987483.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 19:55:09 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jul 2019 13:38:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/608745f12462e2d8d94d5cc5dc94bf0960a881e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
