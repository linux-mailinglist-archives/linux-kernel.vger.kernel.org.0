Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90217C282F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 23:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbfI3VGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 17:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732520AbfI3VF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:05:57 -0400
Subject: Re: [GIT PULL] tracing: A few minor fix ups
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569864623;
        bh=LNR0G/DXOEY1E2YQhpWP3O9g4+p02Nf79w8Cp8UzHyY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y86IIwuGY0snclv8TeabZK+7QFjE1fDUQRQw3fgfPAFCEL0UFaxSCG3S4hMCQHuoy
         vqLEXRJWmT9ZyWYQaRl/3dMPtwVbvrnHCeASbxUDQN0rpboCbKtkfhcXrOPF72A5EW
         wycIYCEp/2X2kianIcVYM49Ceo6nmBvHGVmJBQac=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190929161715.17a2b179@gandalf.local.home>
References: <20190929161715.17a2b179@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190929161715.17a2b179@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.4-3
X-PR-Tracked-Commit-Id: 8ed4889eb83179dbc9a105cfed65cc42ecb61097
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf4f493b102399adea3cf65cdde7161c17fb605c
Message-Id: <156986462292.9141.12980338735106519474.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Sep 2019 17:30:22 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Sep 2019 16:17:15 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf4f493b102399adea3cf65cdde7161c17fb605c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
