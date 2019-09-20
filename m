Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72B1B9794
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 21:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406869AbfITTK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 15:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406836AbfITTK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:10:26 -0400
Subject: Re: [GIT PULL] tracing: Updates for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569006625;
        bh=7R4dqLkTJ8zK5OyfxyS5qWGn69h9S3ZibV4V9NNIDsU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=p/Mzhc7Hwn7Bj1+rF3bVWppMDU1fEJo5a9LyRXWndNiGHDeP+8Br6eTOchHW+Rt9t
         ivm1z8kfD16uiQJndMbE0RoLYEYlnBMIDG/qbMJeXxg7jC7NjPGXkisLqhZbDOBhZp
         JgfVUn00XnR+d8ckPC9ZS0oVp5a9rVbRppVugStg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190919212011.5afc196d@gandalf.local.home>
References: <20190919212011.5afc196d@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190919212011.5afc196d@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.4
X-PR-Tracked-Commit-Id: b78b94b82122208902c0f83805e614e1239f9893
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45979a956b92c9bab652a2c4a5c39d8f94f6df2c
Message-Id: <156900662574.23740.14766150327447417043.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Sep 2019 19:10:25 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 21:20:11 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45979a956b92c9bab652a2c4a5c39d8f94f6df2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
