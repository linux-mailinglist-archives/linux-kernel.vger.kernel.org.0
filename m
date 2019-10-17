Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF748DB8D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 23:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441189AbfJQVKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 17:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732368AbfJQVKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:10:05 -0400
Subject: Re: [git pull] drm fixes for 5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571346604;
        bh=bXdvTXzHicshgQU7A306M8DvJ2HYKgVe4uQXzS+CrDA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qi7ztRjI0mx1sl9UF8nosrNQvBuBdOchlXAbKs9yN81wvYiVQypCep7ByHZo6z/1N
         afcHuM+4B4jPIx6bJYuSNqRQaqXfpTA6ucGGCh1jdCcA4pgLL6Vmxv5y0osA9rumal
         f35ibsOl/RxSvzKwhiduiXCakwXQvusHN/ScDz/o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twCjJ3XuEk4UDZYa_c8BR4K6D0DEVktay-Soaxrwkek6A@mail.gmail.com>
References: <CAPM=9twCjJ3XuEk4UDZYa_c8BR4K6D0DEVktay-Soaxrwkek6A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twCjJ3XuEk4UDZYa_c8BR4K6D0DEVktay-Soaxrwkek6A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-10-18
X-PR-Tracked-Commit-Id: 5c1e34b5159ec65bf33e2c1a62fa7158132c10cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 839e0f04b50441d1f6593070b574b7933e903c7c
Message-Id: <157134660491.21346.5449126901245273926.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Oct 2019 21:10:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Oct 2019 06:53:55 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-10-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/839e0f04b50441d1f6593070b574b7933e903c7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
