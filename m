Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBBD3663B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 23:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfFEVFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 17:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfFEVFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:05:11 -0400
Subject: Re: [GIT PULL] pidfd fixes for v5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559768711;
        bh=44VDRxA/D3CrY0vgvknhCg1a02P7ybmCoTRJfyAa7ME=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mGoxbpQv90c+jhzDr/7ehtiJ0M/BgzPRYHqvh2JKcd9wfwPHkmxowFVNNz1wUyO9O
         OFpTwjb133gAZTLybv98DcVzBSRPoQjZ/ueH069CSM0km/b2BNNygd5MjJDeSqaRGl
         HYYq5gCEbvQXS0vf1NU5lGPvP0gmbMrU4vOrPIvw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190605132937.29438-1-christian@brauner.io>
References: <20190605132937.29438-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190605132937.29438-1-christian@brauner.io>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/pidfd-fixes-v5.2-rc4
X-PR-Tracked-Commit-Id: 1fcd0eb356ad56c4e405f06e31dd9fde2109d5ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db309f2aedb88a938e37a6eac02be7a7e0e850b1
Message-Id: <155976871111.18999.281700280051587555.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jun 2019 21:05:11 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        arnd@arndb.de, Christian Brauner <christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  5 Jun 2019 15:29:37 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd-fixes-v5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db309f2aedb88a938e37a6eac02be7a7e0e850b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
