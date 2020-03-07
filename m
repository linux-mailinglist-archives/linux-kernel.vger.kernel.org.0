Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB317CEB7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 15:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCGOaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 09:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgCGOaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 09:30:08 -0500
Subject: Re: [GIT PULL] thread fixes v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583591407;
        bh=cmeKlZ3OTGK49GoO54DeuHwQuLYZOFn+Qv0qSMEH/5A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PMy/PPSzGbgC9ev2ud+Ce9PjqpSWhz2G3bv+hAx0L4PMUgCbwGc68miaPenreDBYJ
         yO8IxCZ0G3O9h9thmXwLf5z1TXj6eM8PMgFOLobx8cI3F/rNMWW1FzeBoSwuMXDtpq
         3lNy4a1CqZ8FlGx7gPBZL03lKFvGPeUqf6XGwbRo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200307102213.2999137-1-christian.brauner@ubuntu.com>
References: <20200307102213.2999137-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200307102213.2999137-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2020-03-07
X-PR-Tracked-Commit-Id: 186e28a18aeb0fec99cc586fda337e6b23190791
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa883d6afb158c3c9bf33262272da3b6f0489742
Message-Id: <158359140748.13770.6380375576018361943.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Mar 2020 14:30:07 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  7 Mar 2020 11:22:14 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-03-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa883d6afb158c3c9bf33262272da3b6f0489742

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
