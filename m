Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E4905CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfHPQaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 12:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHPQaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:30:05 -0400
Subject: Re: [git pull] drm fixes for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565973005;
        bh=X0N24WaO4ijj8bin8BKWcaf+z4gGYDcFJcVqNwGtnyg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1sXtOnDQpRcYoOu5M2MSCphW120fdRnqT0sYUcqWtborAXFqHwBB/ZP7/hG0Rh2sn
         x9JnvyH11o18/xSf73RIQxp6/zxbm0UC0FGIX0+e/EQYNQcaJmTYxZh+lYwKyD21sH
         nmMrhjJIbUJf5/jsGyWea43u204pgiv7U/kQuDPg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx2Kkbyor2-EnK31VE1eARbq6zCyNgqj39tyLqd8uUWKA@mail.gmail.com>
References: <CAPM=9tx2Kkbyor2-EnK31VE1eARbq6zCyNgqj39tyLqd8uUWKA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx2Kkbyor2-EnK31VE1eARbq6zCyNgqj39tyLqd8uUWKA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-08-16
X-PR-Tracked-Commit-Id: a85abd5d45adba75535b7fc6d9f78329a693b7a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec037ac244c070f9eedcdf5cdb23bd817e7b8cf4
Message-Id: <156597300495.15122.500266032759245284.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Aug 2019 16:30:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Aug 2019 14:21:56 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-08-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec037ac244c070f9eedcdf5cdb23bd817e7b8cf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
