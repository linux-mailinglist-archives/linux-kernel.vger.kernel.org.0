Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F166818149
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 22:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfEHUpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 16:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbfEHUpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:45:11 -0400
Subject: Re: [GIT PULL] CIFS/SMB3 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557348311;
        bh=0nodbKS9+c8WCJsr0dSpgCp/JnVVrb/qzGJBKg7oz8A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CC+BBiL/AuRsiiK72Xp6FTT3DJmq7K5AyQQ/3sONAnw4WIwkCcxy5S2v7whZUTcBr
         zNJQdcfEaZTifX/cMDVkUCxRXZJQv5tWOYiKkAtjslseVg86hNqGi1bdLdyQDf+PVd
         FEnXyu1VHbS3Gcj3IDVcbRBIhTQsvEaqOLk5Ye3Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mv=4JsaF-8v=U4JR3jrOyPfhtUsJPogNudLejDh09xGSA@mail.gmail.com>
References: <CAH2r5mv=4JsaF-8v=U4JR3jrOyPfhtUsJPogNudLejDh09xGSA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mv=4JsaF-8v=U4JR3jrOyPfhtUsJPogNudLejDh09xGSA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.2-smb3
X-PR-Tracked-Commit-Id: cb4f7bf6be10b35510e6b2e60f80d85ebc22a578
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78d9affbb0e79d48fd82b34ef9cd673a7c86d6f2
Message-Id: <155734831110.32213.665312592031746226.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 20:45:11 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 May 2019 13:32:35 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.2-smb3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78d9affbb0e79d48fd82b34ef9cd673a7c86d6f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
