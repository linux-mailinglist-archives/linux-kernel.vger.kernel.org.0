Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79546495F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 01:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfFQXfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 19:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfFQXfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:35:06 -0400
Subject: Re: [GIT PULL] RISC-V patches for v5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560814505;
        bh=jrDbJSj1l+QKbJqYxevvzNKpDjm3U21oYvoFhSEewz4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RZRNMiqQkw64ZR5oA69fW9xkstwUQI3BaEBF8Yn0gMUm5ScpJpEwHMq9KYty5hACk
         Lg9btKcvDyG4VgjocpyhPNMKLxMwm/NkFaKWqG/jXmA+4hvqKZNUVrVV3lTfCYo2jZ
         Wqw4muTyq/N9abG4zU3rF+9/aXKUtZLD9ivFDUDY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1906170846340.30717@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1906170846340.30717@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1906170846340.30717@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-v5.2/fixes-rc6
X-PR-Tracked-Commit-Id: 259931fd3b96e4386b361b7f80c1d89b266234c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb7c825bf74755a9ea975b7a463c6d13ffa7f447
Message-Id: <156081450530.13377.16512075624141973247.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Jun 2019 23:35:05 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Jun 2019 08:54:30 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-v5.2/fixes-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb7c825bf74755a9ea975b7a463c6d13ffa7f447

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
