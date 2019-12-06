Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFF111594E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 23:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLFWZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 17:25:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfLFWZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:25:24 -0500
Subject: Re: [GIT PULL] arm64 fixes for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575671124;
        bh=jKAdyHgaAIP/KERssKZ/MaqpNmUNwdOx04I20fLPgsg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LpCh6FWuEcrBQ3MQbPDVkj+7C26QnD8vtNFvcR3VH40F5xg8iHzdRkmN49VMCkSp0
         lFW5G5wzsdU6fbMJ6BrC7sC3CDLd7cAlZvHR1NcM+3VOrPs7F7KWoaVvJI3AnWqRmk
         PLHdGam4OKtDUMIEAIRdoWlZ0uJfKxDKU6NvpoBo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191206154602.GA53116@arrakis.emea.arm.com>
References: <20191206154602.GA53116@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191206154602.GA53116@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: de858040ee80e6f41bf0b40090f1c71f966a61b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98884281027d07b93f062b7c5e7aa01e76ba12c6
Message-Id: <157567112420.16568.760474811253048283.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Dec 2019 22:25:24 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Dec 2019 15:46:04 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98884281027d07b93f062b7c5e7aa01e76ba12c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
