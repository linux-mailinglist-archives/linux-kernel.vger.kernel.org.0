Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7EA910F1E3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 22:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfLBVFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 16:05:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfLBVFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:05:21 -0500
Subject: Re: [git pull] IOMMU Updates for Linux v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575320720;
        bh=xMwdGCFXqgM6gGkXnnWfZyZRAeOwG5qQZN43h0679/4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nLPdupFyuB4Ogeh/DKILu3yfl4TwqrwQNDa8oVfBJEHXFufcFHTQobLyuBNHBDMQz
         icqgnmz0YnrvcZzj1lvcnhFftEisvWWpi0DHTb2zkAa128fa3yvBvnQJnK2DwkGv9l
         DELDvSPvknys+r03ACjTOJzyU+qj3AHMBW2OeNQc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191129120247.GA6874@8bytes.org>
References: <20191129120247.GA6874@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191129120247.GA6874@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.5
X-PR-Tracked-Commit-Id: 9b3a713feef8db41d4bcccb3b97e86ee906690c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1daa56bcfd8b329447e0c1b1e91c3925d08489b7
Message-Id: <157532072053.29263.1440104284503498805.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 21:05:20 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Nov 2019 13:02:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1daa56bcfd8b329447e0c1b1e91c3925d08489b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
