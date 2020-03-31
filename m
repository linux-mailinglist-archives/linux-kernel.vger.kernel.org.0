Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4581919A2A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 01:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgCaXzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 19:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732027AbgCaXzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:55:11 -0400
Subject: Re: [GIT PULL] TTY/Serial driver patches for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585698910;
        bh=UOe3hAzjJP3cEHW26WIiaaqokN487k//4mNygjs9d5g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D6stzbEa9x1tpQx1oE/GwEfhxHkhgrM2PFjRVY66SV5/SZwpluVq7oFO4sYjKk7cC
         CajOPtVTmoZz9SnIxBmNrhGNb/ok5Yzn+rL2JEYuVCkRPOUjbdrnpXhGIBU9N9xpBo
         iKxmT+++bdzFp387sugom5Wz1Yw6RjfMWhEMKspk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331073140.GA855734@kroah.com>
References: <20200331073140.GA855734@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331073140.GA855734@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc1
X-PR-Tracked-Commit-Id: 8d5b305484e8a3216eeb700ed6c6de870306adbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f944f976d7ef8a29d1ad296253d3a9387c58e62
Message-Id: <158569891089.16027.10522517027115385120.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 23:55:10 +0000
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

The pull request you sent on Tue, 31 Mar 2020 09:31:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f944f976d7ef8a29d1ad296253d3a9387c58e62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
