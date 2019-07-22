Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1156170599
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 18:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbfGVQkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 12:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbfGVQk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:40:26 -0400
Subject: Re: [GIT pull] sched/urgent for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563813625;
        bh=2Bqo/P90W7uqk5o/6r5NsYBHOHk80Oe86drp0IBH9Aw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2VI3XgAVHABzRbYnMfG0BRah227wBJRnas7NkwlPvoG67Wnsv6lf98GpWP3RxYBLG
         V+Clp5e++ZXhU6OMoSbY4Wfe6RAxC4S8CnvFJM4KVoDN9T6Cko6PxAqW1WaZHyZ3oF
         IWPjewlSmiUz+2FpZHzaPdD3v27ULOXcAYNRbPF4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.1907221820570.1659@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907221820570.1659@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.1907221820570.1659@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: b8d3349803ba34afda429e87a837fd95a99b2349
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b5cf701ea9c395c792e2a7e3b7caf4c68b87721
Message-Id: <156381362542.340.2941693919755926524.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Jul 2019 16:40:25 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Jul 2019 18:23:38 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b5cf701ea9c395c792e2a7e3b7caf4c68b87721

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
