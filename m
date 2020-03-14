Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 478CA1858D5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 03:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgCOCYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 22:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgCOCYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:12 -0400
Subject: Re: [GIT PULL] clk fixes for v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584203708;
        bh=nlkSd9dZ2OzupyIAX3ttyXzPZ+1/uu0Tt8oO6gT4tTg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zh4FGvEyBRXlInS75a2kUSdTtzf7g9HUQ7+EDh1ZSdyiINAMJL24+a7W1uRlq8FII
         1JCDnZ/BexU3Wj/5EbAvM+czCk5q0p19EHhecQrzWgjmsDg2dMzkFm7GOTtnEeiwzg
         FXirIhNvRU/415hL8+uCKd98JrrwLvMNKOZJ+a0w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200314012722.234270-1-sboyd@kernel.org>
References: <20200314012722.234270-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200314012722.234270-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 20055448dc1b439c87d0cb602e6d0469b0a3aaad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69a4d0baeeb14b6a3c47570a0ac2e0fc4474f0e0
Message-Id: <158420370808.8641.17291481150926081366.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Mar 2020 16:35:08 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Mar 2020 18:27:22 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69a4d0baeeb14b6a3c47570a0ac2e0fc4474f0e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
