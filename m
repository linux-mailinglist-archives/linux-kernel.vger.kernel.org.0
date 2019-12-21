Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97721285DC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 01:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLUAFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 19:05:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfLUAFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 19:05:09 -0500
Subject: Re: [git pull] drm fixes for 5.5-rc3 (resend with cc)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576886709;
        bh=PZyNHVK+yRMHqNLRU1yFyaio8UXCppcBI6FfX2M31bc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xG4H0p4YQ+CKBRI7+VzdfjOgQitk2JdSOf5gqzOY9vX+4l0J547ViqQ1R2G+cwXIN
         cPone07fVHNXy2UZyynfXVDkGT/AVnFN6Lyl9J+xFwx5h5TgThqcbXHh0xdNeNqRcv
         pww9Xq8Do0gdbQPhh+0uBpCJFqptLEJtEoNbcgyI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzUbs3a7_QYgR5X_vsY8uvaMwLExcO_v2s=xDECd2rxWw@mail.gmail.com>
References: <CAPM=9tzUbs3a7_QYgR5X_vsY8uvaMwLExcO_v2s=xDECd2rxWw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzUbs3a7_QYgR5X_vsY8uvaMwLExcO_v2s=xDECd2rxWw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-12-21
X-PR-Tracked-Commit-Id: 0c517e6ced039b389bbe2d6be757525e52442f64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7c88728da3bc68c5b3815332d084244303fd254
Message-Id: <157688670909.7475.15525387561245055910.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 00:05:09 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 09:58:23 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-12-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7c88728da3bc68c5b3815332d084244303fd254

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
