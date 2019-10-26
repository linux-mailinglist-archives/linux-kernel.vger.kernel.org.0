Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84BEE59A9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfJZKpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 06:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfJZKpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 06:45:06 -0400
Subject: Re: [GIT PULL] dax fix for v5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572086705;
        bh=Vyc5SB0hiZdfFvAUsjm2Khzs8PKzyK7s7Xp2S38xRQ4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cAP4YFJGe8xirFgBYnuBEHyw8wdAEoA9VJ6mvAMV3pSDHpXjNFyoYYZmUO1ys9/Na
         /ow8284V3XQTHk5TgXut1ZWqPvH68kyV/q83JSGBT04/2XY0G9atPuayW0IPNTfnsN
         5zrXCc3I/1FLfuF7jVM0yzm5Goj0QqMrwF4dQ70Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gi--MyxXOt-vb4Tw+ku=jUYmo4y+YSV+6UJf24BCDAMA@mail.gmail.com>
References: <CAPcyv4gi--MyxXOt-vb4Tw+ku=jUYmo4y+YSV+6UJf24BCDAMA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gi--MyxXOt-vb4Tw+ku=jUYmo4y+YSV+6UJf24BCDAMA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/dax-fix-5.4-rc5
X-PR-Tracked-Commit-Id: 6370740e5f8ef12de7f9a9bf48a0393d202cd827
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 485fc4b69cd28f295947535175c147b943b0b2e4
Message-Id: <157208670550.20302.9647429553317188107.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Oct 2019 10:45:05 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Oct 2019 18:06:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fix-5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/485fc4b69cd28f295947535175c147b943b0b2e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
