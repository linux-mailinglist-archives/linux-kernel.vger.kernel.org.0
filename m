Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E46AF4D9FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 21:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfFTTKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 15:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfFTTKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:10:05 -0400
Subject: Re: [GIT PULL] s390 updates for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561057804;
        bh=bOXL6+/OXDgEFWo2egX33mwohLHkdTecViIi+c1FV4U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x+Yh2w7uhYnlQjqm0lk79psIxzBkI6GKFdWVgDs8J0nC3yiAwNTjDbJhd1qLQkYhE
         njF5gCNiV22n2/9+tZVSO9bTW5ZGWEtwotH91NXp7eMGrWyNU3X6fbe9ZxWXsjRkrn
         38mSk3mWVT5d4zUo2mMDhh4YBrcCBm22zzh3ZF44=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190620121727.GA4387@osiris>
References: <20190620121727.GA4387@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190620121727.GA4387@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.2-5
X-PR-Tracked-Commit-Id: 11aff183225c5cf48fae074cd99d8f18ba84ed34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a409de616259c520cc864f3a2bba69dde208c8be
Message-Id: <156105780442.22331.5122926078611703382.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jun 2019 19:10:04 +0000
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Jun 2019 14:17:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.2-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a409de616259c520cc864f3a2bba69dde208c8be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
