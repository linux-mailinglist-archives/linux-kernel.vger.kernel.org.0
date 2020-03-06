Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE917C75F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 21:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCFUzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 15:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFUzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:55:06 -0500
Subject: Re: [GIT PULL] arm64 fixes for -rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583528106;
        bh=mVBXtZ7m4qGrI0tw4H8tDeDwn8YJqRyDIflDA4DNpVI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aZyV9NGtxLsX+ksK/ggee+zZPfO2+N4KxBEEYmwnvrdHR22Gl0FaxAEvDp6OFB4Qz
         lroy5yI1ywMyRE/6L4hbTo43wUMXRsASmLXPatv4f8/2VFAhGNB9k7V57iCdmiesze
         1CQMOroMFVIyjt1suDF3Kx8j82NbjKsdYjyMRdGs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200306151219.GA8409@willie-the-truck>
References: <20200306151219.GA8409@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200306151219.GA8409@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 9abd515a6e4a5c58c6eb4d04110430325eb5f5ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c20c4a084a878df35a7e394a7e646f303b505eaf
Message-Id: <158352810621.1815.11142669191874815567.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 20:55:06 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, catalin.marinas@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Mar 2020 15:12:20 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c20c4a084a878df35a7e394a7e646f303b505eaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
