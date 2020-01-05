Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9B013099F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 20:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgAETfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 14:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgAETfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 14:35:07 -0500
Subject: Re: [GIT PULL] RISC-V updates for v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578252906;
        bh=xtc1k9LC8YlxPU5m185HhvHlggNQUg5qFQaHxbIEyZY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HebMboWQTGkhA1i5LKUnQd6ZK9W213Zmx1CcZDax6hfQtbeEjrTPiGh72Kt7YVut2
         QY/GI/MGk3wrxbqaCnf+4GMEfZPLGvksGPfY3Mxwr5NwaiJahbP3brlHmj1R3zcEr1
         3PSPR0Ioj7fh/OSvbDf4sLWfW1DypgmbuFY5H5Vc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.2001042202460.484919@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.2001042202460.484919@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.2001042202460.484919@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.5-rc5
X-PR-Tracked-Commit-Id: 0e194d9da198936fe4fb4c1e031de0f7791c09b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 768fc661d12559b0dbd99d941b3bf28fe92fd365
Message-Id: <157825290618.9386.2695929445683299126.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jan 2020 19:35:06 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Jan 2020 22:04:16 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/768fc661d12559b0dbd99d941b3bf28fe92fd365

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
