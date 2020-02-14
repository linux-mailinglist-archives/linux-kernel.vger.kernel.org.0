Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E990515F8D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 22:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbgBNVk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 16:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387936AbgBNVk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:40:28 -0500
Subject: Re: [git pull] drm fixes for 5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581716428;
        bh=V6ishEWu7VDWMflxPRIPVYneSY4aw7KtvqZHI4s+X/c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1a9aGdLX3JlvKUWjX0JxMYmLd213dwgn09iICZQ35ZWVNXOfpqil5aAgRKL2uxjpv
         TMTHbjEoYy/nMfuGcYqHCwuX/qXJqcMfNJIEggs/Ap4nFRQPUZVYQVj+NIfuL3Bvh/
         A1+F9rVzlqcoR7JcQBuJhfWgXM6x9HrE+2FKr02w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzpGGiPB7oOkhjEn9MifjjVQ4TdH4GTtJeBf74SBn-NKg@mail.gmail.com>
References: <CAPM=9tzpGGiPB7oOkhjEn9MifjjVQ4TdH4GTtJeBf74SBn-NKg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzpGGiPB7oOkhjEn9MifjjVQ4TdH4GTtJeBf74SBn-NKg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-02-14
X-PR-Tracked-Commit-Id: 6f4134b30b6ee33e2fd4d602099e6c5e60d0351a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f0d329371c08dfa3227f1716e522f3a8a081155
Message-Id: <158171642816.8400.15995893936760198591.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Feb 2020 21:40:28 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Feb 2020 14:15:53 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-02-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f0d329371c08dfa3227f1716e522f3a8a081155

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
