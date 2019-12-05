Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD2F1148AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 22:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfLEVaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 16:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfLEVa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:30:28 -0500
Subject: Re: [GIT PULL] GFS2 changes for the 5.5 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575581427;
        bh=vWDD8QLAEMy4QmRuuYEUXWx412poeFLuomWD9V3/2Es=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UUMcc4MWndaSvKi9vU0xSjME2tTIX5Y2r9XqH24Rjc9yEGzVln2B/7I75PUUzcBcC
         yS7E7Xi34yT16YlnbOlRQc64/DxHg19nSgcIXqMUYmmHM7E6vs+tH5sKYPv4PY6FXV
         ItHXCR7dHBMd/3FK71jjOcyH6OBqx8vDrlNDAyjc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191205190915.5468-1-agruenba@redhat.com>
References: <20191205190915.5468-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191205190915.5468-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-for-5.5
X-PR-Tracked-Commit-Id: ade48088937f53fe0467162177726176813b9564
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f1266ec704d3efcfc8179c71bed9a75963b6344
Message-Id: <157558142773.8243.15014524712940034870.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 21:30:27 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  5 Dec 2019 20:09:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f1266ec704d3efcfc8179c71bed9a75963b6344

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
