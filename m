Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3902B9FCE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 23:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfIUVu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 17:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfIUVuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 17:50:25 -0400
Subject: Re: [GIT PULL] f2fs for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569102625;
        bh=FRICCBxIG2+cPRdX2HnJLSb/E67b62xdt0okJO51rDM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cRVf04bjPWLl4HyRtHXj7Xntp0uRsP0voDE5HUkNbon4Cqt1gWiQAXBqn3lUCfAqE
         SkufjRkdXR5Aer1JNvzNuH/tTE8Wz3mTuy0cOgiNDsbJz5qgkggSaXbq7Jy3kTM245
         3zaFKnSoYheMT0ZQLH/rG1sE02N9AVknEMuPfggU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190920200107.GA57911@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190920200107.GA57911@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190920200107.GA57911@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.4
X-PR-Tracked-Commit-Id: fbbf779989d2ef9a51daaa4e53c0b2ecc8c55c4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbc246a12aac27f7b25a37f9398bb3bc552cec92
Message-Id: <156910262496.18589.7479409845792193143.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 21:50:24 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Sep 2019 13:01:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbc246a12aac27f7b25a37f9398bb3bc552cec92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
