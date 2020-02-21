Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D092316890C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 22:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgBUVK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 16:10:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbgBUVKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:10:22 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582319422;
        bh=P9heDIhwv2+wo6i8+/0iv17UoNqLsqod/MGBhTrR0WI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Rq/Gf+jT7ONoOugpoA6VCWPXItFjZ7GRT74jlnlKubBtMi5F0YRhG2tERgf7s84Yz
         cXv1dBFtqfeNPF62Q1pkcYoewnpNI/LS/tYMWjfzgh/bs0FRaoJ78izLxlU5aiA8Xr
         KaBn3mrjAlCOcWTtBGM1WB8z8GhnXuHMl4GVgDSc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200221114012.GA114392@kroah.com>
References: <20200221114012.GA114392@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200221114012.GA114392@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.6-rc3
X-PR-Tracked-Commit-Id: 74ba569a15a08b988bc059ad515980f51e85be79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb65619e97323b8d62dd4d7549b9b7fe8a774706
Message-Id: <158231942249.18249.15250078843801513593.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Feb 2020 21:10:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 12:40:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb65619e97323b8d62dd4d7549b9b7fe8a774706

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
