Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59FDB1419FA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 23:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgARWFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 17:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgARWFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 17:05:04 -0500
Subject: Re: [git pull] drm fixes for 5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579385103;
        bh=Ki1bVuApY32Y91Oiad9vnAjok3ZarWryih/b+RfdvzY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FBD8dPWfIZKJI5AWG+/xvRsyqq2wSKf+kZ8K1BtDmY+ggM8byC0/7uko0qTZKVKyc
         8Ls+1r0NOQwTk0ZOs5jDlcVQBL7TDI6cZk4Og6wo77n4Tj21U69sbYZsU4HxW7YTwv
         BAQ81dIxum90q5L6rAfn5Rd4cI0bzgeLQ2olEis8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyCmZM2Nzy397APbb9-EcNyC-Bgz4Q_7hTcjaQpX6E1Pw@mail.gmail.com>
References: <CAPM=9tyCmZM2Nzy397APbb9-EcNyC-Bgz4Q_7hTcjaQpX6E1Pw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyCmZM2Nzy397APbb9-EcNyC-Bgz4Q_7hTcjaQpX6E1Pw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-01-19
X-PR-Tracked-Commit-Id: f66d84c8b4db9a4f77f29e2d8fd521196c879582
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 244dc2689085d7ff478f7b61841e62e59bea4557
Message-Id: <157938510363.7168.18142518179667876755.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 22:05:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Jan 2020 07:21:35 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-01-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/244dc2689085d7ff478f7b61841e62e59bea4557

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
