Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CFF88CE9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 21:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfHJTaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 15:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfHJTaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:30:11 -0400
Subject: Re: [GIT PULL] TTY/Serial fixes for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565465410;
        bh=/uwnN9ol/pvVpE+zhTo00NNtMbmXhGzJs1kngjeKvxM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=twZBSf7VgCDpq4HSYYzax+jhRO9Y3f7FPMcfr9l7hF5BZl3xVEXoN7HwbTY1qkE9N
         2uNBLrF8y7ZxLqd7SkxA6rHOONgmuWt6/vKQUev8VO1+RDPZaYpqHw/pXdzfKLVhFB
         4YhFRBlooPZlqrC4aueVlLiEUTxCv9CTkNbvvATU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190810115235.GA5930@kroah.com>
References: <20190810115235.GA5930@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190810115235.GA5930@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.3-rc4
X-PR-Tracked-Commit-Id: 81eaadcae81b4c1bf01649a3053d1f54e2d81cf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c13f86701e1e03fa3f94165d46425ead51a191c8
Message-Id: <156546541092.17840.18172607320518046045.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 19:30:10 +0000
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

The pull request you sent on Sat, 10 Aug 2019 13:52:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c13f86701e1e03fa3f94165d46425ead51a191c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
