Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3680ED03D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 19:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfKBSfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 14:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfKBSfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 14:35:07 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.4-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572719706;
        bh=+0bOjAh++uGZczvZk0UrE9+LWZT7ZQ12IT1o9C3iD2E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QbLR1aHxY4hEgEtKs2iS/4jxfc5vL5luJQtfvLNuYKFzvwapWUey1soCWfIlQekh7
         dSFkZB2CyTOZrGWr7w0fbGTcZXYFy0lFmxpEi2gGO9mrLHqwgyY5BLnxDJpxoF+C5L
         qrj+uNb80WFSyNWxjhFyAftTpKganMf1Qr5Ji5xU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <875zk236kj.fsf@mpe.ellerman.id.au>
References: <875zk236kj.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <875zk236kj.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.4-4
X-PR-Tracked-Commit-Id: 7d6475051fb3d9339c5c760ed9883bc0a9048b21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8194c28efd96127cd1948ca48f3fe374e04cbf46
Message-Id: <157271970656.32009.11112612674162847516.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Nov 2019 18:35:06 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        bauerman@linux.ibm.com, christophe.leroy@c-s.fr,
        fbarrat@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 02 Nov 2019 21:39:56 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.4-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8194c28efd96127cd1948ca48f3fe374e04cbf46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
