Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526106EB41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 21:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfGSTpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 15:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387515AbfGSTpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:45:22 -0400
Subject: Re: [GIT PULL] xen: fixes and features for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563565522;
        bh=CGRxQv/GFiGKqoQDynBkDgPXgDmPnH0of257ZhcDg6M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Zaa7VI4e+tqf6Vs7ccZlFNARjjLID9DNrF+5pz2WWaa1cF2qeX8UMyJokmdkT5DN3
         PPwu5q8/Qs+NdbzdNUsxlXE5iTvcph97AuKoMSWSkGX70FFmYdIsb2rF2DJvWnnzuW
         ol1pigZ95X62fQx0xMYqwue4WZFZTBVvwJGTH6mA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190719060925.10614-1-jgross@suse.com>
References: <20190719060925.10614-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190719060925.10614-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.3a-rc1-tag
X-PR-Tracked-Commit-Id: a1078e821b605813b63bf6bca414a85f804d5c66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5d72dda8976e878be47415b94bca8465d1fa22d
Message-Id: <156356552226.25668.12773277434931748832.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jul 2019 19:45:22 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jul 2019 08:09:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.3a-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5d72dda8976e878be47415b94bca8465d1fa22d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
