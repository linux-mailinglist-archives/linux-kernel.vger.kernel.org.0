Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF8B18D57C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 18:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCTRPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 13:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbgCTRPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:15:11 -0400
Subject: Re: [GIT PULL] arm64 fixes for -rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584724510;
        bh=lODxS3uudQQhdXOmNALVz/qlf6Z0aEsuFX6lLXlYJNs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W8hxsSUMgI6mb2uPUZ/F57N0WKV1I7HcLIOzOl8iJtagbfEiXvrMTy+HDaGIzgZBe
         y8m89VrWtdXxQ/e63tC8zEAWW67m2Gh7ywVHM1BssyNrbnjoMRpci+3MWsMXEXKZDy
         eabG3PL5Kmf2DRwGP/Rl1lQATK3EHj3keAvGgaP0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200320153508.GA6815@willie-the-truck>
References: <20200320153508.GA6815@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200320153508.GA6815@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 3568b88944fef28db3ee989b957da49ffc627ede
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ad0ec0b86525d0c5d3d250d3cfad7f183b00cfa
Message-Id: <158472451088.23492.17342377231579410811.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Mar 2020 17:15:10 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, catalin.marinas@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Mar 2020 15:35:09 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ad0ec0b86525d0c5d3d250d3cfad7f183b00cfa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
