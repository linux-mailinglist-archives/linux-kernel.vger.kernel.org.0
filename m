Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E366D4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 21:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391264AbfGRTZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 15:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbfGRTZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:25:16 -0400
Subject: Re: [GIT PULL] tracing: Changes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563477915;
        bh=1jPQwwCs25xZMb+U2J5sCfiwGNe5LOA1mzGFe+EzyE0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d2LJ0/OAZ35qfslMdOLcgZWrHMR93vzkUq4ayIiJR/Pm8jlIVqmyvP+eyokvoQ8Rk
         8/aAlHMIR6+PWy8xalyvNUkrC4vcZwTODmXiw7MXIwoiMFSo3RHilnRvaXs4uEQZ2k
         c9JhnA0c251rdZ6d5Jl9t5FFjawSDZdlGq4jhNaA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190717112918.06d934dd@gandalf.local.home>
References: <20190717112918.06d934dd@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190717112918.06d934dd@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.3
X-PR-Tracked-Commit-Id: 0aeb1def44169cbe7119f26cf10b974a2046142e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 818e95c768c6607a1df4cf022c00c3c58e2f203e
Message-Id: <156347791566.32127.3004758995140924953.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Jul 2019 19:25:15 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Jul 2019 11:29:18 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/818e95c768c6607a1df4cf022c00c3c58e2f203e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
