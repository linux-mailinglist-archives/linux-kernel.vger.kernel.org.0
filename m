Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1188C1320D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 18:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfECQUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 12:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfECQUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:20:05 -0400
Subject: Re: [git pull] drm fixes for final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556900404;
        bh=PdQwiRjHsghdoXxNJ3/WJ9wiBAJQB1vDqM32KiE4RNc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=p1BHXSWZyuMRt+Dh4nAvSdb/dwQ7FRlq1Ywfe5716spBnvJxwl/mYJ9V9zzhWlwJ3
         SKQXY44gKYPvs8P/vOgga3AbmaYMDArrT+qZjUXFXxaDwVLaH5Tn3NOvBy5pgKUxAV
         sVgIbwRPFWM8NX5zGFDjywyhtovXUQARG6KlB/T0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twjCLCi0rVHeaK1CtyD=13PSFxdDTDK4LvV-w89Wr6DvA@mail.gmail.com>
References: <CAPM=9twjCLCi0rVHeaK1CtyD=13PSFxdDTDK4LvV-w89Wr6DvA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twjCLCi0rVHeaK1CtyD=13PSFxdDTDK4LvV-w89Wr6DvA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-05-03
X-PR-Tracked-Commit-Id: 1daa0449d287a109b93c4516914eddeff4baff65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4ccb5f9dc6c4fb4d4c0a9d73a911986f20ec88a
Message-Id: <155690040459.31408.13875118131564070601.pr-tracker-bot@kernel.org>
Date:   Fri, 03 May 2019 16:20:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 May 2019 11:01:07 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-05-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4ccb5f9dc6c4fb4d4c0a9d73a911986f20ec88a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
