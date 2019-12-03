Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F380111B85
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 23:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfLCWP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 17:15:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:32902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfLCWPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:15:25 -0500
Subject: Re: [GIT PULL] TTY/Serial patches for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575411325;
        bh=+Z+a5IEPBZ5qDsgOA0OTGJytu+b3FaX06DhdC0cd9Mo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mPwQQZ4gc6XqGCiednwfZXncxE2JzKwQ4Dz34LabAIsUpkDn1A7BrEaTcNM+BJdQ9
         l/GklyIzYZeEQ4whfjn/PPyZiwiYB+RVQdFnTtpPxwnw0CtjUyKSQYTSz8gENTUSnd
         v3qgpLrgdrDWh2dG+xF5p0SnNeLeAInYbkk0BC7Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191203202946.GA3188593@kroah.com>
References: <20191203202946.GA3188593@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191203202946.GA3188593@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc1
X-PR-Tracked-Commit-Id: 27ed14d0ecb38516b6f3c6fdcd62c25c9454f979
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 537bd0a159a041fad72d257d755205cef77582e1
Message-Id: <157541132537.3528.14317594495130905675.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 22:15:25 +0000
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

The pull request you sent on Tue, 3 Dec 2019 21:29:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/537bd0a159a041fad72d257d755205cef77582e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
