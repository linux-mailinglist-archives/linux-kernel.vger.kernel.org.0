Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7315678
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfEFXlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfEFXkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:08 -0400
Subject: Re: [GIT PULL] scheduler changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186008;
        bh=5BEw6yxjBk2I7/H3Olia8ICj4A4okpL9B4v/OIAVezA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vglbTrWBbZm46z3dJP3qBHYtYUzZx8Q25DFjYXK19tBw/turF7FPV6HxDrCeGu6A/
         uaP7tQx5Qy1w/rbLU+QRjfGDpDlRKcNjS33RfBHQ1yy/ClCjjxfnOARO9ZMYH8awQj
         E1ymER3SUuISiVz3F7OhrhhzCz5R8o9ZIXQTuY40=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506091153.GA38979@gmail.com>
References: <20190506091153.GA38979@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506091153.GA38979@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-core-for-linus
X-PR-Tracked-Commit-Id: 08ae95f4fd3b38b257f5dc7e6507e071c27ba0d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e00d4135751bfe786a9e26b5560b185ce3f9f963
Message-Id: <155718600807.9113.18168355191502721502.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 11:11:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e00d4135751bfe786a9e26b5560b185ce3f9f963

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
