Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E50163953
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 02:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBSBaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 20:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgBSBaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:30:18 -0500
Subject: Re: [GIT PULL] dma-mapping updates for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582075818;
        bh=Ww/x3HNh3xF31l8ohB71CpLYcQFAw2fGO4Xmh4/DCB0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OCTtoVwEoaAC9BNIsy9rSz2EGSX9x+IZVogdNW7tFUG5UYqEXXBxfsgvG20RrWjxN
         YNuCO12hlGvrKf9j79LqADK/sW0mavHOkGt85KT8KxtDzh2INTWj0+joD5RA77bPew
         3qNtPTR8O6lNX1mDn9YFKP4AmcyCP+7D8FCQVaBE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200218211500.GA41556@infradead.org>
References: <20200218211500.GA41556@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200218211500.GA41556@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.6
X-PR-Tracked-Commit-Id: 75467ee48a5e04cf3ae3cb39aea6adee73aeff91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a44cac8105059eb756ed4276e932e54e1ba004d
Message-Id: <158207581803.3201.1858144410203694454.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Feb 2020 01:30:18 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Feb 2020 13:15:00 -0800:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a44cac8105059eb756ed4276e932e54e1ba004d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
