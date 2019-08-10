Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D2788ECD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 01:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHJXUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 19:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfHJXUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 19:20:08 -0400
Subject: Re: [GIT PULL] Fix incorrect lseek / fiemap results
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565479207;
        bh=bBR1g0y97Fcq0B77leHLFxKxMKRjoN1IOx/hOcp/rIk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LzDBx9RL/p3T9BGtPaFzbfFTyqi2Tn6je9bqFYuE9ByirXNcAvmMgeFbDOD3vS3l/
         yPSS+fEZCVvyCKyWEewNfer0yEzd8LowInSYjJ6Ir6v8GH3/tSS7Bcl25mRkD538Y/
         WD3h1XdYD0Y4Z8N1eBAUItlDCBekvUxomsqwLTWM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190810172537.27433-1-agruenba@redhat.com>
References: <20190810172537.27433-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190810172537.27433-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-v5.3-rc3.fixes
X-PR-Tracked-Commit-Id: a27a0c9b6a208722016c8ec5ad31ec96082b91ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 829890d266e37d368a404b5ecc8575aceae23a3f
Message-Id: <156547920731.21687.4895087365414318289.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 23:20:07 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 19:25:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.3-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/829890d266e37d368a404b5ecc8575aceae23a3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
