Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76E5ABD41
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395070AbfIFQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 12:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390604AbfIFQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:05:07 -0400
Subject: Re: [git pull] drm fixes for 5.3-rc8 (or final)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567785906;
        bh=b1hB4Hzd76gmAO6x22jNaF/llqS4XF+ieLK0Q/iLKyg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BEw9cohDjNEe2uedGZflktJOedxTBoGsATjrpAHPRNxaCaGO6xIDibF0Z6p4393Mp
         d4FyQzHoo0U8ODqmSp/hzvuMDvEGToaLofmN4KtKONJLofEeLjP+QILZWY1I0WB2UF
         YomcxAiGqAPPg3hJjdSa2qBsJ/ssjCeGw/9fqPto=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twnS=MQzLZM6sJ5wCtS5reFqd7715DtceP-6+=h2JoKLg@mail.gmail.com>
References: <CAPM=9twnS=MQzLZM6sJ5wCtS5reFqd7715DtceP-6+=h2JoKLg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twnS=MQzLZM6sJ5wCtS5reFqd7715DtceP-6+=h2JoKLg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-09-06
X-PR-Tracked-Commit-Id: 1e19ec6c3c417a0893fcfae7abfba623e781d876
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08d433d8121598f7c2a45f3461c534746b1ed05b
Message-Id: <156778590670.8517.14063443643134424076.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Sep 2019 16:05:06 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Sep 2019 17:18:34 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-09-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08d433d8121598f7c2a45f3461c534746b1ed05b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
