Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC94DC1A47
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 05:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfI3DFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 23:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbfI3DFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 23:05:23 -0400
Subject: Re: [GIT PULL] SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569812722;
        bh=AIJtETwpVND7wUPYnB9FXIKlxyIv/OfnnfgLjDy/YQ4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k6BLaz6j5jIgtbG4TYQogCG+2j0K+f8BK8zL+4JO/0DHd6bICsL9pMaNnx5y6kKfd
         8Z9sdTnnU3shPViLFU2c824keRZ0QJavYFUmfwMWQGq60H+kvaRC0hw6qWgVcSqKcD
         MHgAzCuTvXreUzYwvzha28qWiwyYDF1j+uqK9Vok=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mu_4C=V=BsNAsEiPQp-rFbV-rYixgkpG1oJzRWdSsbejw@mail.gmail.com>
References: <CAH2r5mu_4C=V=BsNAsEiPQp-rFbV-rYixgkpG1oJzRWdSsbejw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mu_4C=V=BsNAsEiPQp-rFbV-rYixgkpG1oJzRWdSsbejw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.4-rc-smb3-fixes
X-PR-Tracked-Commit-Id: a016e2794fc3a245a91946038dd8f34d65e53cc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7edee5229c8f4e075fe71274620bb11ead885c9b
Message-Id: <156981272288.21310.9451491849476703964.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Sep 2019 03:05:22 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Sep 2019 16:36:21 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.4-rc-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7edee5229c8f4e075fe71274620bb11ead885c9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
