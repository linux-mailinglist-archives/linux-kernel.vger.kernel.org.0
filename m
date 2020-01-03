Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACFB412FCF4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 20:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgACTZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 14:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbgACTZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:25:06 -0500
Subject: Re: [git pull] drm fixes for 5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578079505;
        bh=RQg7ogAA5Z0uDirCP6aCQrHzBY1G8SgTCsaK+SsMbbc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iigZ+xXUFpDfssdL1tURaS6B9inH4xI2r/8DADwZ8IHLRT0Kg+wF7AaPq6rkesTRB
         JxjDhOIzsKkXrvKDM3KZUT+Q72Aw78xdwRWyMQS0c92d2A1hZlfFPbHjVP31/is4HY
         g09K7Wivf0UTphvOAczLVdbBbUgjoFDTGMjvRQXY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twLL0KL7zS4hwH=TgcuwVqJCpvUB276+GzkhQaa_B2vHg@mail.gmail.com>
References: <CAPM=9twLL0KL7zS4hwH=TgcuwVqJCpvUB276+GzkhQaa_B2vHg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twLL0KL7zS4hwH=TgcuwVqJCpvUB276+GzkhQaa_B2vHg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-01-03
X-PR-Tracked-Commit-Id: a6204fc7b83cbe3398f61cf1742b09f66f0ae220
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca78fdeb00fa656f09afee977750e85da929d259
Message-Id: <157807950558.16643.5078290428003486265.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 19:25:05 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jan 2020 16:57:38 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-01-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca78fdeb00fa656f09afee977750e85da929d259

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
