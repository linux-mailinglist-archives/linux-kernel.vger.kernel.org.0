Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176F729D33
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 19:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404230AbfEXRgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 13:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391630AbfEXRfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:19 -0400
Subject: Re: [git pull] drm fixes for 5.2-rc2 (try two)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558719317;
        bh=vFO247cLIzhgUSVcNu2+0wfzMiTpHuPl011fsa3J93g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nS64xNPrgh6tFmEK47Ej+qe5v8SgrU3cHcKvQsaegQN9gibKwBxQn8pS7El63hAXF
         W1s2H1+qEaX6u6B1liYAJf6CiZnLZIzjXCiFbrYE98Dik0PqXS7ZIMShjWmN0WqYwH
         gEY2CEugNKmlYHEpEU020+P5XEbj1639S70ec3wQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyyEcLOqXFMsrdkZa8WQ1aNJjvz9bGyFjnv-QzOZkfZ=w@mail.gmail.com>
References: <CAPM=9tyyEcLOqXFMsrdkZa8WQ1aNJjvz9bGyFjnv-QzOZkfZ=w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyyEcLOqXFMsrdkZa8WQ1aNJjvz9bGyFjnv-QzOZkfZ=w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-05-24-1
X-PR-Tracked-Commit-Id: c074989171801171af6c5f53dd16b27f36b31deb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3b25d157d5a52ef3f9296a739ee28f5d36e8968
Message-Id: <155871931739.20356.3933846924787456811.pr-tracker-bot@kernel.org>
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

The pull request you sent on Fri, 24 May 2019 20:01:35 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-05-24-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3b25d157d5a52ef3f9296a739ee28f5d36e8968

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
