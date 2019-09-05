Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEBAAADAC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 23:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391783AbfIEVPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 17:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733193AbfIEVPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:15:06 -0400
Subject: Re: [GIT PULL] scheduler fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567718106;
        bh=slRwwSap1IXIqVepWjCCxU2B9iW0vFlSGAD5LLy8lS8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v59sTBXwsQ44AyKC/gtS0qp6Ody9eQPJrN2XDq00zBPH7OwzH+mVQG7H6RAl/3p0G
         ZpXhXcKa/KFggtq/WL5DWdC2tjpnUYkb0YYatw+41ga7B6Av69I9zE+38Rd4ee5GSX
         JhI/zhxcoMRJKl2uzWtmhlRIfm9XwsTRQzOILP9c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190905080252.GA46303@gmail.com>
References: <20190905080252.GA46303@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190905080252.GA46303@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 1251201c0d34fadf69d56efa675c2b7dd0a90eca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 262f7eeddc85c657e3087561dc8c3cfe227363ff
Message-Id: <156771810626.8025.4509374013602690380.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Sep 2019 21:15:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Sep 2019 10:02:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/262f7eeddc85c657e3087561dc8c3cfe227363ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
