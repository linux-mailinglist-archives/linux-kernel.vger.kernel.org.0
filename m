Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6295411EE4D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 00:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfLMXKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 18:10:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfLMXKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:11 -0500
Subject: Re: [git pull] drm fixes for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278611;
        bh=pspnKMIlXdhQZxbYs6m+K1waGcUhbbyoUHB0cwr6S5A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F2xKFAGc2VQwggfbn1pCnWkoZ99BK15Wi+/PD+5Dhebj0nR4kf30/tD+EoNDCtZ1p
         jddWCl8GlEK4j7CpqCu8Y0WPkMwFsS8qrHyCpw72qh5qjkAKAA62DqIHuYxRLzigiC
         oKnTYcWtwrrVTMZQTrKP4jUW7na6DIm6rPNhG1S0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty-Cn1SRGkXWkYN9L8F2oe-mwA77cvpSz3iJUutQQcrwA@mail.gmail.com>
References: <CAPM=9ty-Cn1SRGkXWkYN9L8F2oe-mwA77cvpSz3iJUutQQcrwA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty-Cn1SRGkXWkYN9L8F2oe-mwA77cvpSz3iJUutQQcrwA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-12-13
X-PR-Tracked-Commit-Id: d16f0f61400074dbc75797ca5ef5c3d50f6c0ddf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2cb931d724b08def6e833541a37b08ebd59ab43
Message-Id: <157627861136.1837.10096094016374191745.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:11 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Dec 2019 17:04:44 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-12-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2cb931d724b08def6e833541a37b08ebd59ab43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
