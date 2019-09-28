Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E86AC1229
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 22:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfI1UuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 16:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfI1UuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 16:50:22 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.4-2 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569703822;
        bh=ze6cliEOUiUVzoy8NNLZbFo8kjc3vLmjiDahTajozAw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A3S/pQghcrexHgU29yVOXFVO0hsKThjFWMcKIy9HurII5ZZ7ZPfQXFIrmLCgpu9kG
         CB4U/8NJwHnXtewiZP7MBFKhfvL5hrUKrriZKaIitVNnvEixOuDN2/q3zysFpcTOc3
         HG90+6vPQOkPus8KPwTWMJue6pgK+3fLIridE+9I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877e5sr52g.fsf@mpe.ellerman.id.au>
References: <877e5sr52g.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877e5sr52g.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.4-2
X-PR-Tracked-Commit-Id: 253c892193ab58da6b1d94371285971b22c63260
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2953204b576ea3ba4afd07b917811d50fc49778
Message-Id: <156970382209.9125.2408026177073178873.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Sep 2019 20:50:22 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        alistair@popple.id.au, aneesh.kumar@linux.ibm.com,
        christophe.leroy@c-s.fr, gromero@linux.ibm.com, jniethe5@gmail.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mdroth@linux.vnet.ibm.com,
        oohall@gmail.com, paulus@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Sep 2019 22:14:15 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2953204b576ea3ba4afd07b917811d50fc49778

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
