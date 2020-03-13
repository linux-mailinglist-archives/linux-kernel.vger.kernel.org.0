Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1C183E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 02:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCMBPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 21:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgCMBPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:15:07 -0400
Subject: Re: [git pull] drm fixes for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584062106;
        bh=ADs1Pl9RGMgBCI1Y2QeWJJbKKwQwvnYHsaE2qxf+Xt0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bLuVseidKmDXn1phfsPI3jDFVKtD9CwqeJvzHlIKuR7S7mFGlH+1/mhY9h7GAyDIx
         3VcWNJO5wBi4K5LSnKsUZ3dwuWyGqKhXXws9IuxzMOCG2wpzABBAMMfkGcrPEid5MG
         YlKfdUewqOr7npEZ1HTZfemvHb291Z2bej/w/FMc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyX3+Qk05feqP=5SbePrg7kWvZu1O0J1pxZk+8Yj=Xjew@mail.gmail.com>
References: <CAPM=9tyX3+Qk05feqP=5SbePrg7kWvZu1O0J1pxZk+8Yj=Xjew@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyX3+Qk05feqP=5SbePrg7kWvZu1O0J1pxZk+8Yj=Xjew@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-03-13
X-PR-Tracked-Commit-Id: 16b78f052d0129cd2998305480da6c4e3ac220a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d81a3f29c0afb18ba2b1275dcccf21e0dd4da38
Message-Id: <158406210686.26569.9801341237425132776.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Mar 2020 01:15:06 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Mar 2020 10:58:51 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-03-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d81a3f29c0afb18ba2b1275dcccf21e0dd4da38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
