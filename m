Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02A17C83D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 23:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCFWUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 17:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFWUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:20:05 -0500
Subject: Re: [PULL] drm-fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583533205;
        bh=/OjKbsdDosmkYw5qMfoveQTi2Qaoij2tQEr59zWCVd8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pbi6qkzAYIIdmfQHODB7Bvo4/1JJfHKiV0N/cJV5TLkz+thR02bdEZ78/me8syiui
         aiAwxIhWH5OIVNHhbL+NXwVrOsdKlN5ImCHd7CFTeiTz60XbS8Ijool4IVT+fGye77
         AqNu159aIPQiwjgAkccWXyVYL0IcPedHai3vlFmY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200306210854.GA638432@phenom.ffwll.local>
References: <20200306210854.GA638432@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200306210854.GA638432@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-03-06-1
X-PR-Tracked-Commit-Id: 513dc792d6060d5ef572e43852683097a8420f56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f501bb1802dbbf1467e7999954588da31f635ad
Message-Id: <158353320521.11032.15552999513812279872.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 22:20:05 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Mar 2020 22:08:54 +0100:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-03-06-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f501bb1802dbbf1467e7999954588da31f635ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
