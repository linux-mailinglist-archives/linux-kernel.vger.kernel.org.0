Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456E210F1DA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 22:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLBVFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 16:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfLBVFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:05:16 -0500
Subject: Re: [GIT PULL] pstore update for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575320715;
        bh=Kj1g726HecPOIiPOw8JvebP/pnyfgdsbxeh5d+BmVS0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q1sDsfXEjzO5PJHenCUWVKhpWYh4Tsm80deSyT8pakpap4G6CHOercpDvVsFhuKrY
         IqrCE4IcWjQtsvAtY07R0+Oy/cpEq2IsKztg3Rapnaqa44PWWR1xiyvPC+iRxseSgI
         jn7gCn+zA+xBeQsXvnqP8k3iy9pirBNo3/rlIjyM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <201911260828.9090F0A258@keescook>
References: <201911260828.9090F0A258@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <201911260828.9090F0A258@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/pstore-v5.5-rc1
X-PR-Tracked-Commit-Id: 8d82cee2f8aa8b9bc806907ecd9e1494c6e8526b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8328dd2f394e48a010383af176bf55ba4be79da0
Message-Id: <157532071578.29263.908305914414287305.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 21:05:15 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 08:29:02 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8328dd2f394e48a010383af176bf55ba4be79da0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
