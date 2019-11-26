Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 281BE10A485
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 20:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfKZTaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 14:30:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfKZTaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:15 -0500
Subject: Re: [GIT PULL] x86/hyperv changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796615;
        bh=35eY5UC5l98GKkfVTxcDZoj2+W1SBR5h5ApPUW8+jKE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rTV9ReML/LXw8Bi8H1hEQ+9+IKYlul6ujWk85AFA/o5YQykmdy9DNZKQjEvGNnfZo
         A7fB5vydodMehU3saFHayPkjG8sO/p7xlbkJpw2/gVCjrOP7jq+eEmlW/1ltWmNQHU
         9gWL2+YHGqgsaSo+W9UBotyvbGR4ip0WUs6NV+/k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125140522.GA56668@gmail.com>
References: <20191125140522.GA56668@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125140522.GA56668@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-hyperv-for-linus
X-PR-Tracked-Commit-Id: 4df4cb9e99f83b70d54bc0e25081ac23cceafcbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64d6a12094f35d644540c15440874723b1887f9d
Message-Id: <157479661510.2359.7811452898179311082.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:15 +0000
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

The pull request you sent on Mon, 25 Nov 2019 15:05:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-hyperv-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64d6a12094f35d644540c15440874723b1887f9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
