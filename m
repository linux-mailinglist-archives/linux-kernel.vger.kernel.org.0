Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A501986D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 23:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgC3VzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 17:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbgC3VzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:55:10 -0400
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585605310;
        bh=2FIyq9wqxZZE6zdxRSIKeR2d4cRHgtr9CeYud71SBlc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vkugYMjKlxdrFvPcV5AciZ1V0zESeGhOnqdOYt1BzAeGob04YndOGH9ZouJVE7rhN
         djaClxy0D8NmyFfJiUkKbmsj36mDj0rJvaE7tkp91rU1xtuqzbazhm1RC6FtYqMRqY
         eljM93zUBPT6JTg1PfsRfTGYYDuVBkllpY+zoGrI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330104519.GA739551@kroah.com>
References: <20200330104519.GA739551@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330104519.GA739551@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.7-rc1
X-PR-Tracked-Commit-Id: e681bb287f40e7a9dbcb04cef80fd87a2511ab86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c6ef3b156c67e8867e04668cb2af902d44e4086
Message-Id: <158560531052.23211.10228727342822753486.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 21:55:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 12:45:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c6ef3b156c67e8867e04668cb2af902d44e4086

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
