Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F062DAD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 03:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfGIBpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 21:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfGIBpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:45:08 -0400
Subject: Re: [GIT PULL] x86/build changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636707;
        bh=e+Bz2pdNv6zWxhv31TEwKs7C0qeiw+r4tflj8d0dn/4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KBbusdn/pCDTLOH4TajvcInWmS0qdQAAbmzsfdryPfScngKNyM0YvXGHeeYSrfhbT
         NOHnjtq9P67lzHey9ojQsn+Dc4ua3D0i37Ep7dB9N10ha7RmjjdA/IdQLBx0Ca5pNq
         XIbi/3gGdP6Mlin4652fhQ+6TmGIiX9KRq4El6eI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708130931.GA100057@gmail.com>
References: <20190708130931.GA100057@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708130931.GA100057@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus
X-PR-Tracked-Commit-Id: 87b61864d7ab2aec5c212ff18950d4972f0dfb4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c83b5d321b58794b8469d57990dc3884cbcd289e
Message-Id: <156263670771.17382.1675809845946504288.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 01:45:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 15:09:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c83b5d321b58794b8469d57990dc3884cbcd289e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
