Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43AB18DF3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfEIQZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 12:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbfEIQZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:25:14 -0400
Subject: Re: [GIT PULL] DMA mapping updates for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557419113;
        bh=AsLoE8maqrC84xuyzNDEGIn3ooBziPzN27H1NlD7Of0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ndCLGOlVB5hhd0GvzQKyR1fu88VowsDofoFtyzsuGQV6PqX+8eRhm2bu+xcPjDkcY
         iNAdzL7GJUeFegV5moO6CgG45DNsKT+ab78Q7PmqoHztAwh9YneX1lzLYlIIJwb5Oo
         EVxGydB/iC40imXqSWfS5+Z+TsHb4RbgC0UXRiVg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190509071634.GA604@infradead.org>
References: <20190509071634.GA604@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190509071634.GA604@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.2
X-PR-Tracked-Commit-Id: 13bf5ced93775ffccb53527a9d862e023a9daa03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddab5337b23c99777d7cfb39c0f8efe536c17dff
Message-Id: <155741911358.30533.13545205602641074733.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 16:25:13 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 May 2019 09:16:34 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddab5337b23c99777d7cfb39c0f8efe536c17dff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
