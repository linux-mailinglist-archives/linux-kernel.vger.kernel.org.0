Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6B17CEB9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 15:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgCGOa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 09:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgCGOaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 09:30:06 -0500
Subject: Re: [GIT PULL] xen: branch for v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583591406;
        bh=aqx9wdW6cgs6DwzR9YqYO7lOArZ+awEW6YBOBGrp3MI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bDZ2G/PIeycTqk3YVEa2+GD4/ceIG/5gSwYbDresg1n+8o1Uoyp8qUYRc5l/3KxG3
         xSbzjoys00uXWKTq8sOE3S9KDjaE74rfkKWOIVIJ8Ui4VXTEI7+dLtt00yBAH0BZ+k
         dWaN7N2aoUV69HXw1AYPvjlvbRdF1ujIPQbZfZm4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200307093617.11819-1-jgross@suse.com>
References: <20200307093617.11819-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200307093617.11819-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.6b-rc5-tag
X-PR-Tracked-Commit-Id: 4ab50af63d2eb5da5c1571f8518948514f535782
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbee7c8b4485fb876895b82ddba19ae4e2e2d102
Message-Id: <158359140623.13770.12361787339122894366.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Mar 2020 14:30:06 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  7 Mar 2020 10:36:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.6b-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbee7c8b4485fb876895b82ddba19ae4e2e2d102

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
