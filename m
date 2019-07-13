Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2E467748
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 02:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfGMAkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 20:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfGMAkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:40:12 -0400
Subject: Re: [GIT PULL] f2fs for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562978412;
        bh=TXsKEjoyPcEzIhqKMz4iKUFUjg9pRr3RvRnxuJ7n/zc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R+xOtmTKsZDqhSEOIeh84R78A6Xkr7XfL3aPmFpLS96tI54TXzOWdBN5ZzfNvGGhZ
         9WmbYQBLWuonmFvDhHCMVUybbEGL3Vm2KCs7wck+aQ0iC8eq1L++Kzm6rE+Jm0OlvQ
         1gyXaQLtZJwSm6Ihu4JOq0Mm6pNSbUADh4fdSe4s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190711171336.GA66396@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190711171336.GA66396@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190711171336.GA66396@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.3
X-PR-Tracked-Commit-Id: 2d008835ec2fcf6eef3285e41e62a5eabd1fe76b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a641a88e5d6864f20b2608cb01165c756794e645
Message-Id: <156297841209.30815.16710657427970608487.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 00:40:12 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 10:13:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a641a88e5d6864f20b2608cb01165c756794e645

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
