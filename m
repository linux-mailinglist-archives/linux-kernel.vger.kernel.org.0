Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF17410E4A8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 03:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfLBCuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Dec 2019 21:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfLBCuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:50:19 -0500
Subject: Re: [GIT PULL] libnvdimm for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575255018;
        bh=RO+fehXn7xEYNLzjW5d/2mdfvqStG6MwQCJzoZuVGaw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A8j3ICw2f8erBGN80bUB7I3sP0+B1g/ulo4rnRy1ZSraBXH1ZZ7xh+FqCcLv8ToZv
         Sx+l0EOx9ZCUTgVx9RGvhnp5+iX2nPzU++Sc9PCmCAP6Fd62Tg4fpJIrrq9u/CaLcW
         ywq/NIwU3SvKSBhFIHMMS6fgoCSRHsx/jZR9A2bo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jftz7mN=4zNPo1tGZfcXxfKunTUF4Owof6pJ108GYk=g@mail.gmail.com>
References: <CAPcyv4jftz7mN=4zNPo1tGZfcXxfKunTUF4Owof6pJ108GYk=g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jftz7mN=4zNPo1tGZfcXxfKunTUF4Owof6pJ108GYk=g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-for-5.5
X-PR-Tracked-Commit-Id: 0dfbb932bb67dc76646e579ec5cd21a12125a458
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d10032dd539c93dbff016f5667e5627c6c2a4467
Message-Id: <157525501843.1709.13111514700340254733.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 02:50:18 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Nov 2019 10:56:22 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d10032dd539c93dbff016f5667e5627c6c2a4467

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
