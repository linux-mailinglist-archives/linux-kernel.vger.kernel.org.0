Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768252AC3A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 22:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfEZUzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 16:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfEZUzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 16:55:16 -0400
Subject: Re: [GIT PULL] tracing: Silence GCC 9 array bounds warning
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558904116;
        bh=/H7uxVL9awMSDggfOGyEIDWeYsAR+RrQ+J5XCiXxqk8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pDg7Kv58aV/GlfNffvoCWPvRVmM4f+fNAHyDyxg1u4pW4hJ1PyquoHjedRY1fnOgn
         XAoOXw9accDZkGVQe7Ho/4GTUsZQrryVLBmulkN18NtFt2H/2IFPTNMuFkNuXZf1Ex
         x0NUHBb10jju4HoHUv95ulfK6TCZP7DTWujncTp4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190526151548.2d7bc6bc@gandalf.local.home>
References: <20190526151548.2d7bc6bc@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190526151548.2d7bc6bc@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.2-rc1-2
X-PR-Tracked-Commit-Id: 0c97bf863efce63d6ab7971dad811601e6171d2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5b440951a19fdd068090d38dcbe72ea28e5e0d0
Message-Id: <155890411612.17135.1655610194955413344.pr-tracker-bot@kernel.org>
Date:   Sun, 26 May 2019 20:55:16 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 May 2019 15:15:48 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5b440951a19fdd068090d38dcbe72ea28e5e0d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
