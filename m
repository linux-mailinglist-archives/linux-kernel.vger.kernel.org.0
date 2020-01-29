Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9314D0D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 20:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgA2TAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 14:00:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgA2TAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:00:08 -0500
Subject: Re: [GIT PULL] TTY/Serial driver patches for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324408;
        bh=zdIi9qbq49yLTacNNV0GW8oZspiKmsOdTO0j9aGqCoc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uIQXCt6Dy9+TGQOWQJgImK0ObAeabItJMk8125GSntAHoVBUL9gL3r3OdfXlgawJj
         rZU3pqZEtVmBKOmwnYIJo836+n0bHKBs8gZFD7vg74VyojfsOEyk6328sur6vaB8iD
         L4YP33JacyLjiD07oxh2xWDZSLPOsz3M1FU25TXA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129101420.GA3858344@kroah.com>
References: <20200129101420.GA3858344@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129101420.GA3858344@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc1
X-PR-Tracked-Commit-Id: 85f4c95172d606dd66f7ee1fa50c45a245535ffd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca9b5b6283984f67434cee810f3b08e19630226d
Message-Id: <158032440840.15518.11492001728736110702.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 19:00:08 +0000
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

The pull request you sent on Wed, 29 Jan 2020 11:14:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca9b5b6283984f67434cee810f3b08e19630226d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
