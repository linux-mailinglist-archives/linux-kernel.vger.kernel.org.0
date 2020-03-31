Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62AD6198A43
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 05:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgCaDAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 23:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbgCaDAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 23:00:12 -0400
Subject: Re: [GIT pull] irq/core for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585623611;
        bh=hLbfkTwGG4OlxUYGvVI8u+brKn5MuyYEBbDZswRhEs0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pB4vbyFRfQ8zT3n1+urO4YhF4jYsi6Snv97DHCbd7z1Eur7pR/NtD0kyb6Jpp2gVT
         ENo1RwQbRuaWYsOVG1xTeOkeOty5pmSP0WCGGkuFnWwZt/YRd7XOD78IxhiEqIP84A
         gB529RInNDZrkIo0ALumC5abKmVpWhXhrxK1mpjs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
References: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-03-30
X-PR-Tracked-Commit-Id: 8a13b02a010a743ea0725e9a5454f42cddb65cf0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d385336afcc43732aef1d51528c03f177ecd54e
Message-Id: <158562361189.8590.6155892416047441359.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 03:00:11 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 14:47:09 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-03-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d385336afcc43732aef1d51528c03f177ecd54e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
