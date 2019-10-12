Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBBBD52E1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 23:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfJLVkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 17:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbfJLVkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 17:40:06 -0400
Subject: Re: [GIT PULL] xen: fixes for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570916406;
        bh=znUtNYlMCDy5GBQ4k9C9rKMZwsaQWIJYVlzdC2I/K2k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j/Nbg1vjrmcUnNpEcr3SW0/HYGuasjREk3l98kg7dU0rjQfdDYRtGGLQqmpmRfN0A
         s2FNiefLwYY38RgjpIvzc/Z1emWx8mGwzqGaAO627/lFO15ouFho9wPKPltiBGxX1u
         sw1/PaZvOxdMJPH5kzgaI32Tb02CTMt51nzIUPC8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012105131.10908-1-jgross@suse.com>
References: <20191012105131.10908-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012105131.10908-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.4-rc3-tag
X-PR-Tracked-Commit-Id: ee7f5225dc3cc7c19df1603597532ff34571f895
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 680b5b3c5d34b22695357e17b6bdd0abd83e6b1c
Message-Id: <157091640613.3377.9655167394267054654.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 21:40:06 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 12:51:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.4-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/680b5b3c5d34b22695357e17b6bdd0abd83e6b1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
