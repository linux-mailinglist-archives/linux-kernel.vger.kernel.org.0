Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE2138194
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 15:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgAKOpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 09:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729836AbgAKOpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:05 -0500
Subject: Re: [git pull] drm fixes for 5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753904;
        bh=B5e2FWQy3aMIJYfhP1REi3QWeZ2OLib3kFPKkA77TZw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VZiaZ6r98dJoqS8I6CSHiilf7FNV+2wbwCMHsR4GkUGas1WzgNvuaYP3gA2/Oa7HZ
         T0MF7tskAYYYSX7maoH1IZ4t57r19YNw+1TXQbcmTVkQLdcrC9bfbojv4jfsDeNbRO
         Tyq7N5ZtFltDaN+EOOkwBZk+IK9f1Ajo8CdOOyR0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txLfwePjpy4euR+VX+g44=YN=uq4OX6zEix6FWaO05PLA@mail.gmail.com>
References: <CAPM=9txLfwePjpy4euR+VX+g44=YN=uq4OX6zEix6FWaO05PLA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txLfwePjpy4euR+VX+g44=YN=uq4OX6zEix6FWaO05PLA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-01-10
X-PR-Tracked-Commit-Id: 023b3b0e139f54a680202790ba801f61aa43a5c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d25ef773538c82445ee2ea849acecc0889cc7f6
Message-Id: <157875390477.30634.10659038757747679933.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 13:55:10 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-01-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d25ef773538c82445ee2ea849acecc0889cc7f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
