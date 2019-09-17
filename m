Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75F0B45A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 04:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403919AbfIQCz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 22:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392096AbfIQCzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:55:25 -0400
Subject: Re: [GIT PULL] x86/platform changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568688924;
        bh=TpXye54OEPaSqjAX2jsk7ptOpwL6zONfPi6WqaXbJrM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G0ZVhvuaajHP4IpgzDI5z9iCpUugvFAOSo9SFiaBeFhPA7WKaMvoeDBk/7lAE2HmZ
         M8A0fhXbsgaPzlhYkP4MuY+eGN3ie6Y2JCX03/jU9IpVdQlIdWILG8zbTHp7Kwg11C
         yIngBM4l0HQ6xSHSck0fGZ7W2FD+tzqaHusaAlDs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916133109.GA111962@gmail.com>
References: <20190916133109.GA111962@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916133109.GA111962@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-platform-for-linus
X-PR-Tracked-Commit-Id: 864b23f0169d5bff677e8443a7a90dfd6b090afc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f24671485d0d0eaeaccd910fa8148db72aac089
Message-Id: <156868892457.5285.16967934666173465387.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 02:55:24 +0000
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

The pull request you sent on Mon, 16 Sep 2019 15:31:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f24671485d0d0eaeaccd910fa8148db72aac089

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
