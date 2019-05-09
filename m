Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE8B19518
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 00:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfEIWPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 18:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbfEIWPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:15:18 -0400
Subject: Re: [GIT PULL] clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557440117;
        bh=ZhKJNDh4FnQO7UQnPY8DmUDINQaGP6NyfJZilGgJ/b0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hf/gy18KnkjCQ4cH/sjRa0WC5mvSYamiWnkf+UsmJf+4dx4p1JtOr1OdnrQoHMAWm
         fp513XFtFR0dqeT+y9lwtec/T6HZegUKE27XwLUSQvArUVw6HwZdRzuhxJiVNuWslK
         DUC91YTpqzj4U6kZrGtjCAh6yCAUM1x6xyYlalP0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190509211510.36920-1-sboyd@kernel.org>
References: <20190509211510.36920-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190509211510.36920-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: c1157f60d72e8b20efc670cef28883832f42406c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea5aee6d97fd2d4499b1eebc233861c1def70f06
Message-Id: <155744011772.23477.12754028248628964733.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 22:15:17 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  9 May 2019 14:15:10 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea5aee6d97fd2d4499b1eebc233861c1def70f06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
