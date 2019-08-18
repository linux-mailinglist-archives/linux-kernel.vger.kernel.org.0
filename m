Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 790D4917EA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 18:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfHRQzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 12:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:55:07 -0400
Subject: Re: [GIT PULL] USB fixes for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566147306;
        bh=PkfNAouq6ycRz61vC3rveUOxYFDama50+jBdAyrpdr0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iPwRikkSWkMYvBHT5c47xZhAahNL14p1AE8S6rnlCgMjTHF3cONM2Z1Bm9Y3zfcVz
         l7HtdfX52Q+JBhriIRzAuw0aldH70AtgRMUaXTmxFMKcaEDL+vkScqXCB7aUhOnaS2
         8tzPlo8YA2kzkQQ9h2WeLg5fqpeFoH45Rz6ANTIs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190818085624.GA28589@kroah.com>
References: <20190818085624.GA28589@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190818085624.GA28589@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc5
X-PR-Tracked-Commit-Id: 6a5f43d1d8bd3779e428178438caf33f60427124
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 359334caf777854fc0647c610f4c34be5eaeb3ca
Message-Id: <156614730629.21549.11044540914517402297.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Aug 2019 16:55:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Aug 2019 10:56:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/359334caf777854fc0647c610f4c34be5eaeb3ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
