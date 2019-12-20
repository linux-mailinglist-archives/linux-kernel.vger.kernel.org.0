Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9B5128253
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 19:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLTSpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 13:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbfLTSpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:45:12 -0500
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.5-2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576867511;
        bh=G+XNGXLYcR+MVGKjJqbdVW7gJ5qptEOEOzLBm0WslQA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VkRdkai0JYpxFIGY+VAfdm9zdMPraHxwElSCkn8RhwxCVHhHhrR1ExbPYLRt7fRiy
         VnZIvW63k6AzG51mfzw6iwjFFKkO+ei8XMql5O8yJT0+IJy0o3QW+LNwdQgxMnRRaS
         uqACLJ/CAgQfGtiURniPHVPcs7URECWIhwTPxHiA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191220171948.GA3909@smile.fi.intel.com>
References: <20191220171948.GA3909@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191220171948.GA3909@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.5-2
X-PR-Tracked-Commit-Id: 02abbda105f25fb634207e7f23a8a4b51fe67ad4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fce34dec76d93311f90f1f077e1eba3605a3771c
Message-Id: <157686751177.22538.9893885755920683892.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Dec 2019 18:45:11 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Dec 2019 19:19:48 +0200:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fce34dec76d93311f90f1f077e1eba3605a3771c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
