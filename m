Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4A86BFE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 18:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfGQQu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 12:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfGQQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:50:18 -0400
Subject: Re: [GIT PULL] arch/h8300 update
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563382218;
        bh=50zDFOZude2L+6XHIxUsl7zIj4hjRnFRXri7R1X89/Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ILgu+eeNQoq2wypwxJZuvXj/Ip1gmA3+YTYXiwLfiBVS863/aHOmSYQi+HNGr/O/f
         PiRJkrw7px3mZ15TK/z3ePl09tNvR4F3Qs+QaQsf6wM27WCHqQo8qAQtEEFx+/GsKw
         3B6KXFHyGopIQ6XYGSI6D9e/y64YL7yZCCTix1L8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y30xozv8.wl-ysato@users.sourceforge.jp>
References: <87y30xozv8.wl-ysato@users.sourceforge.jp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y30xozv8.wl-ysato@users.sourceforge.jp>
X-PR-Tracked-Remote: git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git
 tags/h8300-for-linus-20190617
X-PR-Tracked-Commit-Id: 38ef0515e1e89794ad1797ce5fadbface4bec216
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d4901c08ae573e569dd01a29bef2ad404a40f97
Message-Id: <156338221801.6265.10102605162804905710.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 16:50:18 +0000
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Jul 2019 16:59:39 +0900:

> git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git tags/h8300-for-linus-20190617

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d4901c08ae573e569dd01a29bef2ad404a40f97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
