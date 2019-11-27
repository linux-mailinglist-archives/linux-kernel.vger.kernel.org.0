Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7DF10B6C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 20:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfK0TaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 14:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:47684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbfK0TaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:30:16 -0500
Subject: Re: [GIT PULL] Char/Misc driver patches for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574883015;
        bh=icI5e003TTv9JXUYORcXIGUadw20DDrwcZ00MlMPKLc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ndZSj05XArFH0eA7xQw7ey/Ql8RIFSE9klrQz0eJ4d3330wH4Yi2OaOiQ3qz4tvJM
         TYYkwzLEOQ1AAlZ9BrMB/UPh1WYhR9dCvQl785OwW1WsR659l4tTPQdLUlsbRTgZCg
         XHeZHeyaLcXxoytSODOylfmvGRQ2IB1T+xAL/sE8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191127163053.GA3086750@kroah.com>
References: <20191127163053.GA3086750@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191127163053.GA3086750@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.5-rc1
X-PR-Tracked-Commit-Id: b78cda795ac83333293f1bfa3165572a47e550c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f56e4ebe05c26c30e167519273843476e39e244
Message-Id: <157488301590.32229.9515128491779582634.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 19:30:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 17:30:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f56e4ebe05c26c30e167519273843476e39e244

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
