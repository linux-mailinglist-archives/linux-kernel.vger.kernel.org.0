Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12ACB15669
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfEFXkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfEFXkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:12 -0400
Subject: Re: [GIT PULL] x86/irq changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186012;
        bh=QXxnEiMjqgdYDUrcAGNNpSiZUyhV++GcSFhrW0fvNN8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vjJCCIyy4Arn2oU6faTbm6vD59HgT39MdN8YiTIxaGU2sTZxTpHB9+xcKZzDevqR4
         ZvPieOOODX0wI/Hf1XWKXHcdXzQVAo/OE2tJP+ifi+HwVajC65yL08fh7eY01fW7qY
         beVhykcWiRgUtSqu0aWAKSuPT83PhdX6kPH8kHHs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506102742.GA119840@gmail.com>
References: <20190506102742.GA119840@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506102742.GA119840@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-for-linus
X-PR-Tracked-Commit-Id: 2c4645439e8f2f6e7c37f158feae6f6a82baa910
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f147727030bf9e81331ab9b8f42d4611bb6a3d9
Message-Id: <155718601228.9113.2163655941593937952.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 12:27:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f147727030bf9e81331ab9b8f42d4611bb6a3d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
