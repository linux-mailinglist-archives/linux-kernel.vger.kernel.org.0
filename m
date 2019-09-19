Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B397B8363
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 23:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404838AbfISVab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 17:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404824AbfISVaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:30:30 -0400
Subject: Re: [GIT PULL] dma-mapping updates for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568928629;
        bh=PxIMPCzSmLksihdPHjm4QGV5FFdSb/+jzcpKL6SE0QU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N/k9/zG0H5690gQsIVAD/7SuzY3PEW6cTpTLrwp3rkS316pDfWlnEBUlBH19Yagaz
         qVYe9lAsrjiiMow0EZO6pPIXPPEf0nD7V3qA7HLSgdvmGPxiTG0pwfEcUaTMtYJ8fW
         wNUFKGT3tipMpm+5G7gsgo+8sYF/B5zmohe/mduw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190918152748.GA21241@infradead.org>
References: <20190918152748.GA21241@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190918152748.GA21241@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.4
X-PR-Tracked-Commit-Id: c7d9eccb3c1e802c5cbb2a764eb0eb9807d9f12e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 671df189537883f36cf9c7d4f9495bfac0f86627
Message-Id: <156892862992.30913.10484528229946005623.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 21:30:29 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mmc@vger.kernel.org, iommu@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Sep 2019 08:27:48 -0700:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/671df189537883f36cf9c7d4f9495bfac0f86627

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
