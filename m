Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A929015664
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfEFXkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbfEFXkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:16 -0400
Subject: Re: [GIT PULL] x86/cpu changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186011;
        bh=dXF76D2Cf46yted5R+p3MPfa6cCBuIg334LYs1KEZks=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=h3BKPp1nKXzYSpGIN/I72/w5L9XvGxyf2Uydau5xiY+78qpikhFJD8T1BrHjhlyg5
         b3HeihqPPueVOt5l7fdkM4XKwJo4LHJzk9D8+EElxg1fd766Dv6T8k0GPkp4aCY4NO
         yZBRhKDE2r3eD26m8I+wxC9OI3U0TnG5kKhBMT9M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506101454.GA38212@gmail.com>
References: <20190506101454.GA38212@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506101454.GA38212@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus
X-PR-Tracked-Commit-Id: 987ddbe4870b53623d76ac64044c55a13e368113
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31a4319b68c0e0097fa0c754ec9d9e54115a76eb
Message-Id: <155718601164.9113.8242756793885067346.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 12:14:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31a4319b68c0e0097fa0c754ec9d9e54115a76eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
