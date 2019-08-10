Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9D388ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 01:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfHJXkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 19:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfHJXkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 19:40:08 -0400
Subject: Re: [GIT PULL] RISC-V updates for v5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565480407;
        bh=vUFMdRRpUdRJSchw/Wj85gfdOIYjjm83fQJbpux6Z2Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=prTOolgF/V83Eal61PASI8MfgrSAuLD0G5QIK+CJujrAZxyjbUgbcHD5yYBP0CVlE
         kUNUFbYaS//ba3NEoRlVNtuPzxowGYFbyVHnN911zWdCJF4ODstjGpUXigNPdHLTmf
         43JKtNaLKxB7hL6R9X73W5gM/XVFwZdIW11kgZ7g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1908101451050.22177@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1908101451050.22177@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1908101451050.22177@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.3-rc4
X-PR-Tracked-Commit-Id: b390e0bfd2996f1215231395f4e25a4c011eeaf9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 296d05cb0d3c9f4648e31abb8ce404ac6915d66c
Message-Id: <156548040730.7293.15246531905901951311.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 23:40:07 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 14:51:56 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/296d05cb0d3c9f4648e31abb8ce404ac6915d66c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
