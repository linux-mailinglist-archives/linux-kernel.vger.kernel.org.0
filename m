Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4FD11F495
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 23:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLNWFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 17:05:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfLNWFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:05:16 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576361115;
        bh=4Co+FmvYdDnhyxGoDWmd+VJdV7m3hfhMKa5ZESBkU3c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LDGMYSFFu+t7D25bBLKgUYysOX9B3dnk4UKjVqMCiZTe1ZtrmcruEY2tcHtDPBEj7
         +dl7zJ1e7yJgLb26hler+zZBV5JkbJR4BXU0aYBBPv3wGky7BSgmIHIR5zNco9q0+B
         g2RoiACXQzHj7ep9L7R/gonNcYaV0y2ccDf26KdU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191214152848.GA3460394@kroah.com>
References: <20191214152848.GA3460394@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191214152848.GA3460394@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.5-rc2
X-PR-Tracked-Commit-Id: 16981742717b04644a41052570fb502682a315d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f61cf8decb37e7244247129163bf69b45dd3b1cd
Message-Id: <157636111594.10255.15690921244272218858.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Dec 2019 22:05:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Dec 2019 16:28:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f61cf8decb37e7244247129163bf69b45dd3b1cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
