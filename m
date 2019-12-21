Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B71289B0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 15:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfLUOzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 09:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfLUOzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 09:55:10 -0500
Subject: Re: [GIT PULL] RAS urgent for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576940110;
        bh=u8CDUNzDgMTp/SWwSZtsDLgue3QbujT3BLDjPLsfRA8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aG+5UrEu0NK2e5PnTpDnfiFUpSXpncsHVsFcXByBPHz84eTDQV4Cbn3de+G3cEM/d
         if3xIIXMZ7SwGEfeeksLD64IdsTmk3/q5pm/wiIPLMmMFNjSp5N0LwWm2FzQWylmW4
         1NJ98gsUzJbUDImYj9+z15DgCp73yrg7EJCi6n40=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191221092353.GA5832@zn.tnic>
References: <20191221092353.GA5832@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191221092353.GA5832@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 ras-urgent-for-linus
X-PR-Tracked-Commit-Id: a3a57ddad061acc90bef39635caf2b2330ce8f21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c741e2583d2e5a3fc148a5e8a2464bbaa45a1d9
Message-Id: <157694011020.20544.721352944173405169.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 14:55:10 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 10:23:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c741e2583d2e5a3fc148a5e8a2464bbaa45a1d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
