Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 353D11600A8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 22:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgBOVZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Feb 2020 16:25:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgBOVZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 16:25:20 -0500
Subject: Re: [GIT PULL] scheduler fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581801920;
        bh=8ZzORq8xQDajVvQ9zN0c33Y7bZj/5vfa6X27C16Yb0M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jx+ENScULoKT+EIHh7XrfeufMk8pOoNIdscXJn7IJw+K4IHHL3djWkZfVh9gzPRV4
         +3WIc8WqhD647wlLr//A+7vIH+Rb5kxKpQxzSli3olNfz6wL95YBEQxCyiyUvyqig6
         QxaIIDB+NTLCmbNiLgp6UN0pFCiTQUbIuEDGxvVE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200215094417.GA102800@gmail.com>
References: <20200215094417.GA102800@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200215094417.GA102800@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: e9f5490c3574b435ce7fe7a71724aa3866babc7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef78e5b7de5da49769c337a17dcff7d4e82ee6cd
Message-Id: <158180192023.10388.13140563515672343130.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Feb 2020 21:25:20 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Feb 2020 10:44:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef78e5b7de5da49769c337a17dcff7d4e82ee6cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
