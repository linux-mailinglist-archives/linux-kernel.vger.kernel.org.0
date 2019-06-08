Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D213A1DD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 22:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfFHUKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 16:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbfFHUKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 16:10:11 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560024611;
        bh=QQ1iVwBjeIm+vAcirwq90EkTHiLTQWJWs9DJYiuhZtU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l+1AULJf3aFND7tXYzoAvZnDCtjqbaWCwwhuxfReERr3lNq4vzdj4/h3pYfuGf0+J
         4uvF2qlxWlYbEDkhtCaApGZ3S/cVDaB9AyLLOrKy7smzeJT8uBUoR/JUSz2TuDP3j8
         7ykqm384x7O3pvWhvJxaOKr732lVXRXs+1kyy0Ko=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190608095822.GA27625@kroah.com>
References: <20190608095822.GA27625@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190608095822.GA27625@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 char-misc-5.2-rc4
X-PR-Tracked-Commit-Id: e7bf2ce837475445bfd44ac1193ced0684a70d96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ce2c85137b1db5b0e4158d558cb93dcff7674df
Message-Id: <156002461104.1563.16017256855090505340.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jun 2019 20:10:11 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Jun 2019 11:58:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ce2c85137b1db5b0e4158d558cb93dcff7674df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
