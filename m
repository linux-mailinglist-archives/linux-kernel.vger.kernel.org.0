Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB7C21566D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfEFXkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfEFXkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:08 -0400
Subject: Re: [GIT PULL] perf updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186007;
        bh=fMxr4XCRroVX8MNprbGIlHphkUhCBJEyGxyv0i04rh4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KueRGipvu53LZ3Ih2Lz4mBTMsdchNxIuDko6Z56U0xEGzhA/OijX/8gMtRWQLT7YP
         gVQWYmzMA1vAOzD3w+Bj2lYiSjJYFqaRYPn4uc1kZ5K3bOMwZJthqjeqPsnkiPpFsj
         E+JY2euMDr+9QlRF7Xl70LUnZIe3tpgZJ9lcEKU0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506090311.GA80882@gmail.com>
References: <20190506090311.GA80882@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506090311.GA80882@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus
X-PR-Tracked-Commit-Id: d15d356887e770c5f2dcf963b52c7cb510c9e42d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90489a72fba9529c85e051067ecb41183b8e982e
Message-Id: <155718600783.9113.6377920563369095294.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 11:03:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90489a72fba9529c85e051067ecb41183b8e982e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
