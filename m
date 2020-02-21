Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52C16890B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 22:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgBUVKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 16:10:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbgBUVKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:10:20 -0500
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582319420;
        bh=NYHgWOMgL8iR3nH6bjOS8kfZDfOrQgikwUAgXRIfFGA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CmldGhkvwoBBhXgy/HjF6Rtsv8e4/d9BuN6GBZLiIyds2UpbYy1EIQwLRnrIXalaC
         CTHxHdNZ5/PO9vn2QiTWH0NTzfm8eer0hLkgXXrQFENGcirBZyIXu8OhutUH9E8S22
         KvU5tape3APdcbbHUa/WbU2QeJ4zMvJ4ShtXFESo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200221113929.GA114227@kroah.com>
References: <20200221113929.GA114227@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200221113929.GA114227@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc3
X-PR-Tracked-Commit-Id: 07e6124a1a46b4b5a9b3cacc0c306b50da87abf5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef11f1b76a59833cfadbe88a9513ca01b14a2b88
Message-Id: <158231942013.18249.13521960133083126053.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Feb 2020 21:10:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 12:39:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef11f1b76a59833cfadbe88a9513ca01b14a2b88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
