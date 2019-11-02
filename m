Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE54ECC53
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 01:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfKBAZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 20:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfKBAZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:25:05 -0400
Subject: Re: [GIT PULL] RISC-V updates for v5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572654305;
        bh=rtAbQmYG1g57RZPGwAl6aXJA/mCq5GppXcLSxLzbGqM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IzusSL9BViZswqm8g/Ec0jDdXkP067plgtjoOZ3LNphTL/jpNA/HFDnB9RJrOqFV4
         eQWePFTHbpTBXMBrYdCdh3zHkld+cjMa9WzDnlAsyO5E02bz5N8zm4bJx31cKjSdPj
         2S8EgzQYORfqWooAtzCuG/GzmTrRF0ZznJhuTo9w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1911011707090.16921@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1911011707090.16921@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1911011707090.16921@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.4-rc6
X-PR-Tracked-Commit-Id: 1d9b0b66c3ef03e42db63068e1a4e7250992e2b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5897c7d2e6507ac2423455bada21c8a6b005db6
Message-Id: <157265430498.28513.2104609031890890050.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Nov 2019 00:25:04 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Nov 2019 17:10:16 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5897c7d2e6507ac2423455bada21c8a6b005db6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
