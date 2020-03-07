Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEAB17CEB5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 15:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgCGOaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 09:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgCGOaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 09:30:09 -0500
Subject: Re: [GIT PULL] s390 updates for 5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583591409;
        bh=7lCgzxyiHnGiJOIf8spbcxGm+V3taEloG5KvU+xZd0U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BgTIqSWpqPNG9aHxHuOi3wONlpsr2XnkbTunA5hEnn2cQZZX44W6NvPuHSqpF7XLu
         u9ZdmZCZ2HpVM3t1OrvAh89hyTJXVsMoLbTdmolWOaJTW54Yu61fECsECWC0Y7L9Px
         eUS+TmzMMuneldXeqpUYJYHnlHRtXbSCzMR15gCM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01583586405-ext-2652@work.hours>
References: <your-ad-here.call-01583586405-ext-2652@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01583586405-ext-2652@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-5
X-PR-Tracked-Commit-Id: df057c914a9c219ac8b8ed22caf7da2f80c1fe26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d588f63602778716921bb638cda412cdeacabc8
Message-Id: <158359140906.13770.15430093611151209822.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Mar 2020 14:30:09 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 7 Mar 2020 14:06:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d588f63602778716921bb638cda412cdeacabc8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
