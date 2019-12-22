Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6621128FAD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Dec 2019 20:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLVTKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 14:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfLVTKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 14:10:10 -0500
Subject: Re: [GIT PULL] RISC-V updates for v5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577041810;
        bh=ScRRJJEPWTofBaOZWjnSQVNLkENmzibt2MZHv4Bp+cE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lsD1f8RpkYewEVVKKSPz7ekLnTYB1hcl7SsrqO3JpB7Bao3ldMoswHYXqIJ2b7V2e
         MZ+DKdJAEdBGb6YgO9KrgHntS7urNloPDnyMHZaIBkXI5z6He3E+cSOkdeRANRC22K
         GJmekekflRbgJHNTOf7qP9/2ugE55AqSHj8Fw2KI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1912211854440.57866@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1912211854440.57866@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1912211854440.57866@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.5-rc3
X-PR-Tracked-Commit-Id: 9209fb51896fe0eef8dfac85afe1f357e9265c0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7214618c60e947b8cea12b47d8279bd4220f21bc
Message-Id: <157704181043.1067.2754149951561806766.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Dec 2019 19:10:10 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 18:57:50 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7214618c60e947b8cea12b47d8279bd4220f21bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
