Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A252E62FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 06:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfGIEpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 00:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfGIEpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:45:06 -0400
Subject: Re: [GIT PULL] workqueue changes for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562647505;
        bh=QMvCto/YthF7p6NRqu2Tz2h55NklLOFBvAx0Jp1YPzE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gGqpjEisT1xvbMXPIKdfVV9juXBrQgDBUNi9AC87t2cjRDP9iFyDe7RYU/KNqnAvO
         FpD23p9m2Kbb6cIn4G1Ut6BVxtmRDlQSmt1alLZs8Cjtwoz29qM/SyMkkfPTB791j4
         9FjdZ3udoP6B7M4wISRyHKzH0EsSm8vThEYzotEQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708165620.GF657710@devbig004.ftw2.facebook.com>
References: <20190708165620.GF657710@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708165620.GF657710@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
 for-5.3
X-PR-Tracked-Commit-Id: be69d00d9769575e35d83367f465a58dbf82748c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df2a40f549e6b73aad98b0c03f400c00d284816b
Message-Id: <156264750585.18377.10878470549452084855.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 04:45:05 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 09:56:20 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df2a40f549e6b73aad98b0c03f400c00d284816b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
