Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58FAEC74A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 18:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfKARK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 13:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbfKARKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:10:06 -0400
Subject: Re: [git pull] drm fixes for 5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572628206;
        bh=NZUdxbJqX4Vuv0Q03FyiheKXm9a5jALxIO5LuoRJtes=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DaicA6/MbeKaBOWbfsgPHJbZ2ryFxoUQSFlKhl7c7ofJgEidsVQN1/Qac9kaxL07j
         qAalu7rIG+Gm6RqIDiLTYpVWeqiGtKwcARtNzu893ywr7xutdz5H7+lAmozEophhCO
         S8gLLo+grx6b43ctrl+TGbbS/zitxyDTUFFvz33E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx7omDCD2SmOaX9H1mO8=bDZWHw8aTJbp57bGQubYaHtQ@mail.gmail.com>
References: <CAPM=9tx7omDCD2SmOaX9H1mO8=bDZWHw8aTJbp57bGQubYaHtQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx7omDCD2SmOaX9H1mO8=bDZWHw8aTJbp57bGQubYaHtQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-11-01
X-PR-Tracked-Commit-Id: e54de91a24753da713b9bcf9fcd93eec246e45e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 146162449186f95bf123f59fa57a2c28a8a075e5
Message-Id: <157262820616.11375.7758161907091851654.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 17:10:06 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Nov 2019 15:21:49 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/146162449186f95bf123f59fa57a2c28a8a075e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
