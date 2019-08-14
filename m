Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6356F8DCEF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfHNSZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 14:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbfHNSZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:25:06 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565807105;
        bh=dh++PCbnnz2m0wF6qNZbDAaaiCDxpQQji3hW50jtzqU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uOGC8n80LCcvFc/FD3OeARgW0V4XqD1MClJxJuDBw8L3R+ZgCuK63kNWBCQmnGW4j
         GUjzRw4adepFtWLceA1I4FYrWu9djEJ2UlLC+Q3gCQARTVGujya4pUE1qZo2G8Q8YI
         rtFCHmoDUhkAYU2+UIbXjjbPkLuHJ2DLyXBAHIIE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190814140902.GA28527@8bytes.org>
References: <20190814140902.GA28527@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190814140902.GA28527@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.3-rc4
X-PR-Tracked-Commit-Id: 3a18844dcf89e636b2d0cbf577e3963b0bcb6d23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5e33e44d994bb03c75f1901d47b1cf971f752a0
Message-Id: <156580710586.11871.2527303930126410920.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Aug 2019 18:25:05 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Aug 2019 16:09:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5e33e44d994bb03c75f1901d47b1cf971f752a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
