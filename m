Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F114B31652
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 22:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfEaUzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 16:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfEaUzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:55:14 -0400
Subject: Re: [GIT PULL] SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559336114;
        bh=W0Pdxvg7LRWYomnlBfhyOP7Wa9SKZbTdwsLyl/SmF6Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=avyRfxWmqQO/GeiJmaYJThRAq+a6FM9mnZjw3LX/eERQt00zEuSFV576y/x9HY0JN
         e3VXaxkG7w7YzG+wcLk4+8UEFAO7QSXqJmcO0T7F+F6fexbUj8zdZxC5HA9NqRYqc3
         V9S00Emw43Ksohkbb8wmtAhfEbGEFLHssmDqzOzI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms=pUiZQPmX_-AoUceAWgr4Y5RwrkLC0o8dyfcMSKpuCQ@mail.gmail.com>
References: <CAH2r5ms=pUiZQPmX_-AoUceAWgr4Y5RwrkLC0o8dyfcMSKpuCQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms=pUiZQPmX_-AoUceAWgr4Y5RwrkLC0o8dyfcMSKpuCQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/v5.2-rc2-smb3-fixes
X-PR-Tracked-Commit-Id: 31fad7d41e73731f05b8053d17078638cf850fa6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41e7231fab9d76e906b6d8abe09c44c7b9656d33
Message-Id: <155933611418.3628.18268123204511844583.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 20:55:14 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 May 2019 12:55:21 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/v5.2-rc2-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41e7231fab9d76e906b6d8abe09c44c7b9656d33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
