Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61C64EDC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfFURZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 13:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfFURZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:25:06 -0400
Subject: Re: [GIT PULL] USB fixes for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561137906;
        bh=cVr8RHH4fR79XsiW4yOcmmrwTj7oE+uYrLd/XHiv70U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b7MMVpKYqf2JqwsXgPBnIUHRtEQM2ueUC1RQ15c02GoHVwYSHP0WC3H67GmJT7Kr4
         3R1BHx8ipWTUsPbmJQyHvJavULBflFuxrLfG9appHbUw3XmdZMinzF9y3LwHHvLtN2
         ZHOqhOdJT8cjxTPfhi5L5Z/5sHo/czA1B/01DX84=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190621081026.GA27919@kroah.com>
References: <20190621081026.GA27919@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190621081026.GA27919@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.2-rc6
X-PR-Tracked-Commit-Id: d28bdaff5e260852621d45edd3af017cc5d16925
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf24242189b935826a88feedb64761cbf483e42c
Message-Id: <156113790614.2072.16145479994062048162.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jun 2019 17:25:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jun 2019 10:10:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf24242189b935826a88feedb64761cbf483e42c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
