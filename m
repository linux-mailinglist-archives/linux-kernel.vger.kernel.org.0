Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA498A5BA5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 19:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfIBRFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 13:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfIBRFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:05:09 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567443908;
        bh=xbswVfafBFtdRchKtBadzRQkMO3ItyV2U/0pzkspZZE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OfGsI9pq6+dgHqHeXBYv5MlxDNcJtWT+nD2J+MXVaR36/5zkL4HLpH6zxTUhs/lhY
         96Iok5pblaCcaHFC6022rudeDAjoNs0TKhsm1A01GxtnIUFn67dCkHhPrmlLlKfcda
         s6eMN/OK85gMhq5MEJ/YrXGQAYLS6J3fea5kezpo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190902153431.GA9961@kroah.com>
References: <20190902153431.GA9961@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190902153431.GA9961@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.3-rc7
X-PR-Tracked-Commit-Id: 8919dfcb31161fae7d607bbef5247e5e82fd6457
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49ffdb4c7c65082cee24a53a7ebd62e00eb2e9e9
Message-Id: <156744390874.11156.16269248695385329485.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Sep 2019 17:05:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Sep 2019 17:34:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49ffdb4c7c65082cee24a53a7ebd62e00eb2e9e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
