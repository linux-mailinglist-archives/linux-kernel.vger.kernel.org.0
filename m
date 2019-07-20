Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7688E6F05F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 20:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfGTSk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 14:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbfGTSka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 14:40:30 -0400
Subject: Re: [GIT pull] core/urgent for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563648029;
        bh=3gP7MPMdbmEFT4XsPU9P5AGY+0Uymgo20xnxzSy8AA4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ghwYxjAASOnm64BmH1DYJBJIaxkqSYH12LknZj2FKhPiDwoeGHa2NAPCmBDv8m4f8
         IqoGfs1RiUiC5SgBm6TsiFGay4qhp683Ql04q29vq3W7i+/iWkVtoDH6Ak0sJu/NP2
         s16gy1Puv1zQnTgshLtk9Ij3BkJb9330LTSdh6oc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
References: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: b68b9907069a8d3a65bc16a35360bf8f8603c8fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6023adc5c6af79ac8ac5b17939f58091fa0d870
Message-Id: <156364802960.20023.13325159197022944815.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 18:40:29 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 12:50:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6023adc5c6af79ac8ac5b17939f58091fa0d870

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
