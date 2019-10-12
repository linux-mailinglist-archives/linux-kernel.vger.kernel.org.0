Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC934D532A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 00:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfJLWzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 18:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbfJLWzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:55:06 -0400
Subject: Re: [GIT PULL] USB fixes for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570920905;
        bh=rNZPRkCkuOjFkyDRZWT924omIyghGSOicle0spV96d4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=li2BBkhensSMFx9AwZdoSMN6PF2bXnw9Er0u88T1mlfFtKojriZo4EUWc2kWVaOdy
         3N7dSA/E7HlvtCzaMMu+ynFIPuUU0bUaRvF8aSNoa0Gc8t2P+7FzQISk1HBGXYfG/0
         aSbxystdfnb1jS6Ssa/ERTjrCxtOpyqRvZHDbAwc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012161553.GA2191565@kroah.com>
References: <20191012161553.GA2191565@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012161553.GA2191565@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.4-rc3
X-PR-Tracked-Commit-Id: aafb00a977cf7d81821f7c9d12e04c558c22dc3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c90bbd0a4e133665128a941ffcb4f7ac5dcb3cf
Message-Id: <157092090586.32460.6340268885427798293.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 22:55:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 18:15:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c90bbd0a4e133665128a941ffcb4f7ac5dcb3cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
