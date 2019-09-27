Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32523C0C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 22:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfI0UPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 16:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbfI0UPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 16:15:24 -0400
Subject: Re: [GIT PULL] RISC-V additional updates for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569615324;
        bh=SwDH7HOQCXwqvoE/PXOXeg2Huipb2qJ2AhfuVGYaeRU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qOZKTLKbemVfI9oSkqtCpFRQN+x+xuHXtdSyz81+LqihP/EKbT6T9l3mRW7Ey+zkX
         8jfcOd9SrSqs6W9Q0IaItsMzP7hnphU5ZI+4T9FPapGKnq9ItVdoVZtEWfpt24/Suv
         +IfgANDXSHrgY1Rin8R7MD/x4z9ddDvftN5UcCjA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1909271123370.17782@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1909271123370.17782@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1909271123370.17782@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.4-rc1-b
X-PR-Tracked-Commit-Id: c82dd6d078a2bb29d41eda032bb96d05699a524d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 568d850e3c6015acec8f854f5be97766497a676b
Message-Id: <156961532414.31800.14952198314598782581.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Sep 2019 20:15:24 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Sep 2019 11:25:13 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc1-b

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/568d850e3c6015acec8f854f5be97766497a676b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
