Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2AB8F095
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 18:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfHOQ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 12:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731068AbfHOQZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:25:06 -0400
Subject: Re: [GIT PULL] auxdisplay for v5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565886305;
        bh=LUWi7OdKQ3fF7CIItzxfkuU1K9FXN70u6XiyxfBpZQc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1pfMUCphz1Cy2ipKS/eOU4SyzxvaUAT1GdJbu/t/+g7okw/6a6gKAo9ccFB2SZ+39
         tNdi7ixzOhDVJNE2bslhxsV1I3/Pz7PrJjUiFgzIX+A0k2PnHIvYKlWYG1iDLTTiXG
         OWXyMOGF5hsl4mb4rYrqLnecugJRNYcu01wDATMk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190815153403.GA27385@gmail.com>
References: <20190815153403.GA27385@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190815153403.GA27385@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/auxdisplay-for-linus-v5.3-rc5
X-PR-Tracked-Commit-Id: 6c4d6bc5486466e3a67cc47270001d0b4a26eed4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 329120423947e8b36fd2f8b5cf69944405d0aece
Message-Id: <156588630558.19165.11562944340118944443.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Aug 2019 16:25:05 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Mans Rullgard <mans@mansr.com>,
        zhengbin <zhengbin13@huawei.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Aug 2019 17:34:03 +0200:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/329120423947e8b36fd2f8b5cf69944405d0aece

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
