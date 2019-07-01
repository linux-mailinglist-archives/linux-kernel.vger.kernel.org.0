Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCE416BC3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 21:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEGTzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 15:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfEGTzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:55:13 -0400
Subject: Re: [GIT PULL] compiler-based variable-init updates for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557258913;
        bh=shDG5cdmfWIUFWYKFFCojpOQEFlXtI/tyxF9CtxW9eU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ng6H7NAMs1OVzuAtYTNthTMndRFHDUbDi8XVB1OOzRwDc0yhCaHnmll/Gp2rpUiVV
         fO6nb0/exgSaZOjG1d+yHLJNSe2tuXdd0OwZEUQxEqm7ww9+bDJCqcdutP9eMlMRvm
         sAXLS4PDypZ1/sFbJ29t2YMVAs0gay9VPAPcwgEs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506172139.GA2121@beast>
References: <20190506172139.GA2121@beast>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506172139.GA2121@beast>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/meminit-v5.2-rc1
X-PR-Tracked-Commit-Id: 709a972efb01efaeb97cad1adc87fe400119c8ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d60d96b6f00de90ec2bc60eb4cdcc46e1e1f161
Message-Id: <155725891298.4809.10913706277736888210.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 19:55:12 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Alexander Potapenko <glider@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 10:21:39 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/meminit-v5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d60d96b6f00de90ec2bc60eb4cdcc46e1e1f161

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
