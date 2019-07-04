Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8D5F15D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 04:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfGDCPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 22:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfGDCPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:15:05 -0400
Subject: Re: [GIT PULL] tracing: A few fixes for this rc release
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562206505;
        bh=GtkGwuzlTR3qoZ7XmzarVJq+oQtysQ/ufXHEUiolYh4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zY4M7iKLwFN5/LSuExUJO3u+EP77gmvTqalpraU43L/GbvP0bkjztZR0hhCY+hwu6
         d7grcvt9yyjFFlqXpjqfwLaznmmArd26uzwBj99ztiwrX+7BahQ+Z5wy2p/wdnsa6h
         lzbfA7Qy64yLYWp05TH3TMMEc3exa/1CW3Bgalig=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190703105511.263ffd56@gandalf.local.home>
References: <20190703105511.263ffd56@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190703105511.263ffd56@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.2-rc5
X-PR-Tracked-Commit-Id: 074376ac0e1d1fcd4fafebca86ee6158e7c20680
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 550d1f5bda33fa3b203d8cf8df1396825dbfd213
Message-Id: <156220650524.16688.4067784535195615564.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jul 2019 02:15:05 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Jul 2019 10:55:11 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/550d1f5bda33fa3b203d8cf8df1396825dbfd213

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
