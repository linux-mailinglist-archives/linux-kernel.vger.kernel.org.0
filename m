Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD712FCF7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 20:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgACTZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 14:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbgACTZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:25:09 -0500
Subject: Re: [GIT PULL] thread fixes v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578079509;
        bh=KFQMNBy6dcIbaTqRS4BQFJ8OL5/oKzMURmNwFNfPqS4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JWYPH0ttH3kQidBjygEa+fpZ7XHb2WA8RjuhiSk3EXXyr94tJ0yyEPBBk6oxi+sk7
         h10ka4PKI8Z5wmauCccQuBPCOwsKozoBzgjlptmJcZ+g0px3Mgk3UF14zLyk3IZjE9
         ziLFoOrVFmIPJSXVp2GbPlmY4+TnBiwq6kwZElfE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200103135303.19470-1-christian.brauner@ubuntu.com>
References: <20200103135303.19470-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200103135303.19470-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2020-01-03
X-PR-Tracked-Commit-Id: 43cf75d96409a20ef06b756877a2e72b10a026fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9c82fd8c89766f2cf1e667f663e8e8c25c12aee
Message-Id: <157807950919.16643.13900877990452455562.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 19:25:09 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  3 Jan 2020 14:53:03 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-01-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9c82fd8c89766f2cf1e667f663e8e8c25c12aee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
