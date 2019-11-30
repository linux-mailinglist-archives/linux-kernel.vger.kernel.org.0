Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6DF10DEF1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 20:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfK3Tk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 14:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbfK3TkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:40:25 -0500
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575142824;
        bh=FhiMhq/R1cQhVPFIq1w/62PIb3jNUbAbVoZN2SUwwYI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y1aOTmloZhjQh8TpQIZ6Y1c58XeAuTCldj4S8JTOSfUgE/+u54/f04D51pZjdpE/d
         q/22BbBPZeiC8CJEyYxN4yZ/z7fPgjxiLzBZZ8XB5LIl9H/4rtHhV/Ts/+RX3C2iQA
         pSzr+ti26e093MYMpdEtV1jq7C6Mm3mYfIHw6lEM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtDpwY=MrQ=yN29JeWUqf+ozgYvgnzbnb91VoK8Vg4Zmw@mail.gmail.com>
References: <CAH2r5mtDpwY=MrQ=yN29JeWUqf+ozgYvgnzbnb91VoK8Vg4Zmw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtDpwY=MrQ=yN29JeWUqf+ozgYvgnzbnb91VoK8Vg4Zmw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.5-rc-smb3-fixes
X-PR-Tracked-Commit-Id: 68464b88cc0a735eaacd2c69beffb85d36f25292
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21b26d2679584c6a60e861aa3e5ca09a6bab0633
Message-Id: <157514282440.12928.6617531146051742781.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 19:40:24 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 17:49:32 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.5-rc-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21b26d2679584c6a60e861aa3e5ca09a6bab0633

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
