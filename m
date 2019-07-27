Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0351377B22
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 20:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbfG0SkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 14:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387880AbfG0SkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 14:40:17 -0400
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564252817;
        bh=4t2A3dkbiVlhY88T5TC9JqJZoqsyGH+n/u1o+AaMA9Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PsIfnepeO3GPCC56UL/wNTysGT9nMNmj6eCBF1X1fCorMOZF5quaXCuaHJwhOgM1X
         qvERQFrPrLeQULXKYApdDNXq5K4Anbp/DyzEIAvCGUNlInLHwntRNuKNQZTu5zF1vV
         BxMwGFfyd+ZoNyxAurzheQzzDPkOQBVSz7PSfjeU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190726025521.GA1824@embeddedor>
References: <20190726025521.GA1824@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190726025521.GA1824@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
 tags/Wimplicit-fallthrough-5.3-rc2
X-PR-Tracked-Commit-Id: a035d552a93bb9ef6048733bb9f2a0dc857ff869
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88c5083442454e5e8a505b11fa16f32d2879651e
Message-Id: <156425281714.14163.13456907499809088307.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jul 2019 18:40:17 +0000
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Jul 2019 21:55:21 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88c5083442454e5e8a505b11fa16f32d2879651e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
