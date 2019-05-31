Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D820C313C7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfEaRZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 13:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfEaRZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:25:14 -0400
Subject: Re: [GIT PULL] TTY/Serial fixes for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559323514;
        bh=8C1kYFxhylJixHATVxhg0z9Zol+nH8uuB6t9W6CJvPM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R0Jk9EG7qy4Mi3mGl8pSED7JrFRe+630ZApw+8K6vsnZEnNTfXM45neKCr8tJJRnM
         sTH3NxBSGldfdJF/+2vf4vHrxw4Q8pWnljpljxr8FMzlE7XEV9G4M86Xbyb4Kwyysq
         ll6gtf67Vuq7SgEuv5uHh0DuLX2cfoobITDVcurc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190531014702.GA30713@kroah.com>
References: <20190531014702.GA30713@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190531014702.GA30713@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.2-rc3
X-PR-Tracked-Commit-Id: a1ad1cc9704f64c169261a76e1aee1cf1ae51832
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbde71df810c62e72e2aa6d88a0686a6092956cd
Message-Id: <155932351439.8550.1054897275048374287.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 17:25:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 May 2019 18:47:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbde71df810c62e72e2aa6d88a0686a6092956cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
