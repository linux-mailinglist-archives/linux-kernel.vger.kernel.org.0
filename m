Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42087128251
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 19:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfLTSpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 13:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfLTSpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:45:11 -0500
Subject: Re: [GIT PULL] MMC fixes for v5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576867511;
        bh=06/H4yzAFr64dQaCCIAYb1CMj6YbYOq3pQUzLQk9D+c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tqvAV1CDG9u9Xk3eYg54Ib4X+tFuyGsZuDm9vVJQ7DNO5HoRAbMP2s65H3UzfTaPV
         Dk4blxSL9x0oGmN7xeBvMSSMXta3eS1WjJ4PZRFGfjQ4QrTWkRwOfcw5Vzs0VlDuLb
         bHKdJuuoy7QhcZ/2+DbOjybNVfHerCk0HuO6X/wg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191220092503.22211-1-ulf.hansson@linaro.org>
References: <20191220092503.22211-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191220092503.22211-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.5-rc2
X-PR-Tracked-Commit-Id: f667216c5c7c967c3e568cdddefb51fe606bfe26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2944d531380110fb060ed0a9888eae91dc5861e
Message-Id: <157686751128.22538.16515649857400230184.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Dec 2019 18:45:11 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Dec 2019 10:25:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2944d531380110fb060ed0a9888eae91dc5861e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
