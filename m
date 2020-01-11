Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39E9713819E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 15:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgAKOp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 09:45:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbgAKOpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:08 -0500
Subject: Re: [GIT PULL] Staging driver fixes for 5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753907;
        bh=ByR+t05E/l5nFWAcppZgi9graZyANoJrvaM0FBlEuq8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SPrUVdYpaNAcFCiD0yH4Ub95CvLXCYq2fi2HZHGoYmn1rzH52MwdzesD1P2tgx/m4
         EaK07eVT2u/VfamUJKs0vaImOQ1OL/W95BOAzRQGBi807/LcJ0sCGckqN3hS6+RyKR
         A/cBLhmOiy/aS2XldznWbldXRaupLv8JfqaF52qw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200110210850.GA1871133@kroah.com>
References: <20200110210850.GA1871133@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200110210850.GA1871133@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.5-rc6
X-PR-Tracked-Commit-Id: 58dcc5bf4030cab548d5c98cd4cd3632a5444d5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7da37cd0520e71707a1190022377941b9cec3b0b
Message-Id: <157875390793.30634.15633946766372116355.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 22:08:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7da37cd0520e71707a1190022377941b9cec3b0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
