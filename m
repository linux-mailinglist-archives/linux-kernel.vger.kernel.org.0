Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2FDA141991
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 21:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgARUUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 15:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgARUUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:20:03 -0500
Subject: Re: [GIT PULL] USB fixes for 5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579378803;
        bh=XPZtxr4dzWMQXKp7e5UgSnlVnbcpw83HtxfxB94j8aQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0zRrG7tpiVOYTJMWq+RHON0+2IwMh7L8BoLcOXkVLFxOcMpZCmBkgVGcnDw1AFVAu
         Lb2KaL+sr9anRzfgtYodU1MfFLEbfVUip8j9MXancr1zEOX4gscKATJtZv9bWt9BTf
         8OIkPDnsGe9DS63TGLfPf46rrZmzvzNE+HK0rU7Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118142250.GA80066@kroah.com>
References: <20200118142250.GA80066@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118142250.GA80066@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc7
X-PR-Tracked-Commit-Id: 453495d4e791664e42be2254a6a8acb84b991417
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5fd2c5b8bcd274718c3370b39913f68587fb9cc
Message-Id: <157937880293.12197.10775468140896729151.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 20:20:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 15:22:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5fd2c5b8bcd274718c3370b39913f68587fb9cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
