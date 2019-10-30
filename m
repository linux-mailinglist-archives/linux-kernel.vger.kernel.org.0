Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7232DE9C38
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 14:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfJ3NZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 09:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfJ3NZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:25:06 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572441905;
        bh=DmmVLnO2Nuchx2VqNQqfcDQaXZjO+KlZLc+j/LGWQWM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=U3qiA9LOdmlhEL7fiTwaa9JI3b9W86IMZcgvOdjUPWk+8ov2+TbcurOUJFDBmj821
         C/WBIK7gqxh22pTats0caYT0PijkX6KdBiLa5aAyCTPLviO1SwQtY//ltxXS3mbJSg
         UUwkV2F/1zKz/N3KUK1FkIBVcb4U+Je/asLHcD/w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191030130251.GA11315@8bytes.org>
References: <20191030130251.GA11315@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191030130251.GA11315@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.4-rc5
X-PR-Tracked-Commit-Id: 160c63f909ffbc797c0bbe23310ac1eaf2349d2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 320000e72ec0613e164ce9608d865396fb2da278
Message-Id: <157244190549.19806.13453430741450004166.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Oct 2019 13:25:05 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Oct 2019 14:02:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/320000e72ec0613e164ce9608d865396fb2da278

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
