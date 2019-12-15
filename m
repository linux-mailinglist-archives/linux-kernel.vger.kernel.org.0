Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F0111FB39
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 21:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLOUuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 15:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfLOUuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:50:14 -0500
Subject: Re: [GIT PULL] xen: branch for v5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576443013;
        bh=6Z8yQdJnOVQ2X3mpzz/zcvCviOftFYhSn6AXQxoO2L8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K5fjacCzDlc2uvqOVPWaHuSP1CTyZVtGN5MjVJ3+jwXQbXGnGwadNbBfs4N1IPNgu
         9MjoVVDkHFBe5Qb33dShzHvTccy7fTYH/f0gz9y12CN7HAUSqJe/IJkOs6nQrr5uil
         /6BDEkXcV2MilY0IjWcXa4EHll62qldPm1oRDOE4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191215060621.8328-1-jgross@suse.com>
References: <20191215060621.8328-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191215060621.8328-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.5b-rc2-tag
X-PR-Tracked-Commit-Id: c673ec61ade89bf2f417960f986bc25671762efb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b01d7cb41ff51b7779977de601a984406e2a5ba9
Message-Id: <157644301359.32474.2901429395998550786.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Dec 2019 20:50:13 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Dec 2019 07:06:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.5b-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b01d7cb41ff51b7779977de601a984406e2a5ba9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
