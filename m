Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4CC5E5F9A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 22:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfJZUpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 16:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfJZUpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:45:07 -0400
Subject: Re: [GIT PULL] Staging driver fix for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572122707;
        bh=JVTgCyPoVOUlh4N4Okl+tzFVT6WSHel3b/WSRpwlhxQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vihVj8Wgw4V3zfkkYgZwHWNv4Yel4y9aAx7C+dqczRiPQ5RbilAKWzIieRdeaKyp+
         2Abi1oguAmY94kX862onhFuINZZGbbdLXhn7AG5hoDzVvvYfwlO30Zo7qm1AKsh4pJ
         x7yE8cbrzsi1dhHLCpEIss311JpBLlV1okQenloc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191026181839.GA649095@kroah.com>
References: <20191026181839.GA649095@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191026181839.GA649095@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.4-rc5
X-PR-Tracked-Commit-Id: 153c5d8191c26165dbbd2646448ca7207f7796d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 228bd6243447f3e5613457e6400112f197dbba7b
Message-Id: <157212270736.6077.14578368699754465120.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Oct 2019 20:45:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Oct 2019 20:18:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/228bd6243447f3e5613457e6400112f197dbba7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
