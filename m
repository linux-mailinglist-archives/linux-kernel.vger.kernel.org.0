Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49CF11EE39
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 00:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLMXKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 18:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfLMXKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:11 -0500
Subject: Re: [GIT PULL] treewide conversion to sizeof_field() for v5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278611;
        bh=W0/3GK7wjRbtYrP1sNxwWGJzeNh9uPSeWJTmPG73fwU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hHmQwpH+RNhSAXoUrf9aWUK+IEed6vMsUyG6Vh4hshHvcS3hv/UHVJjjK5oYtGHYz
         USS+SagH0WdX4GiO9RsfMwAg7skb3uzHRIA4TIHtEFlbFdciYyGxRIhGoxm2wxuyhz
         +FbiKut1COFxN3LQB6W+gy/mh8rRY5ph7ndlhQ2A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <201912091054.ECCE323A6@keescook>
References: <201912091054.ECCE323A6@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <201912091054.ECCE323A6@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/sizeof_field-v5.5-rc2
X-PR-Tracked-Commit-Id: c593642c8be046915ca3a4a300243a68077cd207
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22ff311af9c7d0eca4e9d276e95c4793a6ecf84f
Message-Id: <157627861114.1837.10201169523541394928.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:11 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Joe Perches <joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 9 Dec 2019 11:05:51 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/sizeof_field-v5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22ff311af9c7d0eca4e9d276e95c4793a6ecf84f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
