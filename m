Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D54164C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 18:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBSRkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 12:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgBSRkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:40:19 -0500
Subject: Re: [git pull] IOMMU Fixes for Linux v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582134019;
        bh=3dAa4+ULDiNGO2E276gfipBte3n/58rOaOOAZsySmxU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X2hfFfnLgBjWdxpnGkg4hpD7TKL2AYTLcVvx2r8orJBSBXtuwdaYfgOxDCrhzenAC
         XEQf1LsrKDG8bI4XGxqEx67pUVJr3N2ksST/9+3zbuQ4Ri+z0adnJ/+pRHuM4Jda+Q
         X6gzdwjad/fQptBTIg/lIIjBJjSFFkMGZIpaKra4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200219165116.GA7503@8bytes.org>
References: <20200219165116.GA7503@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200219165116.GA7503@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.6-rc2
X-PR-Tracked-Commit-Id: ab362fffa0feb0da23191111e60b641d39130053
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b205766d8fcb1627429ff31a4b36248b71a0df1
Message-Id: <158213401949.16030.13039594423525523270.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Feb 2020 17:40:19 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Feb 2020 17:51:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b205766d8fcb1627429ff31a4b36248b71a0df1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
