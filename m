Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA97217FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 20:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfEHSaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 14:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfEHSaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:30:17 -0400
Subject: Re: [GIT PULL] TTY/Serial patches for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557340217;
        bh=nMikRHhWjjmyXa6FagLbxmpDOxXrtUTq5TD5zRQfFb4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kmJZQ47KJ2Cee3ldovwk7/L6DQE6X/xHQKVsU9mj0a+bqIU1UYvU4zPYercjl/1CC
         ztly7Gs/RlE7lH965i3WSmBoYBkO2CasN1XjYWhkFRa1m+VZAdqkJw5v+Shk8Im8cH
         bfWcTnTMmxTwlTw0zI/cSElyhLB2qk+CHJVbxPhg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190508103146.GA14542@kroah.com>
References: <20190508103146.GA14542@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190508103146.GA14542@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.2-rc1
X-PR-Tracked-Commit-Id: 45c054d0815b1530d7c7ff8441389a0421dd05e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3a5e648f5917ea508ecab9a629028b186d38eae
Message-Id: <155734021716.8790.3961846542006284476.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 18:30:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 May 2019 12:31:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3a5e648f5917ea508ecab9a629028b186d38eae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
