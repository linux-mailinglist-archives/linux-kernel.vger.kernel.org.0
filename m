Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DE04EE71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 20:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfFUSKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 14:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfFUSKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:10:06 -0400
Subject: Re: [git pull] drm fixes for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561140605;
        bh=mR8KjeZ5mZCL45IMza5e+2KDiyn01CmfPthvqngvozA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mZ8/EO+JS2JqmX9nwkdG43vBFncloyj48BWBxfwmamuwAp7zJkblCRqG5m+OX2JIc
         +a/AaDl0td6uhyZb1PAFDla6BxcG7TNnzSBhpCC/aOy164O89W8vaaM9ZyvDB298Rs
         M5UVoiuc9dqL52WRncPod382sN4IVreNV7sj6ln0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyM7BRfAwruJ4QsY_gMCGVHxS=ag7cNA1H304zcnAFK+A@mail.gmail.com>
References: <CAPM=9tyM7BRfAwruJ4QsY_gMCGVHxS=ag7cNA1H304zcnAFK+A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyM7BRfAwruJ4QsY_gMCGVHxS=ag7cNA1H304zcnAFK+A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-06-21
X-PR-Tracked-Commit-Id: 5eab9cf87b6c261f4e2f6c7623171cc2f5ea1a9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0728f6c3cab107f0aab2c8ded1292dd2cc41a228
Message-Id: <156114060533.12314.5609427400390584129.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jun 2019 18:10:05 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jun 2019 14:20:53 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-06-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0728f6c3cab107f0aab2c8ded1292dd2cc41a228

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
