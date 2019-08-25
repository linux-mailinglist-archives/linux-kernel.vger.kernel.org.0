Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43EC69C165
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 05:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfHYDPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 23:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbfHYDPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 23:15:07 -0400
Subject: Re: [GIT PULL] dma-mapping fixes for 5.3-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566702906;
        bh=mPe3odrknBIFfF0lqHZtL9q2YQNnQ+0AuopSqTNkTbM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oR/rkFO644feU+z4crnl3ubSvYZmCexFNEafhkRdDyk6GrkjtnoJhZ0Kx9/LQZnwU
         qjqw35eo9RcpQjl/iguP523Omqf9wsVDxVqhGF0fzx/UQAFmcgxeLAIEyUwKrJo0MX
         Uq+SILhGG94Ywy8C93W2Z006GEAAo2TM+RL8XcXY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190824225010.GA18590@infradead.org>
References: <20190824225010.GA18590@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190824225010.GA18590@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.3-5
X-PR-Tracked-Commit-Id: 90ae409f9eb3bcaf38688f9ec22375816053a08e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e67095fd2f727c35e510d831c588696f2138a1bb
Message-Id: <156670290674.4585.269087204039323980.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Aug 2019 03:15:06 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Aug 2019 07:50:10 +0900:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e67095fd2f727c35e510d831c588696f2138a1bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
