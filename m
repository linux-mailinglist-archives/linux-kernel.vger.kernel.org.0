Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BB15778
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 03:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfEGBzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 21:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfEGBzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 21:55:05 -0400
Subject: Re: [GIT PULL] s390 patches for the 5.2 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557194104;
        bh=J0XSLb9bZQ2z65RsxlBsvSBjyBFEVvAj9sTVz2T+fmg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vo+3Mih6zp/EzhIxvy+ZvsedGNym+DEdqowWF9T+odRr07H+mBdPuAvSMi8trsF6b
         XvHLRPPEwxzv/epEs5Vx/0EMA+xkkRxFWnvpM3gtNC6gaKQ6ofhK9fyteAEZkVwpTW
         itw1Rx7LI+l42HM6G2sVqf7wlYFqJQ9N2gb23etM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506140009.05dbc545@mschwideX1>
References: <20190506140009.05dbc545@mschwideX1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506140009.05dbc545@mschwideX1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
 s390-5.2-1
X-PR-Tracked-Commit-Id: ce968f6012f632bbe071839d229db77c45fc38d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14be4c61c205dcb0a72251c1e2790814181bd9ba
Message-Id: <155719410489.3542.2351643606761014033.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 01:55:04 +0000
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 14:00:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux s390-5.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14be4c61c205dcb0a72251c1e2790814181bd9ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
