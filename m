Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05529E59A7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfJZKpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 06:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfJZKpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 06:45:07 -0400
Subject: Re: [GIT PULL] xen: patch for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572086707;
        bh=vuX0mLtS2i1js8YqglJXqcFvIBJ66VDQc0smN03qMZI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QxreTIiqgZvNZ0chewOHBcnm3hZt3+X+Vj0lBxuWtq57rT3iHlPYMUIpQwZHT50Ie
         2E/011JN6C63RuzuE/tbjw94aNO5GL5+bGZXetF0/pnPXQbIraK1yPLzCzv1pY7B/Z
         uXpMLj+ofmgMdn2wRWEjpeQwq6K7lztRcJXhcZYQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191026090740.9581-1-jgross@suse.com>
References: <20191026090740.9581-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191026090740.9581-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.4-rc5-tag
X-PR-Tracked-Commit-Id: 6ccae60d014d5d1f89c40e7e4b619f343ca24b03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fac2407f809e2ccc846bcce1d62ebbf7b0a1cd2
Message-Id: <157208670702.20302.921862092816517381.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Oct 2019 10:45:07 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Oct 2019 11:07:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.4-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fac2407f809e2ccc846bcce1d62ebbf7b0a1cd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
