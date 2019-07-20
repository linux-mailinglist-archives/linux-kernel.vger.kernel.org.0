Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2253F6F079
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 21:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGTTfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 15:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfGTTfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 15:35:22 -0400
Subject: Re: [GIT PULL] dma-mapping fixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563651322;
        bh=IjC9XRyqEEK7udbTgGaO8BIgzv1bScLdS7/8eArfCM8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=StV/0N6ppk/JU6ZqwaFdV6fBW5mAbpoiCLIi5tqBwpt4r7Bl54fGO7GjCQwavlJIh
         bJQQ/kYrbSM/XW8pDW9gL+NQn6Q2utPiKJD92SHg3kWJ08oAIEJjkrGsLsJnnh1qEv
         cLZK7nMdbu3lOXoVdENG7+MGgbOS39ThlRouXESs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190720172911.GA11099@infradead.org>
References: <20190720172911.GA11099@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190720172911.GA11099@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.3-1
X-PR-Tracked-Commit-Id: 449fa54d6815be8c2c1f68fa9dbbae9384a7c03e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac60602a6d8f6830dee89f4b87ee005f62eb7171
Message-Id: <156365132205.3883.10711143327941655871.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 19:35:22 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 19:29:11 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac60602a6d8f6830dee89f4b87ee005f62eb7171

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
