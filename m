Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2368229D37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 19:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391775AbfEXRgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 13:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391573AbfEXRfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:17 -0400
Subject: Re: [git pull] drm fixes for 5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558719317;
        bh=ea7tQ4I3l0XYPLSzWUVRBi8wD4VUi3zM6ApyTznKSEw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bprlgLNAzPSZJdRkts86dpLgIYrLhwlZoo4T5vrIIgQMpCiVm13OS/a342oGnvoM5
         HuAl5wy4Ph7cy1ds7na8Q9vG5j6rKGibObG2nR1MRQdLNIFVizOdzLT4ybbanJ+5W6
         hUZP3Mg90tIwIuBD/4NLnMHucmTkmUFr8rTWqaeM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txEn_xBG7fW+P40v6VZW8txMUn9usQnC4L_KXumXNXMjw@mail.gmail.com>
References: <CAPM=9txEn_xBG7fW+P40v6VZW8txMUn9usQnC4L_KXumXNXMjw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txEn_xBG7fW+P40v6VZW8txMUn9usQnC4L_KXumXNXMjw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-05-24
X-PR-Tracked-Commit-Id: e1e52981f292b4e321781794eaf6e8a087f4f300
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c074989171801171af6c5f53dd16b27f36b31deb
Message-Id: <155871931712.20356.1440632621890156969.pr-tracker-bot@kernel.org>
Date:   Fri, 24 May 2019 17:35:17 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 14:28:08 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-05-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c074989171801171af6c5f53dd16b27f36b31deb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
