Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9DD714E05B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 19:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgA3SAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 13:00:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbgA3SAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:00:18 -0500
Subject: Re: [git pull] drm for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580407217;
        bh=oRBcw3Bz1XwI0m/XlBKvicUPB3oj6eDbFc2/bvfBXo4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N6hMS5nsLAQPXo1lPKlleFCVeWMOPkQk0G6KI0ToQggYKQbPV+3iwIQAsvX2U/HYM
         gBWIMosddKJg7wh1k7KE4K6IEv1/zX+tRJ4TNqlNr9jK8sS1+F8XYycXsQjFdwAmrn
         uD3elQwXWme/70bGRyD6qm21lkgjndZb0FF3FQ5M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twBvYvUoijdzAi2=FGLys0pfaK+PZw-uq2kyxqZipeujA@mail.gmail.com>
References: <CAPM=9twBvYvUoijdzAi2=FGLys0pfaK+PZw-uq2kyxqZipeujA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twBvYvUoijdzAi2=FGLys0pfaK+PZw-uq2kyxqZipeujA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-01-30
X-PR-Tracked-Commit-Id: d47c7f06268082bc0082a15297a07c0da59b0fc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f68e3655aae6d49d6ba05dd263f99f33c2567af
Message-Id: <158040721766.2766.10487533836164754740.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 18:00:17 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 15:58:11 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-01-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f68e3655aae6d49d6ba05dd263f99f33c2567af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
