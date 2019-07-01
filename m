Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2863315773
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 03:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEGBzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 21:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEGBzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 21:55:04 -0400
Subject: Re: [GIT PULL] x86/microcode updates for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557194104;
        bh=CYfCmHSZzFVYGBIXhTb5lUeclEr75mItXtYYpZJim1I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n+HxnRn80UryPLqzydJNnEEWyVwSLZONmxNbwe77gQmgsSoSi1IOSY2URNMQjW0mH
         KlnIo5t6c7eoeoOt/lmVYqaZzIoXWd2jMO4ZcycH/ND23pTRJDfLsN898LRqbe5Iz8
         N8R07Uuc8yHIP7sKjPnj0XBv4Vfd9J4ZWz3++xus=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506090632.GC6094@zn.tnic>
References: <20190506090632.GC6094@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506090632.GC6094@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-microcode-for-linus
X-PR-Tracked-Commit-Id: c02f48e070bde326f55bd94544ca82291f7396e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdafe5d1ffe8021704cb389e9823aef4235c88bc
Message-Id: <155719410426.3542.13624753133902263777.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 01:55:04 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 11:06:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdafe5d1ffe8021704cb389e9823aef4235c88bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
