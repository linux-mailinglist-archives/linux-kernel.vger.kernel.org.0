Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD2E011592C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 23:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLFWP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 17:15:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfLFWPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:15:25 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575670524;
        bh=E8ISvmds41DFWEjClhfOxnciAGgZDAjp4K1H2UbEols=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rf2L6mw7FLlNaKq5N1xuCKjmW8VP1MW4H7ArcU21isRzTCbpKccrot9Hi3jDj5my1
         dwPgoDt9fS7Tz1CefW7K9wC29Xo6HEK9Eo6qyg60CSUxztkumgNyZliJ8uhZSTtOGw
         LqpRWryhtnRvAtLYp+UJggG7a8CliBlQa0Fsk+K0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878snpei4i.fsf@mpe.ellerman.id.au>
References: <878snpei4i.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878snpei4i.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.5-3
X-PR-Tracked-Commit-Id: 249fad734a25889a4f23ed014d43634af6798063
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f89d416a8676fe36de8be0f7c2e1ac6cd51410a8
Message-Id: <157567052459.8833.17428102493710399717.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Dec 2019 22:15:24 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, anju@linux.vnet.ibm.com,
        ardb@kernel.org, christophe.leroy@c-s.fr, clg@kaod.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, skhan@linuxfoundation.org,
        vincenzo.frascino@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 06 Dec 2019 23:46:53 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.5-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f89d416a8676fe36de8be0f7c2e1ac6cd51410a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
