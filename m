Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAC610B6C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 20:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfK0TaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 14:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbfK0TaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:30:15 -0500
Subject: Re: [GIT PULL] USB patches for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574883014;
        bh=HFzDpYBqwM1W3YW9Bs9iAzDMOU5jliYDarxxZcTu4JE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ezt6vrLAVcCgkUVSwi3vdwD4bhBOma01h9ZZj2fNqzHh7FIdLni25U2xfIpfjNqK+
         AXufTKRZRhwQHDCx3HxtNY5axzp1ZYgzsQpP7LK1Q4UStV3OeaB8QfpjdaR0Tqp2rh
         tz2OoHCr0/B+luXXRTn5M+2ytkX74/zL3Nr72izI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191127160338.GA3032225@kroah.com>
References: <20191127160338.GA3032225@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191127160338.GA3032225@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc1
X-PR-Tracked-Commit-Id: 91a9f2d3f9762e59cca251d2c6cef8cda1a4e62b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59274c7164807d27b24e6c068dfe734f7bea4623
Message-Id: <157488301460.32229.14515015033470207938.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 19:30:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 17:03:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59274c7164807d27b24e6c068dfe734f7bea4623

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
