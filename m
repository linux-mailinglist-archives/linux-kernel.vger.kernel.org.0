Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A03C7153776
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 19:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBESUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 13:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbgBESUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:20:15 -0500
Subject: Re: [git pull] IOMMU Updates for Linux v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580926814;
        bh=5MdfsOEP1cuD67baLfn1RYNv9TYnFHGGZioa9T++I1s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VFyJQaimHAuTL40lIjjoWNNwukvIpXw9dAvUWhW5f7ZomT8LpfKFIsSFmJSEkAFxf
         Rr6536VEThFVZrrRVPwbzZFcQRJRUI3vqQZtn8ljLO4p/rAGy0gfYc/j5j64zeNbTN
         2r6TTL85yaYYIcQQq/HDmXAr1nlLy1XvhAfDEifM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200205140344.GA32375@8bytes.org>
References: <20200205140344.GA32375@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200205140344.GA32375@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.6
X-PR-Tracked-Commit-Id: e3b5ee0cfb65646f4a915643fe53e0a51829d891
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fc2ea6a8608d9a649eff5e3c2ee477eb70f0fb6
Message-Id: <158092681483.14135.11118001152469103340.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Feb 2020 18:20:14 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Feb 2020 15:03:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fc2ea6a8608d9a649eff5e3c2ee477eb70f0fb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
