Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B824A661E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 00:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfGKWpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 18:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbfGKWpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:45:14 -0400
Subject: Re: [GIT PULL] USB patches for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562885114;
        bh=wW2Z7vKv9HPPU5zCgp4XZDJAfOe9il/iGcygteq0wBQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y3RZyZYKYS0HgOVpxRmIrJS9q7Yf/xZE6f6aMB87aSoWsWLZZQq7xOkkbIcJnMspj
         +o9LNm0dXvUHZllgyVTS8lLoB5mqu1m7TWAgpG4vTzFYVhgWlgeLkrg7y5eUa53hhN
         OHaD3nkDMwoRgPAB6gQHHh7mHM9KA9n1q88OoFDE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190710133309.GA24176@kroah.com>
References: <20190710133309.GA24176@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190710133309.GA24176@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc1
X-PR-Tracked-Commit-Id: 2bc8bb813cba6e699b29fd0b30720288866a5e5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17a20acaf171124017f43bc70bb4d7ca88070659
Message-Id: <156288511458.25905.16581854341300927500.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 22:45:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jul 2019 15:33:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17a20acaf171124017f43bc70bb4d7ca88070659

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
