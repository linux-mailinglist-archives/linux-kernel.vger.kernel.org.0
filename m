Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E6711064A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 22:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfLCVFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 16:05:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfLCVFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:05:22 -0500
Subject: Re: [GIT PULL] s390 patches for the 5.5 merge window #2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575407121;
        bh=AlwLDPItj/QAwn+eT1jJUm7hNUdk601hVz1T2nPvZVo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qam6KeR3isIQQIm2wV5ENZ0xN/7towfuAig2DwzLOQL0C/h6eyYN+sF/+HFmB7AX3
         v9qD9kvgP55oqPG0LYhJCuU7gnue3FQyZ4LL9qoJMOQLflQAMED39A3WzLJN5nWiZD
         4urscaMPQBypDkANZWo8UbOYIHexT43FZ3ISj4Mo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01575376349-ext-1325@work.hours>
References: <your-ad-here.call-01575376349-ext-1325@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01575376349-ext-1325@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
 tags/s390-5.5-2
X-PR-Tracked-Commit-Id: 2115fbf7210bd053ba55a95e7ebc366df41aa9cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01d1dff64662646023482806c6db8ef0b280c403
Message-Id: <157540712144.31207.5722570862214097444.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 21:05:21 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 3 Dec 2019 13:32:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01d1dff64662646023482806c6db8ef0b280c403

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
