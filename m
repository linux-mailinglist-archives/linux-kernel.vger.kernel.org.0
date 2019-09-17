Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67FD8B45AC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 04:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404002AbfIQCzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 22:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403756AbfIQCzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:55:23 -0400
Subject: Re: [GIT PULL] x86/hyperv changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568688923;
        bh=JByFO9kMtyemgF6M3FJ4zyYEaVZJTjcICeHoYnI8r7k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=a3gYeQNGVn8I/NraDdrZq4fN6QBSj12ZQUMy9UAfWmesG4dXmHdxTPk3yBXm7mM3q
         GpbMHvx4OhrIW96qZDczFdvHLuchp8WqA2MOGgoSQHBSBM3Nrc+Io1gNhUeCP/56rl
         gZ0GnfTdOS+En8sa4A6VcERpGhy98bwi9+11SbU0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916131851.GA27870@gmail.com>
References: <20190916131851.GA27870@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916131851.GA27870@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-hyperv-for-linus
X-PR-Tracked-Commit-Id: 83527ef7abf7c02c33a90b00f0954db35415adbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2bddc20b562ee23046ad541cf29314e4aebd934
Message-Id: <156868892314.5285.497853662316493947.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 02:55:23 +0000
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

The pull request you sent on Mon, 16 Sep 2019 15:18:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-hyperv-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2bddc20b562ee23046ad541cf29314e4aebd934

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
