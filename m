Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304042E795
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 23:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfE2VpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 17:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfE2VpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:45:15 -0400
Subject: Re: [GIT PULL] tracing: Avoid memory leak in predicate_parse()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559166314;
        bh=una0/e/8ySmlj4JhQmei5RgTXmPxhXe5myJTjKTrpTo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HWFIQZ+NGH+ALEaMlTs1wgDAjjE3OG4hpDuq7ZaOsA66Wdg7rTbsws2Zv20nKYFt5
         twvIocejfFDS5n+8582cudo0rbYX46kFKLfUfz2h5bE++7nUsEE8Szi0ZyFOv+ULB0
         9YiHNhRADIBo6oCIvYtvCs0v/g56vrJsBUdf5Fyc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190528225834.7428baf9@gandalf.local.home>
References: <20190528225834.7428baf9@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190528225834.7428baf9@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.2-rc2
X-PR-Tracked-Commit-Id: dfb4a6f2191a80c8b790117d0ff592fd712d3296
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e82b4a91d46a690de3cbbe6960667caa508b27a
Message-Id: <155916631448.28954.7396701337136352142.pr-tracker-bot@kernel.org>
Date:   Wed, 29 May 2019 21:45:14 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tomas Bortoli <tomasbortoli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 May 2019 22:58:34 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e82b4a91d46a690de3cbbe6960667caa508b27a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
