Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346C711359F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 20:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfLDTZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 14:25:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfLDTZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:25:20 -0500
Subject: Re: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575487520;
        bh=p001tXcFFs4/gCV/Xle86ZqhJzzEvFjeeOtj7m5tDYk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zd0KqNteV4mItYA7tH6031GmT+IAq5Vfi+HbOMI+Z07IxkSpw/jXCvg0wVBNMi0co
         qNrYVOqSaSERjM8Ypdkj181rWOyErZVREr2VfiYqjGC/CBKEdkdlsAIofn6BD/m9R1
         bmerxKjSiS790gf/SFzvexbF8eVBl9u3g61B804M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.5-rc1-2
X-PR-Tracked-Commit-Id: 1646220a6d4b27153ddb5ffb117aa1f4c39e3d1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cdc7f2efc25a6dbddf7c57bb2eee5d6c033d678
Message-Id: <157548751994.30814.9638490489513007318.pr-tracker-bot@kernel.org>
Date:   Wed, 04 Dec 2019 19:25:19 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 4 Dec 2019 00:52:08 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cdc7f2efc25a6dbddf7c57bb2eee5d6c033d678

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
