Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038D71730B4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 07:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgB1GAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 01:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgB1GAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:00:08 -0500
Subject: Re: [git pull] drm fixes for 5.6-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582869607;
        bh=O0lItgxGsadBxEBFcdX7qF0516IN24GExKcYpPLQ50o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jz4tyufQn4566NNmpUnuwFoyUBYsNW385azRjBLysyRZ1kMYLVE1eGKsLZgfazb0J
         wjTgItrCKVekXrX3NdE1gn4V+szyj0giED/ye37WVZ0NGHvdqFWhqWQ6poeiODH5+P
         CVxU1lgzsQCZ2U2Nzp/k80+0yu179G4WUrs2Kzl0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tya9tFH13gF8AyOyP8SLMB-wyUNxBen=NY2ik9hr1Brjw@mail.gmail.com>
References: <CAPM=9tya9tFH13gF8AyOyP8SLMB-wyUNxBen=NY2ik9hr1Brjw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tya9tFH13gF8AyOyP8SLMB-wyUNxBen=NY2ik9hr1Brjw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-02-28
X-PR-Tracked-Commit-Id: f091bf39700dd086ab244c823f389556fed0c513
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45d0b75b98bf1de4b3a5b09188c75f3bfa3152b0
Message-Id: <158286960784.11613.5194916749172956851.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Feb 2020 06:00:07 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Feb 2020 15:22:04 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-02-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45d0b75b98bf1de4b3a5b09188c75f3bfa3152b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
