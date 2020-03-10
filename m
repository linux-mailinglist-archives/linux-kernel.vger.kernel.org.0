Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2EB180BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 23:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgCJWkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 18:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgCJWkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:40:07 -0400
Subject: Re: [GIT PULL] clang-format for v5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583880006;
        bh=bv1LOEIUMDk94xJUo/qvqrgc8WpmpthHl23CoRZlaw8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FZHYtwqy8RpJublvJg6ueYbhlQ/HmxpXiP9obQjxh4hA1uJFD7IZZ/bMIrsQ000el
         0NPH8fqIRMeCX2pTmOg7ffbDcew6uPifSRZ7cyJUlOr3gQZIoqCGu0ZNTXbWxbA7hf
         mR4VhDrOtBBh4QK8bGK2PTrc6ef5Bw9zG4BzOvng=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200310161556.GA17087@gmail.com>
References: <20200310161556.GA17087@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200310161556.GA17087@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/clang-format-for-linus-v5.6-rc6
X-PR-Tracked-Commit-Id: 11a4a8f73b3ce71b32f36e9f1655f6ddf8f1732b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f35111a946548e3b34a55abbad3e9bacce6cb10f
Message-Id: <158388000665.13098.2125659062438326403.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Mar 2020 22:40:06 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Mar 2020 17:15:56 +0100:

> https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f35111a946548e3b34a55abbad3e9bacce6cb10f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
