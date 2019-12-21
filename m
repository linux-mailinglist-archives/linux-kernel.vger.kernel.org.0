Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55336128B76
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 21:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLUUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 15:20:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfLUUUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 15:20:10 -0500
Subject: Re: [GIT PULL] s390 updates for 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576959609;
        bh=QwYZc6ehQHBlSjArD4PkxDCKRQgNYnk0+54I+uASoeo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Iw/PqQhDDPKyu/Nelsso9wBgy7+K0SIFCRSSvZh1agb7s70PNY0qRf7m+Lgefma/8
         QMlp6J41ou/xXTnC9S/flVBci5KEoflCLux1qLcAOnr35VN02pZIoQ33/LTXjxmCNt
         OlHtTphqAfQDO9j6eBjMI+geyyDpUanNlPeqWnng=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01576957972-ext-6011@work.hours>
References: <your-ad-here.call-01576957972-ext-6011@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01576957972-ext-6011@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-4
X-PR-Tracked-Commit-Id: b4adfe55915d8363e244e42386d69567db1719b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60b04df6bfbf7e65954c44f7945b381e0fee5b6a
Message-Id: <157695960957.315.3541305310902676791.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 20:20:09 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 20:52:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60b04df6bfbf7e65954c44f7945b381e0fee5b6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
