Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C649DD532C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 00:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfJLWzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 18:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbfJLWzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:55:07 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570920907;
        bh=u+doTc6OM9epBZQrCdytDLxl3Jg9h1sfIdZh8kaQBH0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VI6Nc6OxtesV1h/tjZsJUbFyLVum2O/7zAq6AbF8jo2L3rvrEyq4fi2tV/KhWNopu
         V0m69MD6p1E4l4SBuPFBIaHDIOZP2DTGNuEjdfIMVOfME6uAF1cp3yLC/++jATxWwY
         K50cYxLBG/HkcFU/0eJF1cc1HJOFVxT79LiIjqJ8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012161659.GA2191759@kroah.com>
References: <20191012161659.GA2191759@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012161659.GA2191759@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.4-rc3
X-PR-Tracked-Commit-Id: 442f1e746e8187b9deb1590176f6b0ff19686b11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da94001239cceb93c132a31928d6ddc4214862d5
Message-Id: <157092090706.32460.15767091072232282005.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 22:55:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 18:16:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da94001239cceb93c132a31928d6ddc4214862d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
