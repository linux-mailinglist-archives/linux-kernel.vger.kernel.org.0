Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3FF8168AC2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 01:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBVAPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 19:15:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgBVAPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:15:12 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.6-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582330511;
        bh=W3W8pYm8I7eHMCrdn3ZXX+yGKhlB96u/mT1KxqIfAv0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JIIpA3aScnOPW9wex9YeSv3xkK8mNA43T2pRU1hOt0f3jiXHwjoni/RUHtw+6ja88
         I2F8Ep2WScZrYfaVPCTzeLQa6z/WOQNSp4Y0BHtU14QOD0l/EJU1PyyVTbVfCzs2bq
         /eH8PxCWnK/zMaW8MQl+3nkuJMAJX/vdiQ8Hae/0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87lfowdv54.fsf@mpe.ellerman.id.au>
References: <87lfowdv54.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87lfowdv54.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.6-3
X-PR-Tracked-Commit-Id: 9eb425b2e04e0e3006adffea5bf5f227a896f128
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2865936259e27629fac422bc80c9b55ca1f108a5
Message-Id: <158233051185.15315.18250424563849105546.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Feb 2020 00:15:11 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@c-s.fr, gustavold@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, oohall@gmail.com, sbobroff@linux.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 22:42:15 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2865936259e27629fac422bc80c9b55ca1f108a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
