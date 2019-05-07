Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2C515809
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 05:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfEGDZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 23:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfEGDZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:25:05 -0400
Subject: Re: [GIT PULL] hwmon updates for hwmon-for-v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557199504;
        bh=uM3lfyPLmhjp5BcCgs2DlhZ9Zy4Arr+2APa1wnqxNsk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JOlWx/76OhvBtLeHXZyn/rJW0ICGXPBrWULh7KFzoViK6qhcwOLK0/qwwgG+DzdKo
         dYFd16qOW/IzHmWp/3W0UgiKFQK/cTRssZ1egFBP6mt70aws7UtEmj01EXTnSBbbdE
         bp0CdjFKM0v+7/50SRTD3QofJuSPiINd9F06UNqI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1557148847-18835-1-git-send-email-linux@roeck-us.net>
References: <1557148847-18835-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1557148847-18835-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.2
X-PR-Tracked-Commit-Id: 39abe9d88b30a51029b0b29a708a4f4459034565
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7aefd944f038c7469571adb37769cb6f3924ecfa
Message-Id: <155719950467.20841.12333253076877928869.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 03:25:04 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  6 May 2019 06:20:47 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7aefd944f038c7469571adb37769cb6f3924ecfa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
