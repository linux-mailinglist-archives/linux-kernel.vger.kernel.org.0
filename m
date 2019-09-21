Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D46B9F1B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 19:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfIURKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 13:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfIURKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:10:23 -0400
Subject: Re: [GIT PULL] gcc-plugins update for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569085823;
        bh=X3ChYO6Yy8BrnxGAHIzP9TnfaZ+Db/XODFDKYpDbltY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wD6JIiWgfbYplorDYtonOLCOJ3CAjzVd9NsbCZv5w5ZVWTaGgkEG8RQJDGVHWB5dw
         olsZgwXeM2ij+TKJ1V3qJiQUq75U0GYmByGxpkTPTkFRcUux59x4ioAf99GvX9PXp2
         u3+4yDFgQbTaWs3dcCzE0+dbv0qy7c+4RQMB9+0I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <201909161443.8AB608118@keescook>
References: <201909161443.8AB608118@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <201909161443.8AB608118@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/gcc-plugins-v5.4-rc1
X-PR-Tracked-Commit-Id: 60f2c82ed20bde57c362e66f796cf9e0e38a6dbb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56c631f5aec35117b0b5862a09a447a72dfbd678
Message-Id: <156908582306.8665.1441954801716173630.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 17:10:23 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonwon Kang <kjw1627@gmail.com>,
        Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 14:44:54 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56c631f5aec35117b0b5862a09a447a72dfbd678

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
