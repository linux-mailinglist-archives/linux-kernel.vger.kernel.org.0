Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881B814C1F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 22:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgA1VP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 16:15:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgA1VPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:15:06 -0500
Subject: Re: [GIT PULL] x86/cache changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580246106;
        bh=/UPoKIu/WPQNdLD8n7PUdqwUR6CyNWh3C+yokVCwuxs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f4qmnVwDvK7eKHp7Cy/d9C+6144o8hy3OY4hdPz9G3MfcyYEUfXGTxqXGjtwcM6Mw
         c4AyIKlohTMsWsfjyoB6gJUuvDWlXXmGHTW97Vd/DB2rX+4eB4Hjmxy6a9wq1tqQ0v
         8vm+2gHJN7S+1D79FmNtMEJP7BPEwLzUIoS8nwKA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128172826.GA83630@gmail.com>
References: <20200128172826.GA83630@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128172826.GA83630@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus
X-PR-Tracked-Commit-Id: e79f15a4598c1f3f3f7f3319ca308c63c91fdaf2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4244057c3da1dde07c0f338ea32fed6e79d6a657
Message-Id: <158024610642.20407.8058075761492928777.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 21:15:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 18:28:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4244057c3da1dde07c0f338ea32fed6e79d6a657

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
