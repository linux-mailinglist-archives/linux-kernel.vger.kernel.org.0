Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDDE7629A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 21:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404550AbfGHTaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 15:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732202AbfGHTaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:06 -0400
Subject: Re: [git pull] m68k updates for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614205;
        bh=y/Y0sXcNNpRRVUwAT3w0fxLvTJe3YZ4YKwvnAWZnPXY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mghzx3U8O4YD84t3ZhAO46HrF+0i+NbuEMD5J+zfSjVtpBUWhKrdSUyXLLnbaQo33
         BoSjiOu1XjlXGj/xt309f4+8q+9OEuXAzGTW8WgwAhLgtMR/6kNILo2gxg00yxyu55
         a1lbqFKCNLNVYPu+XtR+9+0X3J0h0wbqdB4DOrRE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708080005.22806-1-geert@linux-m68k.org>
References: <20190708080005.22806-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708080005.22806-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
 tags/m68k-for-v5.3-tag1
X-PR-Tracked-Commit-Id: 69878ef47562f32e02d0b7975c990e1c0339320d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 278ecbf027c3c559deb225f0cf53a23b7672dacf
Message-Id: <156261420551.31351.10567147651302852331.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:05 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  8 Jul 2019 10:00:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.3-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/278ecbf027c3c559deb225f0cf53a23b7672dacf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
