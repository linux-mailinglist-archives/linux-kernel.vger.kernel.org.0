Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA643A1EF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfFHUUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 16:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbfFHUUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 16:20:16 -0400
Subject: Re: [GIT PULL] s390 updates for 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560025215;
        bh=KqDMxCT33A9zxNGxdVdLD8Dtx5IK/QOuXPGvZz6/TSg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pbD2Pwwry1bVyKGZb/Q/qY0dxhWsZ4QGBPavmrbuTU2+G65O0qnE9Qgf0njPuam5o
         +/ogKROO416p+32+H7fKnUl6Lxd662IH2k5JICR/i3NuBIbWE52wEt9afOZm45ifq/
         xOW1RoQf+JvUs6UUrzfm5J5mHKEMu2YPJJnYB7F8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190608112151.GA8766@osiris>
References: <20190608112151.GA8766@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190608112151.GA8766@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.2-4
X-PR-Tracked-Commit-Id: 0ab0d7ac2090eae30f1c0b01ae981bb7a368f598
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d4645bf7a76886c70a482a1c6742bac98553f47
Message-Id: <156002521594.8142.8606005701533653185.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jun 2019 20:20:15 +0000
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Jun 2019 13:21:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.2-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d4645bf7a76886c70a482a1c6742bac98553f47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
