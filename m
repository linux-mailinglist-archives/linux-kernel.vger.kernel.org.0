Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE52CB446C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 01:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390122AbfIPXFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 19:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389994AbfIPXFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:05:18 -0400
Subject: Re: [GIT PULL] RISC-V updates for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568675117;
        bh=EYR2fYa2Pxx3FqcnzK82r9ahc0fLXxJECj8/NIbLbAQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dX2xokf8ic/lXlfIshVdLl9QyXGeqb4eumKC1pbqPcjhL/gnAFHdkD842PRodoI9i
         utToS69Crg33a+17Ta6Qv6XuBU8oZHnKXacerTuN7saNleyJL5k/wECci97zMTlwvE
         /glNl5s7JeeeNB3Jq7cWQW17UbPJeJRdzwjl0nKA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1909160819190.11980@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1909160819190.11980@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1909160819190.11980@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.4-rc1
X-PR-Tracked-Commit-Id: 9ce06497c2722a0f9109e4cc3ce35b7a69617886
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58d4fafd0b4c36838077a5d7b17df537b7226f1c
Message-Id: <156867511761.30760.331827168346797172.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 23:05:17 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 08:20:33 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58d4fafd0b4c36838077a5d7b17df537b7226f1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
