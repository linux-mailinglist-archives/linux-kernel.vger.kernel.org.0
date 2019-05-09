Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9B45184A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 06:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfEIEpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 00:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfEIEpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 00:45:13 -0400
Subject: Re: [git pull] drm for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557377113;
        bh=qFNfncg8u5sBR6k52K3TKWvyrUti3njqXLIsrDVj0rg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FXSh1GORX1GiRAl5f13QsGioVBY57KHHAycHjOPZ2m3vSPGmwzXqZTisn/PfZyuq3
         RWK+bIaeBbx5FBuWFO8mC8Jq6AeXEcPe0nxqigRTitp+E0Ziw/EeXQNk6dZ+0Ag+d9
         ss+9VuTVKHBpHqnMDDo8Wzft9JJScrwY3HYhhCjM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyFp5LZ6QO1TaDK5jSb5+2SCe3Rjmk0_juVfr-zfspBLg@mail.gmail.com>
References: <CAPM=9tyFp5LZ6QO1TaDK5jSb5+2SCe3Rjmk0_juVfr-zfspBLg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyFp5LZ6QO1TaDK5jSb5+2SCe3Rjmk0_juVfr-zfspBLg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2019-05-09
X-PR-Tracked-Commit-Id: eb85d03e01c3e9f3b0ba7282b2e3515a635decb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2d635decbfa9c1e4ae15cb05b68b2559f7f827c
Message-Id: <155737711300.32092.9819424468781227220.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 04:45:13 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 May 2019 13:28:07 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-05-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2d635decbfa9c1e4ae15cb05b68b2559f7f827c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
