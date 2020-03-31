Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D715199EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 21:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbgCaTPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 15:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729974AbgCaTPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:15:16 -0400
Subject: Re: [GIT PULL] x86/fpu changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585682115;
        bh=BeMZixTF0tnwsgktlo7CGHaFkpuEF2Q21mg0KjSndq0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ENom3FT0CzAqrIvMS808CrGxWLp6F/T19N7l+O8Rn/5cPizGTKhpU5PeI/OkvuvOL
         kddtF05yiMfz4IihbbFjQ+yljA1ePTsd7q88Rkn5PXJBQlurYLY6ncKRLOC+iFEnX6
         DYjH2K/C4fA+pU4fvtWRE12hIZfnJNKjjo3GD9FI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331081525.GA40938@gmail.com>
References: <20200331081525.GA40938@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331081525.GA40938@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus
X-PR-Tracked-Commit-Id: 16171bffc829272d5e6014bad48f680cb50943d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0be2d53c7df80753746f564220279ee4b725632
Message-Id: <158568211558.28667.1617421670443164768.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 19:15:15 +0000
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

The pull request you sent on Tue, 31 Mar 2020 10:15:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0be2d53c7df80753746f564220279ee4b725632

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
