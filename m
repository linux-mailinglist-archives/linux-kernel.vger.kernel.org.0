Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2145DF9F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 10:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfGCIUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 04:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbfGCIUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:20:05 -0400
Subject: Re: [GIT PULL] fixes for v5.2-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562142004;
        bh=oU1gyWyf6wEmHSyLRQm1FEaFSMgw4kTusaSmQ+TkWHg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ejyn3mmu8eaWE2jq8Lv9XA3WdHjSaAL9NtP/c0nxrMPdnUzGvUPTqc6FZW7v5iGM9
         V3K25NjguJEAV0z17AI7W4tbk1l1zo7lhQvudrOu9P76Hsj4chiHpc7yjpOi634J1+
         1Hvs8TryYqf82XXi5LRXNQRxwwcEwyKDOh6iqkX0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190701161503.15254-1-christian@brauner.io>
References: <20190701161503.15254-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190701161503.15254-1-christian@brauner.io>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-20190701
X-PR-Tracked-Commit-Id: 28dd29c06d0dede4b32b2c559cff21955a830928
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d68d93255227da660c63b9162f7001e2f5d470a
Message-Id: <156214200411.4530.13662931833409724240.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jul 2019 08:20:04 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jannh@google.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Jul 2019 18:15:03 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190701

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d68d93255227da660c63b9162f7001e2f5d470a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
