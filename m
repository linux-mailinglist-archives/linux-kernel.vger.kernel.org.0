Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A282FAC9C6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 01:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393272AbfIGWzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Sep 2019 18:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbfIGWzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 18:55:06 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.3-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567896906;
        bh=XDIo+Hwz4oIoUUbQhahTifml4wkcSYCMHOgALDPpRWY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UQc5FZ4KD/syLdkjlKv63/bjKE3wunzXxU2sC8YHXjCjlfvzCZlIOerOklSB8hqlO
         e1ItU3hg8h2R0OTWFnFeLWfxLKFdRHcvtO4OcSlfMvUX5XDZaR7m8YyuB/I2DuXICA
         kCvOL2spWB65AKDSjxASZnZUYUkldMTvXOUu/rNQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190907184033.GA29833@kroah.com>
References: <20190907184033.GA29833@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190907184033.GA29833@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.3-rc8
X-PR-Tracked-Commit-Id: a8e0abae2fe0e788fa3d92c043605d1211c13735
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3a9964cfa690150e49ae75ba16416ccaac3a8ba
Message-Id: <156789690608.22328.15231426646920271750.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Sep 2019 22:55:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 7 Sep 2019 19:40:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3a9964cfa690150e49ae75ba16416ccaac3a8ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
