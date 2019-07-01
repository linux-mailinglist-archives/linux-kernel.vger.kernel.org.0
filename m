Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA3720ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 17:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfEPPKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 11:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfEPPKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:10:15 -0400
Subject: Re: [git pull] drm fixes for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558019414;
        bh=i8ktoiYzXaR1F/3yFaQFSwDoBUQZ1c1nUvz0vgJnt1o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jWmi7VsvlY/T2BObAqwVUa39u2jauPhdGfeipzpDtmb4SL+vXJMz1iPAret2HINs4
         82EKRtFPKkGBs37clFDRECdrVSSpIezH8Wh0iAoY4/WVJ5mrIaEPCRv2wKfftjrP5Y
         q13Ylg5TouASdq0LCw6MO/REc8lU6+ef15fkNd1U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyXaYhQ5dFQMkrkpTJZDrjVJjEcKB2bcYi=BKdq7qnQvg@mail.gmail.com>
References: <CAPM=9tyXaYhQ5dFQMkrkpTJZDrjVJjEcKB2bcYi=BKdq7qnQvg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyXaYhQ5dFQMkrkpTJZDrjVJjEcKB2bcYi=BKdq7qnQvg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2019-05-16
X-PR-Tracked-Commit-Id: 8da0e1525b7f0d69c6cb44094963906282b32673
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc7ce90153e74f8266eefee9fba466faa1a2d5df
Message-Id: <155801941459.14983.15933361374021728610.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 15:10:14 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 12:27:54 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-05-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc7ce90153e74f8266eefee9fba466faa1a2d5df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
