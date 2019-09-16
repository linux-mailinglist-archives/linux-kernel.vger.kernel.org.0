Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824D9B4332
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 23:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfIPVfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 17:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389133AbfIPVfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:35:14 -0400
Subject: Re: [git pull] IOMMU Updates for Linux v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568669713;
        bh=q52ZFHXm/LA/R2JrWmX2L/Z8vL1yV17IsFuxspLn8pA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Zaml9FTE90NT3S05cNZvj/c9qNgoRC4cIoplq2xUQOvw+kg8+kp5shlMd7uOFecGf
         wqAGdybZ0b4QEfpout8vK/BsAV//mYOgEqemCDLR7xDsu+3/UgJz37G7cnvJ6yt0OV
         ya73M7Yhsj+rrOPfln/DsteCwcrLz67JwZkyNBFA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916151342.GA7444@8bytes.org>
References: <20190916151342.GA7444@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916151342.GA7444@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.4
X-PR-Tracked-Commit-Id: e95adb9add75affb98570a518c902f50e5fcce1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52a5525214d0d612160154d902956eca0558b7c0
Message-Id: <156866971382.13102.1513006408940685487.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 21:35:13 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 17:13:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52a5525214d0d612160154d902956eca0558b7c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
