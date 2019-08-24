Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DC79BF5A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfHXSpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 14:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbfHXSpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 14:45:07 -0400
Subject: Re: [git pull] drm fixes for 5.3-rc6 (the second coming)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566672306;
        bh=+evUtgdH4F4JEXkTzceA7IrJERvRboAHZ2gQOBz6SxA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QmtYDh52br9As2IMqSKlYWncaECObKBWwTksYvjzKXDy8FAR7MHJcXpOUQnVfLiUx
         41Qk9b5OFj2iMHXgmzXsT+AkbI+NuRSnoWNn47GlgqCNLC+HpLotkWy0/Omt3F8CaH
         Qb7XCE5xSJeYw+IXu02m8psFywPM0ch2WXLtqxP4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twtUmogvabQJD8CcazYfhWUjTUOyRkFomor77LbVDrcKA@mail.gmail.com>
References: <CAPM=9twtUmogvabQJD8CcazYfhWUjTUOyRkFomor77LbVDrcKA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twtUmogvabQJD8CcazYfhWUjTUOyRkFomor77LbVDrcKA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-08-24
X-PR-Tracked-Commit-Id: 7837951a12fdaf88d2c51ff0757980c00072790c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc67b17eb91ea6a2b6d943bb64cde8d1438a11ec
Message-Id: <156667230692.2337.8881030544847448159.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Aug 2019 18:45:06 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Aug 2019 15:22:55 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-08-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc67b17eb91ea6a2b6d943bb64cde8d1438a11ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
