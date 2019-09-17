Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1266CB58AD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 01:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfIQXkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 19:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbfIQXkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:40:23 -0400
Subject: Re: [GIT PULL] s390 patches for the 5.4 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568763623;
        bh=zMgUodvDhzGoajpg/NeLC4oka14CdB41NmzKPrId6IM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o6IUS138UCEqvVKvLg4M71pl8KvoD8Bh+6cBkVx+Y0CwAJIfuffpGsOvluYXwEAV0
         kWCTwmTXCKG5KkT1zm1eDB27lfxgdhffAeiYz2Me6RFLtvZc62LTfLsNXDW44FOiGW
         p/Qg54nB3QU/1Y4N4cVxKnkE7MGm8sCR09CclZSg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01568730434-ext-0126@work.hours>
References: <your-ad-here.call-01568730434-ext-0126@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01568730434-ext-0126@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-1
X-PR-Tracked-Commit-Id: 2735913c1079b7dd7ec1d746c13a84ec1b5ea276
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d590284419b1d7cc2dc646e9bdde4da19061cf0f
Message-Id: <156876362346.26432.3024890958497889434.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 23:40:23 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 16:27:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d590284419b1d7cc2dc646e9bdde4da19061cf0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
