Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA20F123586
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 20:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfLQTUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 14:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbfLQTUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:20:17 -0500
Subject: Re: [GIT PULL] x86 fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576610417;
        bh=hsI+K00C/XUXdUZMCwdfw50jpkue20JInqsCtPp4c/A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GXKMCBNg4OB1HnvV695XfYUFqRr6HrOJiKKulGrWXjRr+cR/jDO/Yf/L2s7fM7YIu
         I2BJ7vF9oKdCmFWWpI792kEZnQ0E2RIKnn0dG+NB8D/3wEfo8qi8ef9PbnLwT0pOZk
         gzVukMtHjO186VOy19zDhDcf/wR6ybO7m6YlyX6o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191217115835.GA100231@gmail.com>
References: <20191217115835.GA100231@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191217115835.GA100231@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: af164898482817a1d487964b68f3c21bae7a1beb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9065e0636036e4f8a6f65f9c34ed384e4b776273
Message-Id: <157661041717.14288.13756738899830131468.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Dec 2019 19:20:17 +0000
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

The pull request you sent on Tue, 17 Dec 2019 12:58:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9065e0636036e4f8a6f65f9c34ed384e4b776273

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
