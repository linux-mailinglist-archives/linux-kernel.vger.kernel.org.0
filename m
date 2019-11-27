Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF410B6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 20:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfK0TaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 14:30:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbfK0TaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:30:19 -0500
Subject: Re: [GIT PULL] Driver core patches for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574883018;
        bh=3z9e/U6BxCHs1Pg7uyhbKiSmKB8607nf7+oyfCMaKWQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EqteDc/lZmPo9xqzOaqMiVaKxpDXIKyzeQbi3dIeXqjV9o9Brm2DCZu96plr+lmPg
         4SdENSk0tskurKC5aJlXIzmkogLqcxWQDky4ctyo+0hbOatNV+pUYTZX27rY/D/CJJ
         GIXz9hyI4YUiWC9G+fHcTuiJ25A6NhRyaGKInnOg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191127164138.GA3088162@kroah.com>
References: <20191127164138.GA3088162@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191127164138.GA3088162@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.5-rc1
X-PR-Tracked-Commit-Id: 0e4a459f56c32d3e52ae69a4b447db2f48a65f44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a3d7fd275be4559277667228902824165153c80
Message-Id: <157488301859.32229.4242642539660598068.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 19:30:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 17:41:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a3d7fd275be4559277667228902824165153c80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
