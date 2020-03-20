Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4765518D578
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 18:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCTRPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 13:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbgCTRPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:15:07 -0400
Subject: Re: [git pull drm fixes for 5.6-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584724507;
        bh=G5yoDx1A9wxFe1FITEE9mipC9mYOKfihV2JJP7Q0iho=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YxE4UumjtW0hygEqHQodDfIyAaoesPbgtxvj/6uJL0G1bY+eJy4iaWuUeU48DYqXf
         twQnnMLIAfV4ttIr1h1zhegaV3X2xXOaogKWx8G1wKpm4XX4A5zi/jdHe0Jqs0pAsC
         8rKNA2hEaYuXJGKz5qc3TtUmjEc2otCnXIV+Huog=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tziNvC7VozK1C3yd+wqspVGF7d0eToOANwV4Euwy4LMkQ@mail.gmail.com>
References: <CAPM=9tziNvC7VozK1C3yd+wqspVGF7d0eToOANwV4Euwy4LMkQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tziNvC7VozK1C3yd+wqspVGF7d0eToOANwV4Euwy4LMkQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-03-20
X-PR-Tracked-Commit-Id: 5366b96b1997745d903c697a32e0ed27b66fd158
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69d3e5a5a66bb59c39f36dcb9cf4e9a4239aa8cd
Message-Id: <158472450732.23492.59820200078010578.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Mar 2020 17:15:07 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Mar 2020 13:01:44 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-03-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69d3e5a5a66bb59c39f36dcb9cf4e9a4239aa8cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
