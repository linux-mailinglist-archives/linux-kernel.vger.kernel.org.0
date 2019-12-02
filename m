Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D35D10E4A6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 03:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfLBCuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Dec 2019 21:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfLBCuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:50:17 -0500
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.5-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575255017;
        bh=KtCyV6m9o9s2Z71olRxro7P4VHqq+EydFf1NI89GaeY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dbfJmDoALBizxt46rkSnKOTZywU14RAWKCJM0rKYiTA3FuO4FGW95AhP7w6xV3pgp
         ywAlh3SeMgCzZ9wY2TdBpTJ49yXtX1ILq0vQrgSqAFeTZ/eRarD6316ZFMMeNus+4n
         Cb7PVY17Vp7mJz9deZ0vN5uaLXjXge5TLyNRv83k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191128144238.GA28738@smile.fi.intel.com>
References: <20191128144238.GA28738@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191128144238.GA28738@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.5-1
X-PR-Tracked-Commit-Id: f3e4f3fc8ee9729c4b1b27a478c68b713df53c0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67b8ed29e0d472bda2f3afe48d6ff99e127eff0c
Message-Id: <157525501704.1709.1758986193362024729.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 02:50:17 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Nov 2019 16:42:38 +0200:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67b8ed29e0d472bda2f3afe48d6ff99e127eff0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
