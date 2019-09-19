Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A63AB882B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 01:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392928AbfISXk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 19:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392918AbfISXk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 19:40:28 -0400
Subject: Re: [git pull] drm tree for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568936427;
        bh=zo2W1OZlQVMnwoijvVLb/98j1q5npXvKx0jjCFDJIFg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PUr/NWCswPkRh3pOZUFmx09VIaITgLBvv92x/lsjf7fRVf62uhFgaBhdU0RwB+3Os
         YTr5BXTVHVL2VjFFyLHrNdeKPP/NbB5j6dZaw3GRSPtgV12ve2mJ9LzcY2tUvDDQDl
         CjK0RqKJYhQ6Gaire4p7WmaqkOt7WIynt2j3b21Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txTjip6SonSATB-O38TGX9ituQaw+29PnAkNJ960R1z6g@mail.gmail.com>
References: <CAPM=9txTjip6SonSATB-O38TGX9ituQaw+29PnAkNJ960R1z6g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txTjip6SonSATB-O38TGX9ituQaw+29PnAkNJ960R1z6g@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2019-09-18
X-PR-Tracked-Commit-Id: 945b584c94f8c665b2df3834a8a6a8faf256cd5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 574cc4539762561d96b456dbc0544d8898bd4c6e
Message-Id: <156893642758.15931.4359128480342477797.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 23:40:27 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Sep 2019 05:08:55 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-09-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/574cc4539762561d96b456dbc0544d8898bd4c6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
