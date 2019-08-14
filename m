Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E7C8DCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 20:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfHNSZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 14:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbfHNSZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:25:06 -0400
Subject: Re: [GIT PULL] dma mapping fixes for 5.3-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565807106;
        bh=aMza95Rk5bvMKEYj7zMse/e16vrNacpcAj+1mggKrUs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qndm0DThOiJb5Z5dPls8PDEcC485XcjsoCz/fy582BgLzyRwe1tERHLO8SGSTw31I
         dL6Kxb4/Qm0hxHb9sB+QGWFKaaCHpVdJ2URvYX4UZvBgVnzdIxwf9bn8Jwx3MzR66U
         daBm29wp9GiIw/LXVrjEY4SZlvcyn56+zDIeECtU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190814141217.GA3792@infradead.org>
References: <20190814141217.GA3792@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190814141217.GA3792@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.3-4
X-PR-Tracked-Commit-Id: 33dcb37cef741294b481f4d889a465b8091f11bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e83b009c5c366b678c7986fa6c1d38fed06c954c
Message-Id: <156580710610.11871.6276353935293222057.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Aug 2019 18:25:06 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Aug 2019 16:12:17 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e83b009c5c366b678c7986fa6c1d38fed06c954c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
