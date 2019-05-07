Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C1716C9C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 22:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfEGUuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 16:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfEGUuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:50:12 -0400
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557262211;
        bh=FZRrrg1TyoUNC5xRkX5JR0KjLAaP0iMlAa87oIVA11c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x29KDaY4HjUnRcVv6Eih8ZZmpa7SKAPNnT2vOLV/ki1VvSNDNb0G19wF2DSLVIKvB
         +WpMSJ2V8dwAXr8NPqnM1YRZUwW85gZV4O/RYqk/pXNslG48BZSbw8yWPoTA+9Nw8S
         wvENVmmgQ3DX+x1nq0kCR9R7TcnVBBDpDBypCDao=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507063634.8389-1-ulf.hansson@linaro.org>
References: <20190507063634.8389-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507063634.8389-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2
X-PR-Tracked-Commit-Id: 0a49a619e7e1aeb3f5f5511ca59314423c83dae2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01e5d1830cf54ac45768ef9ceb3e79cea2e1198c
Message-Id: <155726221151.25781.8513027415507932258.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 20:50:11 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  7 May 2019 08:36:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01e5d1830cf54ac45768ef9ceb3e79cea2e1198c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
