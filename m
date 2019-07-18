Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB706D4C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 21:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391387AbfGRTaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 15:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391342AbfGRTaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:30:17 -0400
Subject: Re: [GIT PULL] RISC-V updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563478216;
        bh=D1f/Tc3RXavpmYOt0PHRUeAsG9ee1Ov4o3Y53yPM7LI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zIQiw1cMMRma0E/MYgXBQ4I3aZtkLL2ZxaRcOKzijKBX2U4GSj3cYkoKPRvtR94yU
         9qD64wGChsZmoAwG7NKMO2uz3cijc0qJ7odtdhjRjr1rNgQ19+OnUrioYYvplU7btC
         0C3qKyJVvPnrgmbubFqq6uf+DewsJ+qgykN3lcSc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1907181155050.17807@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1907181155050.17807@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1907181155050.17807@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.3-rc1
X-PR-Tracked-Commit-Id: 2d69fbf3d01a5b71e98137e2406d4087960c512e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0570bc8b7c9b41deba6f61ac218922e7168ad648
Message-Id: <156347821639.4271.16107164962398721436.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Jul 2019 19:30:16 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Jul 2019 12:07:36 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0570bc8b7c9b41deba6f61ac218922e7168ad648

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
