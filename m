Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF0CB6A65
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 20:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbfIRSUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 14:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388027AbfIRSU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:20:26 -0400
Subject: Re: [GIT PULL] Driver core patches for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568830826;
        bh=p+DBCmUssmD+0uwaXcdaHDQ2+AftMj0FAukV4z4JcBc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F84Fp4rkNZM0rrcEyzO4i0uKtjego/1yfWuw7UeeRs8M3eVfZRqCWCNkCtFRazSZQ
         J3jHeGc6ddg1cBcOYpW8YxqfidUH5xJfZihyo6xogNF+Dh14TiUntI4ITMzZ5JhRWT
         9guBCglmbXBWrSTy30wW/5rgyHTH8Y4vlh6VKeYc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190918114814.GA1899579@kroah.com>
References: <20190918114814.GA1899579@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190918114814.GA1899579@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.4-rc1
X-PR-Tracked-Commit-Id: ca7ce5a2710ad2a57bf7d0c4c712590bb69a5e1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f7d290a7275edb270dbee13212c37cb59940221
Message-Id: <156883082651.23903.8473821340269128046.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 18:20:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Sep 2019 13:48:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f7d290a7275edb270dbee13212c37cb59940221

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
