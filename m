Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 609C4138793
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 18:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733157AbgALRkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 12:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732957AbgALRkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:40:04 -0500
Subject: Re: [git pull] IOMMU Fixes for Linux v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578850803;
        bh=F2rMj+tDgCY54uolmRKP8Lu3t4cWtvsfHk3J8aI4QqI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lLEEPy6Ds5dpxuAqq/QJJ+LYZBSXpWSGRkuJV6SC3oeQYNumlOFwz3mBoVs11KJuT
         CEBVmVS9uvG7v9K7c1BPGy1mTBedL33wIKOEJpYo748FlNU51lYRJMZ9tJ+1DcMxwn
         05mzKsvG1V27jh7fh+fwzVn68zy9a6p9yQT3aXwg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200112095936.GA17108@8bytes.org>
References: <20200112095936.GA17108@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200112095936.GA17108@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 iommu-fixes-v5.5-rc5
X-PR-Tracked-Commit-Id: 55817b340a31951d23d1692db45522560b1d20f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 040a3c33623ba4bd11588ab0820281b854a3ffaf
Message-Id: <157885080357.18926.14855458420719655456.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Jan 2020 17:40:03 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Jan 2020 10:59:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-fixes-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/040a3c33623ba4bd11588ab0820281b854a3ffaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
