Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F387A12BB38
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 22:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfL0VZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Dec 2019 16:25:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfL0VZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 16:25:07 -0500
Subject: Re: [git pull] drm fixes for 5.5-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577481906;
        bh=cli8s/s8DVhJmfEmsGDUlvnBRpKpzvMzh9Mvnhbwt00=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AQ6a8yFOLwqnxYS3H8LaH9O6MicsB85yDTsnwn/es+P5nahEcOi2WTivq9mSjGh0E
         ks2h90MZzzgxusmE1QzS9BTrW1jSeidjMOIzpvxCmtv/UVuYxXUh+oGQ4GIb44gFdV
         GTjCZjVoI3CWSoe11FTKxRiFv/5UgfaTQhaPHBqA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzSB+6b0KuXaKfTP_GLpMyBUQheC_L4Nyo4zhygDvixUw@mail.gmail.com>
References: <CAPM=9tzSB+6b0KuXaKfTP_GLpMyBUQheC_L4Nyo4zhygDvixUw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzSB+6b0KuXaKfTP_GLpMyBUQheC_L4Nyo4zhygDvixUw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-12-28
X-PR-Tracked-Commit-Id: e31d941c7dd797df37ea94958638a88723325c30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48a8dd171993569cb77dee0882a47abad47d2837
Message-Id: <157748190690.18926.9135544284124087750.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Dec 2019 21:25:06 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Dec 2019 06:08:45 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-12-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48a8dd171993569cb77dee0882a47abad47d2837

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
