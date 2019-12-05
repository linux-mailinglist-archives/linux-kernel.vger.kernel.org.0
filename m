Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12DAA11484D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 21:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfLEUpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 15:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730177AbfLEUpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:45:33 -0500
Subject: Re: [GIT PULL 3/4] ARM: Device-tree updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575578732;
        bh=u16P2/XJo2OgS2ZOrQ1/YVYJNndftz8g2Q9KrGlGUe0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Akp3nAxx5CbA2r+F62QNgWkd+bkmr4zfC7eEieTcdz2nFj0960BWrBZSTs1mCD/12
         JDXfHcgzIsn8LNCdARv6c5w4rorhyCsC5LTWhgAPvJaFqFavF4A1dXkoL6NRDiWeBL
         eoIUDv6sqCMu3rny6ZensSrAgMKqxMaV0Ht0+E7o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191205180453.14056-3-olof@lixom.net>
References: <20191205180453.14056-1-olof@lixom.net>
 <20191205180453.14056-3-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191205180453.14056-3-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt
X-PR-Tracked-Commit-Id: 5f1f15283419ded3e16617ac0b79abc6f2b73bba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb275167d18684e07ee43bdc0e09a18326540461
Message-Id: <157557873271.26858.15713238410843879060.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 20:45:32 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  5 Dec 2019 10:04:52 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb275167d18684e07ee43bdc0e09a18326540461

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
