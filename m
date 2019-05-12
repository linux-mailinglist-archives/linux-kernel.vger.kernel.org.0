Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD02C1AE56
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 00:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfELWZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 18:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfELWZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 18:25:16 -0400
Subject: Re: [GIT PULL] UBI/UBIFS changes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557699915;
        bh=pIvlh5p6bekz+2ObDpG1m8sLIElo6/20NgytoANxSEg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UFvXR89Bl98C9xOvt0GJSykzc1HcumtULMsDyzna0yi8sSnrm83nicPP0UGgIScb4
         od/3S1vNKSwjLtXUC8npL/9kJAmhzdPt2Hh4R3wa/CEaOSOkGsnOzeOIfN6U/4MHty
         MUWM0q7IbZqeLgNNw4jddV3J+R3iIX7dTkaSqCjk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2058307720.56057.1557697346125.JavaMail.zimbra@nod.at>
References: <2058307720.56057.1557697346125.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2058307720.56057.1557697346125.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git
 tags/upstream-5.2-rc1
X-PR-Tracked-Commit-Id: 04d37e5a8b1fad2d625727af3d738c6fd9491720
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7a02fa0a8f9ec1b81d57628ca9834563208ef33
Message-Id: <155769991585.32032.5198960088075056155.pr-tracker-bot@kernel.org>
Date:   Sun, 12 May 2019 22:25:15 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 May 2019 23:42:26 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7a02fa0a8f9ec1b81d57628ca9834563208ef33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
