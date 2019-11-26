Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFCC1097C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 03:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfKZCPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 21:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfKZCPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:15:08 -0500
Subject: Re: [GIT PULL] xen: fixes for xen
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574734508;
        bh=hwVbSffnhRKL0Pmn2pbkb2Wk7GBDOC6kltJG7nfW+is=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bUe8+Ro4qvLQyooTbf9KnIM6Vhxy4axSY92SBHk5VRDQuSRQnjB8StjU7XjzOoxBw
         paBGm5iaWcNde3WqeVI3DMsiCTs7L5plNV1bamRqhJx6nooVQAxgg2+wRgZDCsq+k9
         XcH/9enGWfl7iGY2WBWeeAZcG0njCA9eGUuybz8U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125053454.19556-1-jgross@suse.com>
References: <20191125053454.19556-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125053454.19556-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.5a-rc1-tag
X-PR-Tracked-Commit-Id: 23c1cce9f3174db9cdc91346cb4320fa6b97e35d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f3c8be973af10875cfa1e7b85a535b6ba76b44f
Message-Id: <157473450810.11733.16137638938272108320.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 02:15:08 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 06:34:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.5a-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f3c8be973af10875cfa1e7b85a535b6ba76b44f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
