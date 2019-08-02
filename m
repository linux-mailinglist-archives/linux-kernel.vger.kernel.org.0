Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB27FE12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 18:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbfHBQFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 12:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbfHBQFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:05:10 -0400
Subject: Re: [GIT PULL] dma-mapping regression fixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564761910;
        bh=N5RwYZDXcNZRV1M/9f8qEW8lY38ujjf1NBQSXuCxR3Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GQ33+MyQ7jMXOSYasgN7GZLv0h2xeXfN8MW7AGpqLCC1O3GQw6Q/nt+VSMjhNg8Sf
         0ZrjHa9q7Gm8L3yRnUvUHOdcYqoQUv9HUoDvxJdE8A8V/Cx7Zl9rFGW0Nbkpgzpud0
         h18124AtoHrGEdqioL098pmgUJx0ZfU81dJeeEhM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190801164520.GA26214@infradead.org>
References: <20190801164520.GA26214@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190801164520.GA26214@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.3-3
X-PR-Tracked-Commit-Id: f46cc0152501e46d1b3aa5e7eade61145070eab0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35fca9f8a999627e3291907992b299b1207baee5
Message-Id: <156476190993.27663.2522263500735152124.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 16:05:09 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Aug 2019 19:45:20 +0300:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35fca9f8a999627e3291907992b299b1207baee5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
