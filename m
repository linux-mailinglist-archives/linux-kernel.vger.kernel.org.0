Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D848194AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 23:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfEIVfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 17:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfEIVfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:35:14 -0400
Subject: Re: [GIT PULL] workqueue changes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557437713;
        bh=2zH+4E7qk4MgSH+7RTIqq2Eu2mdIFeKH+GaadP/c/A4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e1JvOMqRURJDImYKVKljeAin/jYkqLMmyM5DQ9R/Gq3YF+Nn7v87qOym5Zz7Hg1q1
         G6Htstd8cA5M9y7wIah2wDRwCTxApHRPgJtrD11OpcOF1FyBYM3IQ5DWxLxSWEZ3iW
         7HtYoOFOOjqGTkylPx+RGXmY02ntVe0YCOR5/3LU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190509172721.GZ374014@devbig004.ftw2.facebook.com>
References: <20190509172721.GZ374014@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190509172721.GZ374014@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
 for-5.2
X-PR-Tracked-Commit-Id: 24acfb71822566e4d469b4992a7b3b9f873e0083
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23c970608a0931b913f96f6117ea3e9e1bc06959
Message-Id: <155743771339.19196.9649110069124447269.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 21:35:13 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 May 2019 10:27:21 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23c970608a0931b913f96f6117ea3e9e1bc06959

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
