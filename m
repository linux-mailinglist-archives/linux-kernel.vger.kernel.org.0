Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECFDD7FE13
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 18:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389038AbfHBQFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 12:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbfHBQFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:05:11 -0400
Subject: Re: [GIT PULL] arm highmem block I/O regression fix for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564761911;
        bh=igOIKq+ei4WvgHi1Gds5jsfkB5shN0k2mShOFzB380g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jRVohKBXeeWNbS0W3As0dvqjmdj0qIYL5CFkx8sJEGkCu1COe4jQWrJhZz3s60XXC
         e03tJGP79djfnsLoXSieyAftA7sEJE6URVamcP4bTmYJ5NakXLH20fGQTl0ZsXFjso
         I9tlAWUzZJ9Mi8SYIMHRbAP8G1gxAXwJeQcn22yA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190801164702.GA26365@infradead.org>
References: <20190801164702.GA26365@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190801164702.GA26365@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/arm-swiotlb-5.3
X-PR-Tracked-Commit-Id: ad3c7b18c5b362be5dbd0f2c0bcf1fd5fd659315
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 234172f6bbf8e26fa8407c4bbbf2a36da30d7913
Message-Id: <156476191100.27663.8840208654309225219.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 16:05:11 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Aug 2019 19:47:02 +0300:

> git://git.infradead.org/users/hch/dma-mapping.git tags/arm-swiotlb-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/234172f6bbf8e26fa8407c4bbbf2a36da30d7913

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
