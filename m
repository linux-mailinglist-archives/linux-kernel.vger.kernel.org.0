Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77FCBF6BAB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 22:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKJVpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 16:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfKJVpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:45:06 -0500
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573422306;
        bh=6ztCkRLgUdLXLrPFiMrkTkRl+X/swTXQkXHriYk06lo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wnKx7IGC6AE9osQ8BEpJ34GvsqZJi8eoE0y9hVGUIYpGEe27tpp34kNLtWon9pDYn
         LYCUZh2LiGhDxKm1hV2s5bghEFGwcsD98ewKZyjBap47EXftTps6M2R/9Qr1DW/yQg
         p5dr1phjUYHMGBdrRHWVE5NzHjuS6hcn/pl/JNO4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191110182506.a2o7r5nyoqaz27gc@localhost>
References: <20191110182506.a2o7r5nyoqaz27gc@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191110182506.a2o7r5nyoqaz27gc@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 002d3c65ee81a604430da61e20de7a5b32a0afd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44866956804eb0904f733d8436bfb56245578870
Message-Id: <157342230601.7021.10139790143615521649.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Nov 2019 21:45:06 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Nov 2019 10:25:06 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44866956804eb0904f733d8436bfb56245578870

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
