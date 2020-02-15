Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B61600A7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 22:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBOVZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Feb 2020 16:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgBOVZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 16:25:18 -0500
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581801918;
        bh=fPP7yJYCvLi2TK3zlW//4tloB0mKikOCRSbh4oIOQ+8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H0mXHDCD0tFGtp5blvqw9Tv6v6eKRQSrpWHO5bvt+Ss7I9GXBMRKEyIgMPoZ55QED
         56aOD/wzH84cSjuPdUmo5AJUYuaGUPj4wYpgkrtXFm+f81Yj1LpBoNbm6H0uJzrbi0
         CccesRu3NAekEZmJExpSb+aKokQLbU5EXlUwv6xw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200215085316.GA12477@gmail.com>
References: <20200215085316.GA12477@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200215085316.GA12477@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: dfb9b69e3b84791e4c6b954ac3cc0c4a545484f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da99f9355b53ebc565747d0072ff038f3d9fa875
Message-Id: <158180191840.10388.14357198641955865109.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Feb 2020 21:25:18 +0000
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

The pull request you sent on Sat, 15 Feb 2020 09:53:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da99f9355b53ebc565747d0072ff038f3d9fa875

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
