Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F7D169A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 19:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfEGRzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 13:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfEGRzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:55:04 -0400
Subject: Re: [GIT PULL] x86 FPU changes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557251704;
        bh=Y1b8xY0c/spqs+BJnAyAoYQDlLG6WCWT2jxAwob5C8k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NO6i/lJR5Z+qYObb1lzqrRa20psJ1RWpUTPcMWbMmsOL4upbFvUze3wYoIH0hHr/s
         i4S5YnDsu7g6liCC/sUpRjNANKiCIgg2Q5a3svPFjPkE+q/MJ8e5bHxAgCJE41QPcT
         Y+eeILLu+cAKOvNnsdNajLOcL3oo+zDltYzLxNSs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507132632.GB26655@zn.tnic>
References: <20190507132632.GB26655@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507132632.GB26655@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus
X-PR-Tracked-Commit-Id: d9c9ce34ed5c892323cbf5b4f9a4c498e036316a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ff468c29e9a9c3afe9152c10c7b141343270bf3
Message-Id: <155725170435.24816.11533088367798432294.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 17:55:04 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 15:26:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ff468c29e9a9c3afe9152c10c7b141343270bf3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
