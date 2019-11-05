Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFFDF0599
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 20:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390857AbfKETFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 14:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390788AbfKETFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:05:05 -0500
Subject: Re: [GIT PULL] thread fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572980704;
        bh=dIAjqaYYNvND9C33lDNwSkYedAXxfhz8LBH853xeGGI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MOFSvPsiPdJmMJuf795epdntFemLSsckvPP6Lh5XLZjx+0mvJ95ZHvKPSrJzT+0zd
         Gx3pgc/yFkmPKFzTwrt2Feh50290Y+7kNPUDWWwYVy7jtT4yI+zYXX9Q6q3GDLpEZ8
         qDrRJuaG3imclVTQwhBe3ysGwWF3Y+RAO92r/yF8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191105155217.23759-1-christian.brauner@ubuntu.com>
References: <20191105155217.23759-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191105155217.23759-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2019-11-05
X-PR-Tracked-Commit-Id: fa729c4df558936b4a1a7b3e2234011f44ede28b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26bc672134241a080a83b2ab9aa8abede8d30e1c
Message-Id: <157298070465.13819.10739983785968610279.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Nov 2019 19:05:04 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  5 Nov 2019 16:52:17 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2019-11-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26bc672134241a080a83b2ab9aa8abede8d30e1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
