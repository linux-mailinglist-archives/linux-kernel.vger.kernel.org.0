Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA0A710B71D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 21:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfK0UAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 15:00:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfK0UAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:00:16 -0500
Subject: Re: [GIT PULL] First set of RISC-V updates for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574884816;
        bh=S03p4uHH+3stFzte3DVgsrqEvGsRCqtTD/GxeT3+Yi8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vFufiaMaD2jpHePhT5SvHilhHPalAVbVZQ/wiEzePxxd2w5nnvYwXP/f4y7hXwcRL
         4jk+MkY5QJVH9g9Oeeg0et4H8HkYw5ZsUfE5a0AKegU3fduNY82FVjfuWhpTcVe2h0
         EOuBFrPHgNgaNIdDWroCXPp1D4fpbIlb8TMeZ6SM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1911261311520.23039@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1911261311520.23039@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1911261311520.23039@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.5-rc1
X-PR-Tracked-Commit-Id: 5ba9aa56e6d3e8fddb954c2f818d1ce0525235bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a0e20cd8cddd70ae5c1211ebe102d738ff2069b
Message-Id: <157488481647.30408.5646332357749422178.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 20:00:16 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 13:13:24 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a0e20cd8cddd70ae5c1211ebe102d738ff2069b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
