Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC154159E87
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 02:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgBLBKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 20:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbgBLBKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:10:23 -0500
Subject: Re: [GIT PULL] dax fixes for v5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581469823;
        bh=1zxWpQ2kIBJxRWqJGLN1xWrlPdtElQ48K3NlgPo5TnA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zUgDgnHe7A7Kin9yy0/qIaJP8Ka5qX9syJt6uWukF8qzDBQtCjmm41NdTYxY6Epr1
         Qxkb21Ul13oUvlTFTGjmkBYop5Eu41KaJfQzuNO/cjAYZO83poDYLTW+fSR6KqpYdK
         8OYEIJ1fL8MZUM+1lWB39KmHFL90mXReUu6WMQOs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4iQf80XGwYVU3-GnbxU7u+bu2bn=+MwM54WGyG1kN=ddQ@mail.gmail.com>
References: <CAPcyv4iQf80XGwYVU3-GnbxU7u+bu2bn=+MwM54WGyG1kN=ddQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4iQf80XGwYVU3-GnbxU7u+bu2bn=+MwM54WGyG1kN=ddQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/dax-fixes-5.6-rc1
X-PR-Tracked-Commit-Id: 96222d53842dfe54869ec4e1b9d4856daf9105a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 359c92c02bfae1a6f1e8e37c298e518fd256642c
Message-Id: <158146982342.31393.14778365135756811474.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Feb 2020 01:10:23 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Feb 2020 13:48:56 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/359c92c02bfae1a6f1e8e37c298e518fd256642c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
