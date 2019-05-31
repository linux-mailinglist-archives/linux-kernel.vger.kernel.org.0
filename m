Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4389306C1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 05:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfEaDAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 23:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfEaDAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:00:13 -0400
Subject: Re: [GIT PULL] clk fixes for v5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559271612;
        bh=g6c9X+Ca81eqt7cEcqsS9icVqt6e0RWJqE3HvColbx0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XxuX6z9e5BV6303Z9mZ5cayqt796SuIBPznThy+KtpkJ6b8c/EwsxbKYNAtPTSSnR
         XEiMBRjSnp5mQ/aXnZ14W7cHzzQykLssK3/+zhtjdiYaDnZCO3GSBtj4BYX3i4F7Et
         k58qyJ+jJ2kNc73Zr0pYVv1h8tUaNloaZsTg0/Q0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190529222916.57086-1-sboyd@kernel.org>
References: <20190529222916.57086-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190529222916.57086-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 1cc54078d104f5b4d7e9f8d55362efa5a8daffdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20f944965601c59e68865d4ee12225fbabb5652b
Message-Id: <155927161275.12059.9392571568533875376.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 03:00:12 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 May 2019 15:29:16 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20f944965601c59e68865d4ee12225fbabb5652b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
