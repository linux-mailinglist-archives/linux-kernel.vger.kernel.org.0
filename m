Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC06676BC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 01:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfGLXUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 19:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfGLXUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:20:16 -0400
Subject: Re: [GIT PULL] dma-mapping updates for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562973615;
        bh=qnCXxKnuLDiqmaF/EYePGbD5QlATJx8EvQv2n5KVACk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nIQARSDLgPTeaMXDyHW/AIQllozVGEiytmq1GKKGDTFecIzmS5iede/+htPO1gVR/
         PXghnrldPpC8nbkCUxQj/96REatDoMCplJBz7J5wudLReAMGiQbacnbY/eB+ILbj6N
         L0zqD9zxrAqyPqfWpzewCTaxSnIhGN1QobcDT8kg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190711135654.GA15312@infradead.org>
References: <20190711135654.GA15312@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190711135654.GA15312@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.3
X-PR-Tracked-Commit-Id: 15ffe5e1acf5fe1512e98b20702e46ce9f25e2f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e3a25dc992dd9f3170fb643bdd95da5ca9c5576
Message-Id: <156297360989.22922.1378645851693477593.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jul 2019 23:20:09 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 15:56:54 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e3a25dc992dd9f3170fb643bdd95da5ca9c5576

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
