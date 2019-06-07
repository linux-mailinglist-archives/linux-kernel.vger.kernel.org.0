Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC55F39731
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfFGVAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 17:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730647AbfFGVAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:00:13 -0400
Subject: Re: [PULL 0/1] xtensa fix for v5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559941213;
        bh=qsQw7q51mWSuGhsUf6Fcc+0ldCdSkFkOJn/SDaThJs4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j77cHE1FkmGwJiMkdNlM9gX8J186SwveeD6eHtaat/2moDnhlcF41WV8+Hqzpjfri
         NsHzRN/tRxywB44jUZ9jC3r0AEE4L+EPiAvnkUc5JCICksRABQ576jTcerNBgcCocO
         rAxv18dFTSTMU99FxQGU1g1adXIY+Wqp5JEYyO+Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190607190131.4252-1-jcmvbkbc@gmail.com>
References: <20190607190131.4252-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190607190131.4252-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20190607
X-PR-Tracked-Commit-Id: adefd051a6707a6ca0ebad278d3c1c05c960fc3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d18c7e9d6e4e0ba358459e812bf115b4ccef54ce
Message-Id: <155994121299.4194.8888627260516861331.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jun 2019 21:00:12 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  7 Jun 2019 12:01:31 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190607

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d18c7e9d6e4e0ba358459e812bf115b4ccef54ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
