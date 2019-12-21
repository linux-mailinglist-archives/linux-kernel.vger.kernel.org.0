Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09D128BD9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Dec 2019 00:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLUXUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 18:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfLUXUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 18:20:10 -0500
Subject: Re: [GIT PULL] tracing: A few fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576970409;
        bh=7PU+IC2ftJv4IpkOKkabGUsgEdOCW0vFrf51greU1oE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UpJt83ff4f6L/Jv0PvP/DxQScrWwFlx90ieqinKu9Lc9TSGKObD309pJl7PnG8++K
         /FRYkLE7NG4EUacUxVssOLeaik2UPWHQbdwIDwivtgbu0OjWrQtvHurr5o9UvNm0Ne
         2Xs33K+5Fm++cefXb8/yTxqMyMKPWhDxtasH/gz8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191221163555.29d65de5@rorschach.local.home>
References: <20191221163555.29d65de5@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191221163555.29d65de5@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.5-rc2
X-PR-Tracked-Commit-Id: fe6e096a5bbf73a142f09c72e7aa2835026eb1a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8e382a185ebb1bca66bd541e5a0f858b6b9cbb9
Message-Id: <157697040965.14543.14013749985208561966.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 23:20:09 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 16:35:55 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8e382a185ebb1bca66bd541e5a0f858b6b9cbb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
