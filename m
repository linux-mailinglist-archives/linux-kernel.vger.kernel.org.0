Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF6F7809F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfG1RaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 13:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfG1RaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:30:22 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564335021;
        bh=SuEXYkOpQPHq4xQJmB6asVtiSgKN+MCRg+dfScPj9c8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gWite8WlLGvJbZG6g+Qn1rGBLn3F+xguSTbsYBLQgyT2/Mx+pPm6x5nZ8n1ihmEIy
         loxztgXh5vkkd+/uOPLce6BAP2KwvrFZtc/L79uyVm/O8CVl0gaOamN7r4EfA5cV19
         XV6zmYAlbH1TguNGKwGc73xSDNgQK5/QoW8dMed8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190728120155.GA16225@kroah.com>
References: <20190728120155.GA16225@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190728120155.GA16225@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.3-rc2
X-PR-Tracked-Commit-Id: d4fddac5a51c378c5d3e68658816c37132611e1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04ce9318898b294001459b5d705795085a9eac64
Message-Id: <156433502164.9558.9371574085138074582.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 17:30:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jul 2019 14:01:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04ce9318898b294001459b5d705795085a9eac64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
