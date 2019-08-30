Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA1BDA3D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 20:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfH3SUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 14:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfH3SUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:20:08 -0400
Subject: Re: [GIT PULL] ARM: SoC fixes for Linux-5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567189208;
        bh=N9y441JIopSKRxwCR9lDEIsSFrRVqdjLn0qGDxU4AuE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ojjwe9vifvRZzf6W+E1JmYKF0jUTSuahx4jPVovVYAu6PFeQP9UCrziQ8tlvSs/qe
         vRpWArlnu91dxw1kG+XqyMwL1KnWadLcQMXmuM5ZrryAbcn67KpQYdbDNlMoheCNar
         jDuq61p4SZpUZPdg9URJ3ZjzQyFu52DzYgm7fjIY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a2OZPybUQ=2xXcF4Qft-Gpe3a1mvgPncJZugETnaOxsvw@mail.gmail.com>
References: <CAK8P3a2OZPybUQ=2xXcF4Qft-Gpe3a1mvgPncJZugETnaOxsvw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a2OZPybUQ=2xXcF4Qft-Gpe3a1mvgPncJZugETnaOxsvw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git armsoc-fixes
X-PR-Tracked-Commit-Id: 7a6c9dbb36a415c5901313fc89871fd19f533656
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8d6766f3cc8318e8fcaa5ef2d1af4d2d9903af3
Message-Id: <156718920798.24554.16156068086247893929.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Aug 2019 18:20:07 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Aug 2019 18:25:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8d6766f3cc8318e8fcaa5ef2d1af4d2d9903af3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
