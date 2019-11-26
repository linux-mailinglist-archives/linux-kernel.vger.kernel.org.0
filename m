Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD6A10984D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 05:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfKZEZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 23:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbfKZEZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 23:25:11 -0500
Subject: Re: [GIT PULL] workqueue changes for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574742311;
        bh=LVtZXbZSJvMri5iSU4hMH2DG+JBlwHdQKx/KA+4NaQY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CL7jtzRtpSXEHXUIXl5LhyxCfik8vGlr0+tkRmT5yN8Nx8mraOAGLwLdxp94tD6ij
         /VJVW6ARw79bl0xK6wCqFmMQzGZOL8DzsHPHCJntndDm2+M5C7VcuwTv21wO0uUYDF
         RsKCy3rM6xhfLKqp2s9/IsYglupcxR2UajA1waLI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125160314.GB2867037@devbig004.ftw2.facebook.com>
References: <20191125160314.GB2867037@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125160314.GB2867037@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
 for-5.5
X-PR-Tracked-Commit-Id: 49e9d1a9faf2f71fdfd80a30697ee9a15070626d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9391edee8667733e22baa50d182191ba3a00d5e1
Message-Id: <157474231147.2264.605490064254767692.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 04:25:11 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 08:03:14 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9391edee8667733e22baa50d182191ba3a00d5e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
