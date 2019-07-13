Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F9767C71
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfGMXPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 19:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbfGMXPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 19:15:15 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563059714;
        bh=RYAYTik58rz9Xph9CSASviZb6QYePl94jtZG15ucuOw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Tc3lqI0a8+grAo0iRyA9P1GtP1wt4zFdzCJI9ydIN8FyRRaSzEk41oGtk+n4c8KaJ
         Eu9PCgSHWh6LR23CTPJOFbFLB6S/b2g1AES1V4FBGgi07UTD6GNzlNHMj0TDoCXpFh
         /iRgEwM53gqyDHFRhidw9rYW6Qi4cTjs4PgYiu9M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190712.231704.904072376124323665.davem@davemloft.net>
References: <20190712.231704.904072376124323665.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190712.231704.904072376124323665.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master
X-PR-Tracked-Commit-Id: 25a09ce79639a8775244808c17282c491cff89cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d12109291ccbef7e879cc0d0733f31685cd80854
Message-Id: <156305971431.4281.17318424426669781693.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 23:15:14 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 23:17:04 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d12109291ccbef7e879cc0d0733f31685cd80854

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
