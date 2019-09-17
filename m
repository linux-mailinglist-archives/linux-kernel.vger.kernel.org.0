Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABB5B45A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 04:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403841AbfIQCz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 22:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392053AbfIQCzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:55:22 -0400
Subject: Re: [GIT PULL] x86/entry changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568688921;
        bh=3ZxTNJqwHkutOCWNwE8aZEQsiHEMxSAUtPzpJJAPYPk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GEAJk0J7tGg6tHX6ygelo+/LEcY474CkjP94WpUIA5ZPosYv9yQhXuD6qLiAXr7jB
         Yk++jWhY+bs0JNOOutGUJdU+hoL0m3ZTMMBJ+4gPU9mB7cPmXoUF8qqXfXWBMDdZff
         5DxuCRIZkYwwszMWIrtoTxLdYFhNv7dFkuuCRINw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916125811.GA73360@gmail.com>
References: <20190916125811.GA73360@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916125811.GA73360@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus
X-PR-Tracked-Commit-Id: 6365b842aae4490ebfafadfc6bb27a6d3cc54757
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0d60a1e68a3fbf42cdf3546004e00230d9048ba
Message-Id: <156868892189.5285.10611437167827474083.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 02:55:21 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 14:58:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0d60a1e68a3fbf42cdf3546004e00230d9048ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
