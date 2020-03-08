Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A023617D488
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 16:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCHPzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 11:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCHPzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 11:55:05 -0400
Subject: Re: [GIT PULL] USB/PHY fixes for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583682905;
        bh=7c0RQWpB6504azPx4KDuMJ4vfb1FqyAmFVn678/Cwgc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hDOfPLEdL/nettnqhD1GqNQs8MHNCn+vvpj1T8UyucXr9zS9p1SxWTJK9pu5nnfSo
         V9y4e5p/5ybmf0rNFN5bcgf9jyu7sGqSgWqu6Z2cENHQvTYPGFnGuRGNliml2R996z
         2YQFtcl6fY6Qt0vetN1xljrkHDQqUJuJqe7QAnaY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200308095118.GA4026918@kroah.com>
References: <20200308095118.GA4026918@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200308095118.GA4026918@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.6-rc5
X-PR-Tracked-Commit-Id: 19f3c1e98bd1704fe22e5f8105c0677a1332cdef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd3f6cc9806c2f10b886f3ad78c9e192fb1bffd9
Message-Id: <158368290527.12496.3475367871442185658.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Mar 2020 15:55:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Mar 2020 10:51:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd3f6cc9806c2f10b886f3ad78c9e192fb1bffd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
