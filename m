Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52AA01AE55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 00:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfELWZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 18:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfELWZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 18:25:15 -0400
Subject: Re: [GIT PULL] MTD changes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557699914;
        bh=p4U116jkf3QKKLRcOcQHnj+XhJa1Q6UE86Y+4vfZHMc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jUxWlwMTAxLp923P7Znv7P1v0WPiDixQbtaB6m59DB6jsF89GMT3l7xCDgR9LWGC+
         YcaNJgY53BBw/iyfs6sYnjpBoIrZ6bzhdoznWOiSit58L8KQT84PeqOffUx56eAU2d
         EgDnM61lifqke9dVqXA495T291NqGYmHEekExjbw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <789478679.56056.1557697327425.JavaMail.zimbra@nod.at>
References: <789478679.56056.1557697327425.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <789478679.56056.1557697327425.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.2
X-PR-Tracked-Commit-Id: 3008ba87093852f3756c5d33f584602e5e2a4aa4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4dbf09fea60d158e60a30c419e0cfa1ea138dd57
Message-Id: <155769991458.32032.14628300238313883821.pr-tracker-bot@kernel.org>
Date:   Sun, 12 May 2019 22:25:14 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com, marek.vasut@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 May 2019 23:42:07 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4dbf09fea60d158e60a30c419e0cfa1ea138dd57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
