Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 481D78031E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 01:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437444AbfHBXUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 19:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388599AbfHBXUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:20:02 -0400
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564788001;
        bh=w7pLLNi5wooNeDeJ/x3nTG9XxghUGlex9IME0/qMU04=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xolDVK0+9DslIG3/7r77C+chHLfLf6LUTYtKDXdgLEOXKXyzlMVABJWFfogyRSBmx
         P191Ne3tSBeRe60f/9LfuIQYRqEcSZnJtpIo91p9PWKppk24XA1MDTdcrwA23hIGxw
         /Uf0okfpfoi5it4dLX6/9CzJbEbU0rNtJNgRD2SI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190802160447.GA27285@ls3530.fritz.box>
References: <20190802160447.GA27285@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190802160447.GA27285@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.3-4
X-PR-Tracked-Commit-Id: f2c5ed0dd5004c2cff5c0e3d430a107576fcc17f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9100fc5ae83e64d99fd3300104893ef0e0b0aadb
Message-Id: <156478800176.22769.2117525589731444415.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 23:20:01 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Aug 2019 18:04:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.3-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9100fc5ae83e64d99fd3300104893ef0e0b0aadb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
