Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F642287F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2019 21:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfESTPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 15:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfESTPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 15:15:21 -0400
Subject: Re: [GIT PULL] SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558293321;
        bh=2NPU35+R0BIDd+eDKQ995xuCgF6F2m6s+/JE6TRSog8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y7YMa6h5cBZhhpKEFbrEXYWLWiMd3PDgERKytfi13v6Y4tUGRw66lPJ4penVk1L3h
         W9Nu1OjMGhua5+73pyPLDtg5Hytz/6ZC6mLlisQvYsk1DLS/j/obVVAVNZu6eD2xKM
         jftngKG+uOmjnO/Z1Ss9H+hWCFjd/0fO8rl/5el8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msEB_bvDTOPLwtoH0Ty6ttXhb3RP+18d47xNjN7q0apYA@mail.gmail.com>
References: <CAH2r5msEB_bvDTOPLwtoH0Ty6ttXhb3RP+18d47xNjN7q0apYA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msEB_bvDTOPLwtoH0Ty6ttXhb3RP+18d47xNjN7q0apYA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.2-rc-smb3-fixes
X-PR-Tracked-Commit-Id: dece44e381ab4a9fd1021db45ba4472e8c85becb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8848eefc1d541dd0e3ae175e09fb5c66f1d4de6
Message-Id: <155829332124.24875.10913503700761281896.pr-tracker-bot@kernel.org>
Date:   Sun, 19 May 2019 19:15:21 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 May 2019 22:37:33 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.2-rc-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8848eefc1d541dd0e3ae175e09fb5c66f1d4de6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
