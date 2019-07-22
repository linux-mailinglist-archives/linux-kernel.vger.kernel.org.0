Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E7A70598
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfGVQka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 12:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731064AbfGVQkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:40:25 -0400
Subject: Re: [GIT PULL] pidfd fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563813625;
        bh=wHv8LXLUnItNTEBig1ems+JQ40VXtujfcCrGpFOrLe8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KyA1H893SoI2eGjSs6R4TwunbE8DVKhVUARX2/d2kR0AjPJSbCa5ZTbn76AOf9KuG
         jVS4AAJX5Jl6NvX4hj7yvkL6IYFGVgmZZYT/l8Zw4ZNtSs5BJ2RYP7WEvTo7eycRg8
         LGFkYCi3Yy8TBPRJmd7oNSry4TqlMAJLVMpTEbt8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190722142238.16129-1-christian@brauner.io>
References: <20190722142238.16129-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190722142238.16129-1-christian@brauner.io>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-20190722
X-PR-Tracked-Commit-Id: b191d6491be67cef2b3fa83015561caca1394ab9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44b912cd0b55777796c5ae8ae857bd1d5ff83ed5
Message-Id: <156381362522.340.5904552190927323611.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Jul 2019 16:40:25 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        oleg@redhat.com, surenb@google.com, joel@joelfernandes.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Jul 2019 16:22:41 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190722

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44b912cd0b55777796c5ae8ae857bd1d5ff83ed5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
