Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B63318E2F2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 17:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgCUQpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 12:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgCUQpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 12:45:08 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.6-5 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584809107;
        bh=w8zbmzctDgDYpvxXlZaa1Pbgdy23s0nWznWTWfL4WuY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wtfrOrpP+I4B/wbtIj4KS6umVYuEbARuxu99tg7a5+HUvBREeg1eZwV/vxiQdTYuQ
         6eNsEhKnmvYBc2/Y+lmOR+4R5VKNAfcfRGAlyu+Ta/phuSmXGLLMIwCWrdmleo8T2r
         L0oQvKCzt2yFhHJI7nmVLkIVNKq0hrE8bV24XzJY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fte1dg0x.fsf@mpe.ellerman.id.au>
References: <87fte1dg0x.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fte1dg0x.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.6-5
X-PR-Tracked-Commit-Id: 1d0c32ec3b860a32df593a22bad0d1dbc5546a59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c63c50fc2ec9afc4de21ef9ead2eac64b178cce1
Message-Id: <158480910775.29703.12350611387973365171.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Mar 2020 16:45:07 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@c-s.fr, groug@kaod.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Mar 2020 23:54:54 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.6-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c63c50fc2ec9afc4de21ef9ead2eac64b178cce1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
