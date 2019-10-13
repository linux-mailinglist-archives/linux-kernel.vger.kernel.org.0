Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D75DD56C5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 18:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfJMQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 12:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfJMQPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 12:15:06 -0400
Subject: Re: [GIT PULL] mtd: Fixes for v5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570983305;
        bh=l3PUiyUzcVRzu9ZjGfW0o+6z6+yhGNHQ5vU+b73MK9I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NxpLRAMRt5/vZ0IFd4MiE3R5jGRHjoQPnytwfCie1n7paj61EVBmB4QKcVBUYYS+T
         aqiUNURruczlQIjZpUWMGqmgZHOUCxZ87fxJQiNKF9zBrBxGd2DT+hoV5KjKSWwnl/
         TWF2t8iAZG4Ru/E13JQdVky1OMoKfGKSzqWXwpnM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1615396520.21318.1570912156820.JavaMail.zimbra@nod.at>
References: <1615396520.21318.1570912156820.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1615396520.21318.1570912156820.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
 tags/fixes-for-5.4-rc3
X-PR-Tracked-Commit-Id: df8fed831cbcdce7b283b2d9c1aadadcf8940d05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71b1b5532b9c58f260911ee59c7b3007d6d673a5
Message-Id: <157098330559.26372.16017055334585777960.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Oct 2019 16:15:05 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 22:29:16 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/fixes-for-5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71b1b5532b9c58f260911ee59c7b3007d6d673a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
