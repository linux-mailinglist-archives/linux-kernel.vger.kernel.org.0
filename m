Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB16E13819D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 15:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgAKOpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 09:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbgAKOpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:08 -0500
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753907;
        bh=tcWWBa8JAIlJo0eqgfrqcM9l4c/KaWN5zRdwvnRbBH8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dXnbUi+5YZMW6XxrqXUgpoaXM4jERQqY+6sTIPOCPJFj7+KFaMBoLYqbGCYh2o/Ki
         mmM0Am1eKMGBAC3rQX8UX9G8yV5bduwQnbevXbJx2fWmeHYY6nyf2LBW9taGkDy1Sj
         9ESKUpP8wapGgKZz8Y1dbqOkxDs3bsR+hqH1r4Ug=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200110210835.GA1871048@kroah.com>
References: <20200110210835.GA1871048@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200110210835.GA1871048@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc6
X-PR-Tracked-Commit-Id: c5ee0b3104e0b292d353e63fd31cb8c692645d8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a96c0bbff8690afb3a2fcfc80208cd6590f6e88
Message-Id: <157875390768.30634.11870665450842288025.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:07 +0000
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

The pull request you sent on Fri, 10 Jan 2020 22:08:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a96c0bbff8690afb3a2fcfc80208cd6590f6e88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
