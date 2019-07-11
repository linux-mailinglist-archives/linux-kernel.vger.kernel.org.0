Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D10661EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfGKWpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 18:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbfGKWpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:45:13 -0400
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562885113;
        bh=QcCWgRPOwh+6i/x1cfyarCY93p1W+YzQNdep5qRmYR4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UPEh/bTcG1miiqyLCzdvyYFdy9yDfyb+Xg+p6E0jTmv+z8zP9Dl25XegLyXaNMLgI
         gbQF3jJLKlVjiR42kTGYgk4UfWSspQYx4W6hWngLnSmqLmkEObvpdGLTqcQ50vUzc4
         GZ/Xxy9GZ8wjxtsHz1v7L9Z7jo4+Y8weDg0MeSlY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190710133215.GA24032@kroah.com>
References: <20190710133215.GA24032@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190710133215.GA24032@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.3-rc1
X-PR-Tracked-Commit-Id: 5d1532482943403eb11911898565628fa45863d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e786741ff1b52769b044b7f4407f39cd13ee5d2d
Message-Id: <156288511317.25905.10363072762296514346.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 22:45:13 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jul 2019 15:32:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e786741ff1b52769b044b7f4407f39cd13ee5d2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
