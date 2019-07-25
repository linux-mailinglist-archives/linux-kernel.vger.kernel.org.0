Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F58753E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390503AbfGYQZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 12:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387677AbfGYQZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:25:19 -0400
Subject: Re: [GIT PULL] ktest: Fix some typos in config-bisect.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564071918;
        bh=3LH01SBWhzp8lTHtgUqSeEpR+jY+FtOs7mMAkGQMU9s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s/aC2bf8iBfHDvQtvsWB16fA7c6WIX67h/xD0re24JCTwKilukF7/cvoiCulM+BuR
         oNFQLQnmUFHrR9Kxtn5KVgOfLB+q/9yuBMClieeaDb/bbk7h9uyaaZqwmZWjzpD2G5
         Qu2QTY+hr79d3Pmh5zAsYFVA/GMO2NJKbfQcRHrY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190724154711.2698f244@gandalf.local.home>
References: <20190724154711.2698f244@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190724154711.2698f244@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
 ktest-v5.3
X-PR-Tracked-Commit-Id: aecea57f84b0586b62c010bea946468d77f6bf0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da3cc2e6f168fd52630892f4672f2f26bd217198
Message-Id: <156407191874.26857.545577017149394846.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Jul 2019 16:25:18 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Jul 2019 15:47:11 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da3cc2e6f168fd52630892f4672f2f26bd217198

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
