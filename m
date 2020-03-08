Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79FA817D48A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 16:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCHPzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 11:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCHPzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 11:55:07 -0400
Subject: Re: [GIT PULL] Driver core fixes for 5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583682906;
        bh=pmI5N47lVnRz4IF7ZehT6mh0m8yDgfb2qRPwFHTDzvQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Hn7Q3lOEgTygmtXfjYAx9OdU5CKr9pA+jGj2BacZkJfFJF4OGta6GrH69Kn9e1zWv
         XPmgDy9k+qHJyoyKoat9I+iLXD3JeWNYEuzbDqljjwxdFq8rl5/Wcihpd6DOOwlDVS
         sXxGGleRCuLIghhrw0R4mmb90jg4rbLbBTYroQgw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200308095254.GA4027132@kroah.com>
References: <20200308095254.GA4027132@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200308095254.GA4027132@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.6-rc5
X-PR-Tracked-Commit-Id: 77036165d8bcf7c7b2a2df28a601ec2c52bb172d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b34e5c13327ef723362c88c43da176a439badeea
Message-Id: <158368290677.12496.8200984633169779199.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Mar 2020 15:55:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Mar 2020 10:52:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b34e5c13327ef723362c88c43da176a439badeea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
