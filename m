Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F16A4565
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 18:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfHaQpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 12:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbfHaQpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 12:45:09 -0400
Subject: Re: [GIT PULL] RISC-V updates for v5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567269909;
        bh=/fHp3kLHKPUyba/CwSRKgzyn/0MAzCsY6n0GeY7+VV4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mC4Vmv1qgV7xGwK+iUTOdka7OnIJGnuCBzx8jRswH3+WtqJILyIxV3iHyR2T0Vumo
         v6p8Gj0/4qPx1TpnEnyUQD/aPbgCfyvv0+xylQg3/+K/hkvRiwAA1JU9+9AFBZsndh
         1ksfOhfQLWyqv3X/4tDJsBMUClAXOBkwuNCHqHk8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1908301929460.8525@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1908301929460.8525@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1908301929460.8525@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.3-rc7
X-PR-Tracked-Commit-Id: a256f2e329df0773022d28df2c3d206b9aaf1e61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fb86707cc3a256e5556ced9c3a3eb96122d4b16
Message-Id: <156726990911.25629.16862572760885991706.pr-tracker-bot@kernel.org>
Date:   Sat, 31 Aug 2019 16:45:09 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Aug 2019 19:31:58 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fb86707cc3a256e5556ced9c3a3eb96122d4b16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
