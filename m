Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0995466109
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 23:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfGKVPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 17:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbfGKVPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:15:11 -0400
Subject: Re: [GIT pull] timers/urgent for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562879710;
        bh=UeF5BHYYoZDOWxsZax2UTwuARZdOY6fQlo9qCTC3d/Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yYhiKgR/HqAhYN4QYkXNpUqMTBHxxvrtExiH0Kn0Z/JHrfoKzdK2KLGrR3LNtb6oo
         HLNHQzdAm2YwE7jKiupd/BM5x9BYdQW4oD47XAk05mzy+w29e5Vl5fyTUae8PUe6sL
         iCv7/zUOnSXtoAnAGltet61ZMVCC6mgHHnYvFB/g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156287535656.8320.9605793923078784342.tglx@nanos.tec.linutronix.de>
References: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
 <156287535656.8320.9605793923078784342.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156287535656.8320.9605793923078784342.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: 0df1c9868c3a1916198ee09c323ca5932a0b8a11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7fe42a64a19a4140fb94bcf996035319cd3e6b9
Message-Id: <156287971038.8575.1459569125525893458.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 21:15:10 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 20:02:36 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7fe42a64a19a4140fb94bcf996035319cd3e6b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
