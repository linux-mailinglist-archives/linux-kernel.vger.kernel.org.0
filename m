Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4141F20E88
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfEPSUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 14:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbfEPSUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:20:24 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558030824;
        bh=tGTP9e1YFj3Ieli5Jyu0UGjhzoDCJS1HGqDFUcSb5WE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uQZQ0uVQMmt6NlQEV/17UNeMqnNd/ZeuUWd9Jhf4CJX8/FAINun8jXCq+4+5LvRB4
         L00dziz0fKpKuoagkp8b4dFMlz2hV97vcv7vziYX9/0LxGgd5jFC31jB4obmEb/zMo
         tXjGNOCkQXG3GvW0zIC76SZSgRG4bDp0gyXTW89k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516160518.GA46645@gmail.com>
References: <20190516160518.GA46645@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516160518.GA46645@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: c7a286577d7592720c2f179aadfb325a1ff48c95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c77ee64f8a04166236666dfd540ff684d2daa1c0
Message-Id: <155803082411.23531.11832173309929693601.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 18:20:24 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 18:05:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c77ee64f8a04166236666dfd540ff684d2daa1c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
