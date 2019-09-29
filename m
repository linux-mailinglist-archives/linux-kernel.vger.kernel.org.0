Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49442C18A3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 19:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfI2RuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 13:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbfI2RuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:50:22 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569779421;
        bh=eMIVtaaYxmqE+13EFEMvT3gTKsf9DNaaYaJnjwKMjuY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OxQG+ql3muIrR4IO4Uerz99E72GRLgbUuNGbjlc3w3Fw6jAdt+Kb/ilLa/SU3nek5
         tlTD5UgVjLOJzo8YLWfQfNpvgV/1LU7OPgm2I9iuLqwTASSsXZppeQmA2Io1Y9DnfG
         upcbgFwy1Uh6n5jJdlp/tDxjOS3m0oKyROnDM1XI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190928191007.GA7565@8bytes.org>
References: <20190928191007.GA7565@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190928191007.GA7565@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-5.4-rc1
X-PR-Tracked-Commit-Id: 2a78f9962565e53b78363eaf516eb052009e8020
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d2af08ed08ce87c4fd2379fa857153631ee8537
Message-Id: <156977942161.28081.7134210299973252649.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Sep 2019 17:50:21 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Sep 2019 21:10:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d2af08ed08ce87c4fd2379fa857153631ee8537

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
