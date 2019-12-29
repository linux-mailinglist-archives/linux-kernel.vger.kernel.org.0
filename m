Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 130F312CAA7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Dec 2019 20:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfL2TfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Dec 2019 14:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfL2TfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 14:35:07 -0500
Subject: Re: [GIT PULL] SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577648106;
        bh=VA2PNe7EHtMwnyNTfXbhD2csLpbuw+O4ePPjAc9+z2M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m3VMUc/42fVuF9HjSmy+MD6ZBh8YD7HzXf8M4S5V9Zv0LCHCDjyUgpKE8Y6/CN8t0
         U6rW6kHfBtRe2gNLTW+iVXCHpjiGiDo8VsCno20rJ9bvvyB2FseNF28aU8UwPIycUT
         TW6Q5gWJrR+gsSH/jF4GdL/ggtd3ktsS0pWLuGFU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvWwwSA70MnKBZXm_ji9iT+DxVPu-33EcFb9L+GgEwcXA@mail.gmail.com>
References: <CAH2r5mvWwwSA70MnKBZXm_ji9iT+DxVPu-33EcFb9L+GgEwcXA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvWwwSA70MnKBZXm_ji9iT+DxVPu-33EcFb9L+GgEwcXA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.5-rc3-smb3-fixes
X-PR-Tracked-Commit-Id: 046aca3c25fd28da591f59a2dc1a01848e81e0b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc2f36ec7188e48c2afb1428fc3ce18884ad634b
Message-Id: <157764810649.31581.368065453512872010.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Dec 2019 19:35:06 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Dec 2019 23:06:35 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.5-rc3-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc2f36ec7188e48c2afb1428fc3ce18884ad634b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
