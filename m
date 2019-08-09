Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0BE86F5B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 03:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405363AbfHIBaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 21:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbfHIBaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 21:30:07 -0400
Subject: Re: [GIT PULL] SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565314206;
        bh=r2IPMb9ebGaBjk0RJPDXjLHGFn06GJGZwOdoUJZhmc0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e4ocOAb0ToqGxlVEPJSqr4mUMkNML1qrjbhfpyQwEKAHWbzPG/6LF0PE9Rb2voRvi
         OZ9hdoBQ27ZZQaoXg7HDcpRIUbaxCoAO9QCESw0QLMgVZ3tCbtU0KTQFlhL/PfN+M1
         HmCg3CoalJIw8b03oklrHSNZZL7Zv7attT0Abuag=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms07ipgU=g7pT_YpNmXQ_rW8KG0buFv=pag46V9qCX01Q@mail.gmail.com>
References: <CAH2r5ms07ipgU=g7pT_YpNmXQ_rW8KG0buFv=pag46V9qCX01Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms07ipgU=g7pT_YpNmXQ_rW8KG0buFv=pag46V9qCX01Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.3-rc3-smb3-fixes
X-PR-Tracked-Commit-Id: ee9d66182392695535cc9fccfcb40c16f72de2a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 518a1c2f091290219783d5624284c140544a261e
Message-Id: <156531420637.8489.323128163122141743.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 01:30:06 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 8 Aug 2019 01:49:01 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.3-rc3-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/518a1c2f091290219783d5624284c140544a261e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
