Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50284951AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 01:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfHSXfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 19:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbfHSXfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:35:09 -0400
Subject: Re: [GIT PULL] clk fixes for v5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566257708;
        bh=SQS5aHHw3B5SB7BrUZn9rqctdeYIpVeDZXgkvvB8E2w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mrD3FyZy4b1lQo57lj5IJsVXWxKCS2C8H5EWYVg5c5rFQozKcnLxQyMJbCudcGzph
         dh6Xu1n6+j+kEELbBlMw1hSpz/vCtHGVNrAmjQCPM/TPEr05FDd9XUe4DIaDeVHblY
         uJI/NF0HYobPwCDevOarmi426u26acP81GENzNH8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190819223635.59566-1-sboyd@kernel.org>
References: <20190819223635.59566-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190819223635.59566-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 24876f09a7dfe36a82f53d304d8c1bceb3257a0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f97cbe22b7616ead7ae267c29cad73bc1444811
Message-Id: <156625770845.9031.12350958931590253397.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Aug 2019 23:35:08 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 19 Aug 2019 15:36:35 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f97cbe22b7616ead7ae267c29cad73bc1444811

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
