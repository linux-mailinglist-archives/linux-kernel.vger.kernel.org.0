Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A06EBD32A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 21:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633304AbfIXTza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 15:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633248AbfIXTz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:55:27 -0400
Subject: Re: [GIT PULL] arch/microblaze patches for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569354926;
        bh=aOzeBBUyM9Bst5wksrj/uHf5KpJtqVNQE25Nt0GuWoo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QWf5Hv5mBufIK+oX1Uxb/rPcScqKPdLcfPW5ZLENQ++ufgh3aptPSQDeuYvvwdE3M
         jPAmSKhBJbbkSETUDaIR6Z5oS8uszu7XDGnoxrveUbQzwZ0vvUYE9hXt/mcFjOOQfc
         jZ+Ana3gOuy1GCSKQnfxXz8ijqwuVpNusF/VoK8Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <99b0cfb6-0d4a-555b-ebd6-d97f96dfd2c9@monstr.eu>
References: <99b0cfb6-0d4a-555b-ebd6-d97f96dfd2c9@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <99b0cfb6-0d4a-555b-ebd6-d97f96dfd2c9@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git
 tags/microblaze-v5.4-rc1
X-PR-Tracked-Commit-Id: 7cca9b8b7c5bcc56d627851550840586a25aaa1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5184d449600f501a8688069f35c138c6b3bf8b94
Message-Id: <156935492685.15821.9380699824086138096.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Sep 2019 19:55:26 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Sep 2019 11:56:11 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5184d449600f501a8688069f35c138c6b3bf8b94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
