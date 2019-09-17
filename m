Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3041B45CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 05:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392140AbfIQDFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 23:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbfIQDFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 23:05:17 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.4-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568689517;
        bh=C+PXss2mWQ5yCfvOvzWhp1F0oOnE/usf/XMVXXKsyeE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sP1oFDKwQ42b4kzEUxyofFpzngkY937Y8niRCFvuXpTp0Xnbt3YNcYIoxbQfuLYdk
         BMttxVXDipb7oyesJJI1CGyMiLf3Iu1mb6jl1b9A99orb8iNFGA/7+sd0dAlbobRGO
         B7p1lRM0//0Mk4f7JSuGUCE8s4lclNxIZA80ut+U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190913170655.GA29705@smile.fi.intel.com>
References: <20190913170655.GA29705@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190913170655.GA29705@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.4-1
X-PR-Tracked-Commit-Id: f690790c9da3122dd7ee1b0d64d97973a7c34135
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad062195731bea1624ce7160e79e0fcdaa25c1b5
Message-Id: <156868951731.17669.10691370751965971396.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 03:05:17 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Sep 2019 20:06:55 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad062195731bea1624ce7160e79e0fcdaa25c1b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
