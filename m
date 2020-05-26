Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1196F19B87E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 00:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbgDAWfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 18:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733213AbgDAWfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:35:18 -0400
Subject: Re: [git pull] drm for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585780518;
        bh=dZ6g5rEXeTd4/k90kw/APcz445rQxW8LbehiZ2WKYuQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Hx4RHYUK8RvbwI/yxPXHgwF8yqvlQdLtcOsYe5WpxfirftdOffK8O3LIo/XHNfEUn
         HZATuQvoOqMNGBsdAsIvJ06NIP9P0RESdGu98zAGbGhHIHI0EvnDzKFQEG7+uv0UR0
         q6Xy9wDhnFT/pqwy/aFSh8U4OGZk8CcJhTMCxdU0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twza_DeycOEhT+u6Erh0yFTAUe447J6bxWCLq5+QW8ZaA@mail.gmail.com>
References: <CAPM=9twza_DeycOEhT+u6Erh0yFTAUe447J6bxWCLq5+QW8ZaA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twza_DeycOEhT+u6Erh0yFTAUe447J6bxWCLq5+QW8ZaA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-04-01
X-PR-Tracked-Commit-Id: 59e7a8cc2dcf335116d500d684bfb34d1d97a6fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f365ab31efacb70bed1e821f7435626e0b2528a6
Message-Id: <158578051831.24680.6903465045656664847.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Apr 2020 22:35:18 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 15:50:42 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-04-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f365ab31efacb70bed1e821f7435626e0b2528a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
