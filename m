Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43667C6F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 01:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfGMXPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 19:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbfGMXPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 19:15:16 -0400
Subject: Re: [GIT] Ide
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563059715;
        bh=rD8Aad1IFR70R39+mP9JrBLoCXH823xuFJw3uDriXY4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=w9GseMewwdNSIk0//EJDwCpZbh75UBZc0iM3m8zlfRnkCeHkOLqYGdrhDgD4N6OvA
         /DtbWuvQGkTILyzWhz8i1UI2xa9k3PD9mrBNkXGHeC3vBJjcXMWCwE7knThXwmXNDw
         VjJS+oYb4JgoKYlicg0Pxu/wZXa1AveLuVAUI/Ag=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190712.231724.1616414132879925665.davem@davemloft.net>
References: <20190712.231724.1616414132879925665.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190712.231724.1616414132879925665.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git refs/heads/master
X-PR-Tracked-Commit-Id: 13990cf8a180cc070f0b1266140e799db8754289
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fa91854dcdf7829e2694873b19f96b65947112d
Message-Id: <156305971526.4281.229822758208565352.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 23:15:15 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 23:17:24 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fa91854dcdf7829e2694873b19f96b65947112d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
