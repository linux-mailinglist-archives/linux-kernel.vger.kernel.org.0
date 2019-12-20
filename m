Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230701283F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 22:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfLTVkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 16:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbfLTVkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:40:11 -0500
Subject: Re: [GIT PULL] arm64 fixes for 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576878010;
        bh=ds60W/4bN53y4yP49NRUS0ID15urrsKn8ZPE8vCr0w4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WVyqJbKEzw0YncW2dPqaMhyctOd8mYnT78BDlBKjLfTz5AnwGw+Dv+j9oVB1v7YCu
         0SpOrY+OK3RpJ2S+QSICPcMxSfdxgoUapyO7ClfAuO7PH+NcotsrjUsyEZFQLSkLWh
         fi+idsO4XBis6r8Z5WRIiIEy5NPVKG4pD955DpBk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191220181456.GA13898@arrakis.emea.arm.com>
References: <20191220181456.GA13898@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191220181456.GA13898@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: aa638cfe3e7358122a15cb1d295b622aae69e006
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3939f2c8665721eef8315f42d4c57fb1272aacd6
Message-Id: <157687801076.11927.15792354963076329227.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Dec 2019 21:40:10 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Dec 2019 18:14:58 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3939f2c8665721eef8315f42d4c57fb1272aacd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
