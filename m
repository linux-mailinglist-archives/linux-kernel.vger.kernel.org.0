Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E1732486
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 20:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfFBSPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 14:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbfFBSPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 14:15:15 -0400
Subject: Re: [GIT PULL] core/urgent fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559499314;
        bh=00spy++b8GBIXamTo/ug+MxBFWrpce3neEjj7ujpXGM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vrIosgmvxQSIf9MkMzw9JTBGKJ8/WJS0Jd9vh87dHl8iSYqz36lHaS4lLwo69JJd4
         UYW+MxuWpkHDc/TwgtNkyYGaGuZ5TL4gJQQJTXqULUtpA0/PrgGSTn6+9aJ9AWTUUN
         8fqxPC9F/ZLT5iQY4AUpTkVLcobQCV8DcsOQo0ZM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190602173234.GA126544@gmail.com>
References: <20190602173234.GA126544@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190602173234.GA126544@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: 7eaf51a2e094229b75cc0c315f1cbbe2f3960058
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fb5741c7c5defd88046f570694fc3249479f36f
Message-Id: <155949931457.4617.18051022777730196537.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jun 2019 18:15:14 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Jun 2019 19:32:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fb5741c7c5defd88046f570694fc3249479f36f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
