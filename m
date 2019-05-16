Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0891620E87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 20:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfEPSUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 14:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729071AbfEPSU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:20:26 -0400
Subject: Re: [GIT PULL] timer fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558030825;
        bh=vYtnUdA4Nwn1c0DGs4bZY7IcpxZTHlcqIVGaoS50vCA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ujmKse2cnBdTFbYV3DcZZIXnOeGCts1Fe52kYeWwd90rJtAQmrgjJKAHjpfyGJ0kB
         cqnZSYpK1OxqHekLZWGs6EISC1V0muNPPQ0qxP7g1GFGG/FHkTLU8k8ON/JZrGtVYu
         2U3fl/Zh/VxGSQLpI96cmm97A28sN/cmY54KFRdw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516160925.GA97788@gmail.com>
References: <20190516160925.GA97788@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516160925.GA97788@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: fdc6bae940ee9eb869e493990540098b8c0fd6ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2c3dda6f8f06d825b9b6099f57b906c774141c0
Message-Id: <155803082547.23531.5561399905580965865.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 18:20:25 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 18:09:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2c3dda6f8f06d825b9b6099f57b906c774141c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
