Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A0F11F499
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 23:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfLNWF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 17:05:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfLNWFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:05:15 -0500
Subject: Re: [GIT PULL] Driver core fixes for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576361115;
        bh=bYqmOj491EOyOv7eR425pvyWyV9wjzuh+dQsccpdHpc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vFhnU4zLamDm6k0lJW0k/OpsRtrlNKHGM/1j5qkDSPNKT6WSRJXavV+NERWZcU5Jg
         aJcD1IHQDYJ6NPMDhg1LxNa21+KD5FIrxLyByAv8p+/6QuU1p2wIwj++LqZec9x03b
         XVvNweEyKF4qjzfwi+HJlTY7fRxCZ3hcdk/Jri9k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191214152815.GA3460263@kroah.com>
References: <20191214152815.GA3460263@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191214152815.GA3460263@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.5-rc2
X-PR-Tracked-Commit-Id: eecd37e105f0137af0d1b726bf61ff35d1d7d2eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 894554c1ca793ad96a26b7c9f1eedd043e9e8164
Message-Id: <157636111547.10255.1646057568439910021.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Dec 2019 22:05:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Dec 2019 16:28:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/894554c1ca793ad96a26b7c9f1eedd043e9e8164

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
