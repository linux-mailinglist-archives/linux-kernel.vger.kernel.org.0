Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A30C15776
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 03:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfEGBzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 21:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfEGBzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 21:55:05 -0400
Subject: Re: [GIT PULL] mmiowb() removal for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557194105;
        bh=ak++OY8/sVhxOWDDo22YQ++yB4kXNOSUdu84bJGkv9M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cEYmX7HQY8AQwU8waoJylDI4Ho1RCng9d7Lzn0BlvB1aTsKBBaOA5T8dzRPMaAYbM
         4t/kzERDA6pEUq+R708wgU7B582F4NWdGXNbMPAYRqtryLkFKyZFwZBAcjMC+3ZQcz
         LRaEzMCWLD0JvyDZRr8LKU/Ii+thXkak+cmCu3a4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506181110.GB2875@brain-police>
References: <20190506181110.GB2875@brain-police>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506181110.GB2875@brain-police>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-mmiowb
X-PR-Tracked-Commit-Id: 9726840d9cf0d42377e1591263d7c1d9ae0988ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd4e5d6106b2380e2c1238406d26df8b2fe1c42c
Message-Id: <155719410527.3542.630416167347402929.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 01:55:05 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        paulmck@linux.ibm.com, benh@kernel.crashing.org,
        macro@linux-mips.org, mingo@kernel.org, npiggin@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 19:11:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-mmiowb

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd4e5d6106b2380e2c1238406d26df8b2fe1c42c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
