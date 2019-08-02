Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E077FE46
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 18:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389935AbfHBQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 12:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389867AbfHBQKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:10:10 -0400
Subject: Re: [GIT PULL] Fix gfs2 cluster coherency bug
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564762209;
        bh=UvT0o3ZBxyf3aVJPZyAhNoNbsQfK7wrSubXZIRnYedo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=T96o7tXXs5u9mwDddoFrAY8HYPPz9BJ+A2pzSEC5oH4DioweNDTMF2LfM1sOnAHyt
         QmEF9Nf0hRU1dkfNHLt48pWG98Xs2zzgogxPfYb7GNQMp/beNN/ZLlajHk65dx69rE
         jqdPHzO0XIkHOnJ+IiYlc06qkOrQEzkI1TrSD90E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190801195259.27274-1-agruenba@redhat.com>
References: <20190801195259.27274-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190801195259.27274-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-v5.3-rc2.fixes
X-PR-Tracked-Commit-Id: 706cb5492c8c459199fa0ab3b5fd2ba54ee53b0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97b00aff2c45069bb8ea88acac664a17d63f77f9
Message-Id: <156476220923.32155.6136557482022472343.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 16:10:09 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  1 Aug 2019 21:52:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.3-rc2.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97b00aff2c45069bb8ea88acac664a17d63f77f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
