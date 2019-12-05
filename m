Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1A113A70
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 04:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfLEDfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 22:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbfLEDfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 22:35:20 -0500
Subject: Re: [GIT PULL] ARC updates for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575516919;
        bh=NiYp9U/XFxyql0Zk6ev5H+IOXmcW2M3uh/Fhv7CK/38=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AR0GLxf2kqzgn6nJMihjWrEl+u7SWcPHQ52ZGLbjy7jLApkRBh56WGhj5mInrNVgl
         iCXPj20+9QunG+FklhhKqMavPgCEKA7wWsXl57R3QArmrdo6owMI3bYLOMkYIuEYTv
         lstfCKNQ9TsO70dFX62HWKog1zM6VCAKgqdgx8W8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <79e777e1-9b20-6db2-9f0f-2e9f943336b9@synopsys.com>
References: <79e777e1-9b20-6db2-9f0f-2e9f943336b9@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <79e777e1-9b20-6db2-9f0f-2e9f943336b9@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.5-rc1
X-PR-Tracked-Commit-Id: 9fbea0b7e842890a76acffce9be9e430b9e11194
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 056df578c2dcac1e624254567f5df5ddaa223234
Message-Id: <157551691982.27004.10450647025342052873.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 03:35:19 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 4 Dec 2019 23:03:03 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/056df578c2dcac1e624254567f5df5ddaa223234

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
