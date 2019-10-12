Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E79D5315
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 00:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfJLWfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 18:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbfJLWfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:35:06 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570919705;
        bh=Aq56aePwwx3GSJFXv8uk039XShbfsBtA6sUgCRUvGTI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2XbRpWbPwi2EvVI23VDnnfF4Kw+PTwGAv6KUY/E6qgNiF1AEMIqx5Uwj9YybHieGk
         T2TtTH/rkYjtgXAWASTJDSy7wedXvrnyBTnV8wOYdnbt9kWTohW2QYl2ZgbfktyLD1
         zvDmUA0rYDXNlxCxzmAmkINwtYjWDWubgBpDiJl0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012133134.GA101218@gmail.com>
References: <20191012133134.GA101218@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012133134.GA101218@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 52e92f409dede388b7dc3ee13491fbf7a80db935
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 465a7e291fd4f056d81baf5d5ed557bdb44c5457
Message-Id: <157091970565.17047.9311008417292743791.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 22:35:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 15:31:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/465a7e291fd4f056d81baf5d5ed557bdb44c5457

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
