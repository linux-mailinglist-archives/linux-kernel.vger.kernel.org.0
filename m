Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B409E14D0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 20:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgA2TAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 14:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbgA2TAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:00:08 -0500
Subject: Re: [GIT PULL] USB/Thunderbolt/PHY patches for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324407;
        bh=HRB9LqfOt7GeWZ0zpGOOtOJpUkWMM9HV6LarHXJRwTs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Mo7r49PRzsnt389JlzjHAD35GxMlAuJJk0wE4zuCmxmzY3sMz1M7O3L1J/t9PciT/
         yKZ09ug5ze5GU7pxLdXHpgMn4wLjLO8H7WKC/GpJb+4/vUp03hJH37pnC3MOeofQT0
         dnhlkvYzGVci3EIXmbCaD6Eeg13FOnx903jbWXek=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129101401.GA3858221@kroah.com>
References: <20200129101401.GA3858221@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129101401.GA3858221@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.6-rc1
X-PR-Tracked-Commit-Id: eaa519983fd9e53c2a62a1e56777e1fb461865a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aac96626713fe167c672f9a008be0f514aa3e237
Message-Id: <158032440778.15518.10591037871300430837.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 19:00:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 11:14:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aac96626713fe167c672f9a008be0f514aa3e237

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
