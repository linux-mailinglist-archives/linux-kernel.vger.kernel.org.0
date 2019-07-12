Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5373A676BE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 01:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfGLXUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 19:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfGLXUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:20:18 -0400
Subject: Re: [GIT PULL] s390 patches for the 5.3 merge window #2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562973617;
        bh=UbDwO0hPoAT6tNQH1RNhMQuaHBVFR2S62TNE6un9oEU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jqp1taGA5Lp3AWNqaO28O5T1qhsimaT9wyzmA5S1GN5BtT3Q+r6OIpB99YBXc874P
         ReoP7lej9VLTV48WbOjrIoy5VdvE22bfT2GS/5kWihSQSTCl6rA4OKShF9SCTVDJJw
         /4YXxi02TQ1E45gYQ+6EdkeH1O2gjiKc8bOn62FY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01562942374-ext-9116@work.hours>
References: <your-ad-here.call-01562942374-ext-9116@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01562942374-ext-9116@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-2
X-PR-Tracked-Commit-Id: 9a159190414d461fdac7ae5bb749c2d532b35419
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aabfea8dc91cf5b220d2ed85e8f6395a9b140371
Message-Id: <156297361734.22922.4390324426377823480.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jul 2019 23:20:17 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 16:39:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aabfea8dc91cf5b220d2ed85e8f6395a9b140371

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
