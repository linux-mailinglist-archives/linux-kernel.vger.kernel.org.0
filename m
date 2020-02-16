Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEDE16060A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 20:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBPTuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 14:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgBPTuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 14:50:19 -0500
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581882619;
        bh=sB/vufOEvmQ45ty5tmh+DsYCIhFHuK0fdMMza9D3je4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J+SloLGG765Mit5Ykk0z/5+byFPRiGJPNt3g1CQ8T3f9NTxWJzbgZyhrqdCjt3uA6
         KUs4wVQ+sk4Gtz9vWxLEaGSFcJaasO4QElBXD8vWd9uD8BbAejcK1fG9Vnk4y1ghyQ
         qsf5FlhgHdB1eQDMvzoj0YMOzuh6a6GdgHp2mUZI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mt=_P2tUC6H+bmFL-FAyKYQuvim2fYqa27gMdJj3882=g@mail.gmail.com>
References: <CAH2r5mt=_P2tUC6H+bmFL-FAyKYQuvim2fYqa27gMdJj3882=g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mt=_P2tUC6H+bmFL-FAyKYQuvim2fYqa27gMdJj3882=g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.6-rc1-smb3-fixes
X-PR-Tracked-Commit-Id: 85db6b7ae65f33be4bb44f1c28261a3faa126437
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 288b27a06e4f8f7bad63792cf015c160ae578d89
Message-Id: <158188261896.7458.9742510133908572108.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Feb 2020 19:50:18 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Feb 2020 20:58:53 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.6-rc1-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/288b27a06e4f8f7bad63792cf015c160ae578d89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
