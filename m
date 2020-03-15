Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6771F185FBF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 21:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgCOUZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 16:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbgCOUZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:25:07 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584303906;
        bh=eiuLjTM0H7dwvn819pmsnMr/lPvShNx1pDwdSrAXyRQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N1thktkZN0Da+XmJMgGqEbwh6qedl5hyY8gzb5T3LArQIyhhDrzfVz8frkUI9LnVr
         Rhz+OuK6CceQHZYPD1NIXSrtsxPr8s3jw3NJiSMx6ud2TFGW0JwchOisx7s/BPY9v/
         emu3Fa0mFlRe2bINEcXCOIeMHo7yBAVMc4F4r12Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200315091602.GA18173@8bytes.org>
References: <20200315091602.GA18173@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200315091602.GA18173@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.6-rc5
X-PR-Tracked-Commit-Id: 1da8347d8505c137fb07ff06bbcd3f2bf37409bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de28a65cd0e39d031dfcdc61fbe06268cb4a5f94
Message-Id: <158430390668.13594.6670059982592088397.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Mar 2020 20:25:06 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Mar 2020 10:16:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de28a65cd0e39d031dfcdc61fbe06268cb4a5f94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
