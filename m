Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C820182372
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 21:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgCKUpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 16:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbgCKUpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:45:10 -0400
Subject: Re: [GIT PULL] thread fixes v5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583959510;
        bh=n1xtT963Ze9x6xcOZWqOv7tuDm8DCoSaevBkcCJj0is=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hGXckjNj7rUYst0+YFtPws0PTbpRwbwvbnqqhefwKsvLBGYyEgfkn2UiVzO4RNObT
         kktpru0jcUml3py7hcu2oXUhGTSeDYkngwCPP8px+oTT6Lgr6w72vXxqvI76GRVnfl
         NZ93KSqjqkXN6aWYz/NkQFSvf/Nb9F5fM10WdWuo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200311154405.3137527-1-christian.brauner@ubuntu.com>
References: <20200311154405.3137527-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200311154405.3137527-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2020-03-10
X-PR-Tracked-Commit-Id: 10dab84caf400f2f5f8b010ebb0c7c4272ec5093
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: addcb1d0ee31aa1472a7afd31a63162423af9c93
Message-Id: <158395950996.14877.17485207481328452926.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Mar 2020 20:45:09 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Mar 2020 16:44:05 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-03-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/addcb1d0ee31aa1472a7afd31a63162423af9c93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
