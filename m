Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2780B195D93
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 19:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0SZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 14:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0SZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:25:07 -0400
Subject: Re: [GIT PULL] arm64 fix for -rc8/final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585333507;
        bh=tCz41BqwHEwUUlDh+Nz7eMa26/KTYG03tKBx1/J95Ew=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SA+mlEOvnph3AnVH3GqHBCUxqz44pqMR7G82jSfIn537g8nBywb0/L2Gt81aMGiHR
         Cxhp3TcFxk/Z2g7lEJmPutlef0OHrYH7IRy/FdixyefTRi4ouWNputOFheIwAHjUd6
         xr4OKl5vGEhtcCkJeayDQmVRaHtWRstaiKHUUO2o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200327143655.GA6205@willie-the-truck>
References: <20200327143655.GA6205@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200327143655.GA6205@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 6f5459da2b8736720afdbd67c4bd2d1edba7d0e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fa8cb0b7b11f3bbfe799d73f351e44a441903ca
Message-Id: <158533350713.5176.14800079996029245932.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Mar 2020 18:25:07 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Mar 2020 14:36:56 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fa8cb0b7b11f3bbfe799d73f351e44a441903ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
