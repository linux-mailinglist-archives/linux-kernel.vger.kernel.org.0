Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFAFD52E2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 23:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfJLVkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 17:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbfJLVkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 17:40:06 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.4-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570916406;
        bh=3oP6+/0+rNNfPfZP75AUY0sO+HAX3rC8+O4Z4holfXE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VCpt0shdQFi1XqIhY9MAiIUahUjKTlvbZ+04d6YjqlQw5omJrxYivUUZIMru4s2Ek
         fgvjOWdc6JdMDMOsJwQeY2do6tJGoZzj8jWG7gsHU8SsT41fJx1Y8PQj4YHfEJfeGZ
         9M6KgEcrQ/GzLkF81EMjkpSa8D3vhj+uEgUnpXgw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87r23iurdg.fsf@mpe.ellerman.id.au>
References: <87r23iurdg.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87r23iurdg.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.4-3
X-PR-Tracked-Commit-Id: 2272905a4580f26630f7d652cc33935b59f96d4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db60a5a035aa8692dc7cee293356bdcc078fa7b7
Message-Id: <157091640632.3377.10259916414495442367.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 21:40:06 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, arnd@arndb.de,
        desnesn@linux.ibm.com, emmanuel.nicolet@gmail.com,
        jniethe5@gmail.com, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sfr@canb.auug.org.au
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 22:37:15 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db60a5a035aa8692dc7cee293356bdcc078fa7b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
