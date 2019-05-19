Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02F227EC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2019 19:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfESRpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 13:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbfESRpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:45:24 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.2-2 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558287923;
        bh=7xvkMEJP6TZQGs90N8lPVLkD94TPzvSWtlkz2Ao0GNE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yWWmZXmtb4ZtqELg4M4sfd6YFmIgm51hnEMo5d/X7AAW9mari9tpU5emPes7eCFI0
         1aPxG/kVIJzdwMQ7xkRwYIg9GriS+46ZB9t5LGc1YbCaaOY1V0MBVAiDxsUFcqOjR1
         tjb8nIgdH8IZkuFlhYgifQgC5ydCx4zAgnUcYRR4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bm00818p.fsf@concordia.ellerman.id.au>
References: <87bm00818p.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bm00818p.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.2-2
X-PR-Tracked-Commit-Id: 672eaf37db9f99fd794eed2c68a8b3b05d484081
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86a78a8b8d0414455c2174852968ce54205add82
Message-Id: <155828792351.9186.916934956975502044.pr-tracker-bot@kernel.org>
Date:   Sun, 19 May 2019 17:45:23 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, christophe.leroy@c-s.fr,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tobin@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 May 2019 21:12:54 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86a78a8b8d0414455c2174852968ce54205add82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
