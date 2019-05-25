Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4562A5BD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 19:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfEYRPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 13:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfEYRPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:15:16 -0400
Subject: Re: [GIT PULL] tracing: Small fixes to histogram code and header
 cleanup
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558804515;
        bh=Fofcl6DmVUOl+lJDqFJo8WC+beUfOCsjhLv45NXAI5M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RAdAj/NmNHW2OfKBkbEHrrbdd51Na8jsyNkXm/eEg3aLjc8z1uEV7fIOK6wY95582
         dFZC0SOPAAV4AzwCwlM3Wqb4TZgsmTn+z+O1MC45yFLlErMFKReU9qEJkEUtc21uMt
         Z0Fh8gf3F3PZ2ldZ1p5ZXlSs9PO9c0UR+LhfwJgo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190524231106.5812936b@gandalf.local.home>
References: <20190524231106.5812936b@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190524231106.5812936b@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.2-rc1
X-PR-Tracked-Commit-Id: 4eebe38a37f9397ffecd4bd3afbdf36838a97969
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2c48d98fc0770f7993cf61c71659a99e1d2857e
Message-Id: <155880451585.5068.11563167581064671995.pr-tracker-bot@kernel.org>
Date:   Sat, 25 May 2019 17:15:15 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 23:11:06 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2c48d98fc0770f7993cf61c71659a99e1d2857e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
