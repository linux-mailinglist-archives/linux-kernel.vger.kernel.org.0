Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02393195D94
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 19:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgC0SZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 14:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgC0SZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:25:09 -0400
Subject: Re: [GIT PULL] Last Minute RISC-V Patches for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585333508;
        bh=XTyR3Ei+Ij4JCQvNeDFqRnPcP7UXYvEQrZ95s+WjTvY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ioKWNL71SlNMvYZM4fV+jwCXfxtvtou0Ty9l2flF8R+niCtuSqIBWGZKohAtdacHZ
         sXwgTaphDgdhjA0kzE9p0PqfPjIK2baHk9NOeekGgZFH1QkKvlE4jZdXIE+PU/hTJ9
         Ryuwk/DO05lCApLf1fnfImtnT3epKQrY6nSA3JUE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-06e46f55-fd4f-48ab-b741-cf487976999b@palmerdabbelt-glaptop1>
References: <mhng-06e46f55-fd4f-48ab-b741-cf487976999b@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-06e46f55-fd4f-48ab-b741-cf487976999b@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.6
X-PR-Tracked-Commit-Id: 2191b4f298fa360f2d1d967c2c7db565bea2c32e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 823846c3107197b6eae9fb656a23e986926d6c07
Message-Id: <158533350869.5176.11624956760593190651.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Mar 2020 18:25:08 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Mar 2020 10:53:16 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/823846c3107197b6eae9fb656a23e986926d6c07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
