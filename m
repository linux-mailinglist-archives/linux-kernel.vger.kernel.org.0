Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC918803F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 18:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437388AbfHIQfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 12:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437343AbfHIQfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:12 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565368511;
        bh=419T7J4k04LmxtI6IPhOmUj3dbhoV69tdbHRuMz03Jg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jx6W+d++wIGb0nsUYq8WVk8lkMQ7Js5/BGWkyHBDFnJZtmxdiMHT6/SzKIHkIw5t6
         pTXJlwDfShFJ1OcP8fdddiLbkBEGSU9sgYZGIJPP/SstGpWPD4Cxg+RxTYq5sAGM/Q
         ai/rU/rczTpIzp7b+Jj8cAw8pLfEvPZs1D6n70uE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190809161513.GA42536@arrakis.emea.arm.com>
References: <20190809161513.GA42536@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190809161513.GA42536@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 30e235389faadb9e3d918887b1f126155d7d761d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15a555a4b8be26683d77df8d5dbe8ac83f5ec3a6
Message-Id: <156536851143.6429.291425612357631279.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 16:35:11 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Aug 2019 17:15:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15a555a4b8be26683d77df8d5dbe8ac83f5ec3a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
