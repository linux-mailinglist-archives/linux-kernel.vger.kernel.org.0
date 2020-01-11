Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480BF13819C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 15:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgAKOpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 09:45:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729923AbgAKOpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:08 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753908;
        bh=cO1wjOjYcxCtX8KilZ8TVi7y3f0TknkORVJfIF/+3vY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZN1PObGIqHepHrf93eP7Yw/jpGd8RKsyI3n4rKy1R2Lc3t4jptXc3Tj4ZsdNntMPY
         eWTIooCv/w4cseX1xLs6PIupyGm2FDRCZKYMV9MW2i58eX17s7oZoMWJaYoH6Dt0Mj
         xVcz625qZ9IAR6q2VEfIrt2TdbpSceXxpqMIR5RE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200110210906.GA1871197@kroah.com>
References: <20200110210906.GA1871197@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200110210906.GA1871197@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.5-rc6
X-PR-Tracked-Commit-Id: 68faa679b8be1a74e6663c21c3a9d25d32f1c079
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fb7007de8a2a80e4b55a850311fca10de62f1b5
Message-Id: <157875390813.30634.5471701512268793748.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 22:09:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fb7007de8a2a80e4b55a850311fca10de62f1b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
