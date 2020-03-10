Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF0180BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 23:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCJWfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 18:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgCJWfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:35:07 -0400
Subject: Re: [GIT PULL] workqueue fixes for v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583879706;
        bh=yPr5hNdtam/71wxNa8598xMGeDmm75rk9D+ZqydsLAY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1bA8phds1th/w8q4F7VsOOOd8EWSmLtIBrNmA1c8y6hVWk/qCybJC3btUQXTTLx5C
         H5il9jwerWrF3B8VsgQgLjLR5Ued04uA0w3b7yiNs2zLW+f8uoWqczZQuRHAt5c/dm
         agHG2v3Gl1063nfSCXOUqSqmPc4+H6IP3u8A7Ifk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200310143346.GB79873@mtj.duckdns.org>
References: <20200310143346.GB79873@mtj.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200310143346.GB79873@mtj.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
 for-5.6-fixes
X-PR-Tracked-Commit-Id: aa202f1f56960c60e7befaa0f49c72b8fa11b0a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c1aca4bd3fefc57018773cc8771f71c9bfbdc1f
Message-Id: <158387970687.8298.9382768254695507991.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Mar 2020 22:35:06 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Mar 2020 10:33:46 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c1aca4bd3fefc57018773cc8771f71c9bfbdc1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
