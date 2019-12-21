Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA2F128BD8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Dec 2019 00:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfLUXUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 18:20:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfLUXUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 18:20:09 -0500
Subject: Re: [GIT PULL] libnvdimm fix for v5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576970409;
        bh=7fbGfoEJtFS0Sef1e8X5drdSmP96+Xjn9/xIHrZW6Ps=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BqXnIFoHU2zbEifs0Q/FMNSVssxSyEdl7IcjhDDgfJm+HbVvnY+p1Gxq/qK4bcKE6
         Hp9OALzIQYHLH4Un6vX9ZoqQTSqfJIhlkyeIDffJPzGheUcIZwVhV/ATBvZZB7RnCW
         gvMEwXE2hmrQJMyEqLxrxsSOmOJVuvRD+P15p2NQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gfbuttbdW0ea6EUzMihUK33cc0mBQmLjqZe1T_QCKF-Q@mail.gmail.com>
References: <CAPcyv4gfbuttbdW0ea6EUzMihUK33cc0mBQmLjqZe1T_QCKF-Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gfbuttbdW0ea6EUzMihUK33cc0mBQmLjqZe1T_QCKF-Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fix-5.5-rc3
X-PR-Tracked-Commit-Id: c1468554776229d0db69e74a9aaf6f7e7095fd51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4746104a6f599f213c3d97d8c39032953fd4580f
Message-Id: <157697040940.14543.13427891455993675175.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 23:20:09 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 13:07:20 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fix-5.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4746104a6f599f213c3d97d8c39032953fd4580f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
