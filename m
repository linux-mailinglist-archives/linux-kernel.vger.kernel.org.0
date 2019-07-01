Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5616F313C0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfEaRZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 13:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfEaRZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:25:14 -0400
Subject: Re: [git pull] drm fixes for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559323513;
        bh=sKYyAym8EO6FT7ThDxTvjDbpuQ8pm7hX1RlE3EIZvg0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Yj++GCO3gyIOS90Wel1KyRgYsENBK0Xj/FBkRj+5AMoSWKUmr2k1rRkc30Nm+RTGL
         zhYupM0ZwqDBySQMF6FFZcibmwkcNChNe8H2a2V5jNy9v1jXk0mypqZIsB74xF+NOR
         D0x9kuU6I+obXb/sciBVbdumuns7Uuz6q+NESNKg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twUWVimrFu+Lbu4SHZw8szeHD=FGD8GVyf5tmd6p8w7=Q@mail.gmail.com>
References: <CAPM=9twUWVimrFu+Lbu4SHZw8szeHD=FGD8GVyf5tmd6p8w7=Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twUWVimrFu+Lbu4SHZw8szeHD=FGD8GVyf5tmd6p8w7=Q@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-05-31
X-PR-Tracked-Commit-Id: 2a3e0b716296a504d9e65fea7acb379c86fe4283
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca1918049673a9be507c41fb7e4a69a57601a017
Message-Id: <155932351344.8550.1717898648190094259.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 17:25:13 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 May 2019 11:12:45 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-05-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca1918049673a9be507c41fb7e4a69a57601a017

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
