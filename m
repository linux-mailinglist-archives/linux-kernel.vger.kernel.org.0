Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9FE72679D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 18:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfEVQAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 12:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbfEVQAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:00:19 -0400
Subject: Re: [GIT PULL] gfs2: Fix sign extension bug in gfs2_update_stats
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558540819;
        bh=ybeBGEdz8z93uxrPAOGD3+lHShFIueux/w/4xzFA4rk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UKX77t/fpfEZOjyQa7kY0YrLMA3NgcMAkKteVEe2pRfmd+2XCgBdP/MjYoLg6XZ3w
         pYrQ5A1lS5sUwyJxISBDB9LIou5v2XmKB4xO+2RzZazgi78jh36jrVHWs18h9qMebq
         bojw9O4Mt5Jzw2SMdYdlO+aWddqhpFz8EHB+BHso=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHc6FU71Yp9Y8ZDrJnJ3AAQazW8-WpTCLCHWYu-+JQ2tTu4Ymg@mail.gmail.com>
References: <CAHc6FU71Yp9Y8ZDrJnJ3AAQazW8-WpTCLCHWYu-+JQ2tTu4Ymg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHc6FU71Yp9Y8ZDrJnJ3AAQazW8-WpTCLCHWYu-+JQ2tTu4Ymg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-5.1.fixes2
X-PR-Tracked-Commit-Id: 5a5ec83d6ac974b12085cd99b196795f14079037
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 651bae980e3f3e6acf0d297ced08f9d7af71a8c9
Message-Id: <155854081908.3461.15873360975965791406.pr-tracker-bot@kernel.org>
Date:   Wed, 22 May 2019 16:00:19 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 May 2019 14:19:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-5.1.fixes2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/651bae980e3f3e6acf0d297ced08f9d7af71a8c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
