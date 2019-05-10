Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C772F1A260
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 19:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfEJRfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 13:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbfEJRfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:35:15 -0400
Subject: Re: [GIT PULL] pidfd fixes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557509714;
        bh=XZ4ZiISGraajIDEbHvhtePWdbYMHVSpZOUq+pysgMQg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gcN0pK87md6rzSxXytPA52ZLUrtvpRFH0RKBXh3NfsHTnxo6HpxxEStbXHFW1HoDh
         k9k+k/xRUlrc/1O3YIBp+ye+DDF9bGS/HTunea+ONkPVgmvAccLDaEgrGgH83m6BcD
         2ngF83JH4avHmsynPUTvRsTs1GhMEE2SOxaSLa1w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190510125447.9179-1-christian@brauner.io>
References: <20190510125447.9179-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190510125447.9179-1-christian@brauner.io>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/pidfd-fixes-v5.2-rc1
X-PR-Tracked-Commit-Id: c3b7112df86b769927a60a6d7175988ca3d60f09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3232b43f7252e04efd703ca8ecb87e2567a36388
Message-Id: <155750971494.27249.9329908003570382453.pr-tracker-bot@kernel.org>
Date:   Fri, 10 May 2019 17:35:14 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        syzbot+3286e58549edc479faae@syzkaller.appspotmail.com,
        Christian Brauner <christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 May 2019 14:54:47 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd-fixes-v5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3232b43f7252e04efd703ca8ecb87e2567a36388

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
