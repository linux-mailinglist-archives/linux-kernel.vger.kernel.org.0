Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D19A39732
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 23:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbfFGVA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 17:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbfFGVAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:00:12 -0400
Subject: Re: [GIT PULL] MMC and MEMSTICK fixes for v5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559941212;
        bh=fVk0SXLHYBo+H7apZADfdbeyjNj/k87dTjBtfVC6TTY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ShQxRagJGilVVZuPsVgMBQ5ye3WRYJbmPPhmMyYHw1iflyScN41yGDVQjZ8wcyzHv
         5zDY/kDZCWLFBemB07t6yoK6bjAU7vmMb7e0i45oHK1obxMFTbLJc+RW36x0Fw5xqN
         vSKrCxpJw7PhIA+zXhepBTcAa3D6DVxtsC29C+4s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190607103911.4623-1-ulf.hansson@linaro.org>
References: <20190607103911.4623-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190607103911.4623-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-rc2
X-PR-Tracked-Commit-Id: 7397993145872c74871ab2aa7fa26a427144088a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91f152e75bcdba95130ec5fdb1010e91a48d9a11
Message-Id: <155994121222.4194.16757914361173670130.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jun 2019 21:00:12 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  7 Jun 2019 12:39:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91f152e75bcdba95130ec5fdb1010e91a48d9a11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
