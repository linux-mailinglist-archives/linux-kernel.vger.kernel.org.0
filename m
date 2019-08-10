Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571CE88CEE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 21:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfHJTaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 15:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfHJTaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:30:11 -0400
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565465410;
        bh=p8YdjZ44EJH5qQP/CXyJ7MvL1kMtRyzyFUPgQHbwpxI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UFuvXStqspoCbOkvGiIqvbgVIihNUJdWUAPLWzW5dt38j/vi+7Jbu+Ia7HKLeYnmd
         SjRqiD6QeZw666pybYg7c5CmSlht/XPg9GKYVzpr+SANo76/JwniGdZSyzKyD6Jmlw
         Gmh0E0pwcjFx2cpWyS5y95sxXSCah4Za9/VHO0S0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190810115222.GA5874@kroah.com>
References: <20190810115222.GA5874@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190810115222.GA5874@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.3-rc4
X-PR-Tracked-Commit-Id: 09f6109ff4f8003af3370dfee0f73fcf6d20087a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15fa98e40e0c305145da9a95f8ac6dc0bda64884
Message-Id: <156546541064.17840.6571097761525229088.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 19:30:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 13:52:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15fa98e40e0c305145da9a95f8ac6dc0bda64884

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
