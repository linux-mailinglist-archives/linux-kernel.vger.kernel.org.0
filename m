Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9416D5DFA1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 10:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfGCIUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 04:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbfGCIUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:20:05 -0400
Subject: Re: [GIT PULL] SMB3 fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562142004;
        bh=2sAffZCJ8WeQ+hDqXJuWPpJrJZFJqACR7CD5i6C+7QM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HmnCuzfuUOs2WH78Gx09BkQAnt9co8KeVPVOYv+a9CQ9Z54UgR9YtjsAslIKsuRlS
         8jaVecP+7s951De5Ckejw7uoWvagna8ij9AUeoWXadQL9GeYM8HxzWDtmqtpDGfnI9
         9FYamdB6cLVh4q10NS4qDiAgVX4LoEaVZYetEcrU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mteWJHa9k9skOn6by1M2CYGAU9LubUE-61TH0_3Nbgm1A@mail.gmail.com>
References: <CAH2r5mteWJHa9k9skOn6by1M2CYGAU9LubUE-61TH0_3Nbgm1A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mteWJHa9k9skOn6by1M2CYGAU9LubUE-61TH0_3Nbgm1A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.2-rc6-smb3-fix
X-PR-Tracked-Commit-Id: 5de254dca87ab614b9c058246ee94c58a840e358
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e692c3b721f30485a9124f93e27a0cb6569116c
Message-Id: <156214200438.4530.14523104438507610553.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jul 2019 08:20:04 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Jul 2019 23:54:00 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.2-rc6-smb3-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e692c3b721f30485a9124f93e27a0cb6569116c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
