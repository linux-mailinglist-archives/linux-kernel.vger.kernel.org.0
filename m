Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8455917EB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 18:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfHRQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 12:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfHRQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:55:07 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566147307;
        bh=sWRe/CQjf3t7kQxAxSn88AeRDNT7M7B7LJSjLJv4W60=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wOpqtg5Pw9z1f2vNZMhXPzpcLL+ohv0M43Oz6MI2s1iFrBc0w0/nFfdNR/mKKL9To
         ginMwtsQw3HkrFpO/cLnQNT1Z6kpGsKzGJmoYJ0jWkvzoWVzlgRNOjJlCnfDinr10r
         s4xi0qJVs9CVLC3gQg5Oj2zuuCEEqhdx+f4kcpyk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190818085732.GA28776@kroah.com>
References: <20190818085732.GA28776@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190818085732.GA28776@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.3-rc5
X-PR-Tracked-Commit-Id: 9cd02b09a0f4439e5323c20b710331771c2b6341
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4503c0a41571bf17ef49bd147da83250d86ff7d5
Message-Id: <156614730697.21549.6783065548998512514.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Aug 2019 16:55:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Aug 2019 10:57:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4503c0a41571bf17ef49bd147da83250d86ff7d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
