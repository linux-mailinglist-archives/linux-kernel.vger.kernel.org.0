Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE42227EE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2019 19:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfESRpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 13:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbfESRpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:45:22 -0400
Subject: Re: [GIT PULL] core kernel fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558287922;
        bh=QLGszTG7I/Q5XYl+l5hCMVAzmBNyDICkQQxl85wqXl0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qflaWYxh1M4+nVL6kMyZo+xaqq/lSHJnpCLMAI3aKby2uelcCMqAcwaOQ7ADcGskj
         zhgVY+EkbxnWaptdW5F4NxPmU+qV4sR2G58mUusA3ZzoT7RK81ttlQKMkVEf0ifabF
         hynSgUu8rx+FaeCEofRVwPT7fgPZPTLd8p1ONi4c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190518085111.GA45888@gmail.com>
References: <20190518085111.GA45888@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190518085111.GA45888@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: 8ea58f1e8b11cca3087b294779bf5959bf89cc10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1335d9a1fb2abbe5022de3c517989cc7c7161dee
Message-Id: <155828792237.9186.14245348346410633858.pr-tracker-bot@kernel.org>
Date:   Sun, 19 May 2019 17:45:22 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>, Dave Hansen <dave@sr71.net>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 May 2019 10:51:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1335d9a1fb2abbe5022de3c517989cc7c7161dee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
