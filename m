Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C59661BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 00:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfGKWaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 18:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbfGKWaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:30:11 -0400
Subject: Re: [GIT PULL] SCSI topic updates for the 5.2+ merge window: sg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562884210;
        bh=leH1KsbWQXhuRX1P7inJn8QYUcdUWj0Axb7Wept1qEA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cnv7VIpbEYpgbpo3ukvqSIG/0jlfgN2LOdwnnz8T9vedMKv+G9mSRgIM6AwkBBG38
         rZ5E9fjGRPzH4RZyFIVhZGeYNiZflIM6N1tqEpmrfcWitLqcUPy0FV2PDycA9cTd61
         lN8Kt+dmgOgjg5Laz9YjnwwmeJCL7Ye8ER6MQaVI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1562705278.30003.8.camel@HansenPartnership.com>
References: <1562705278.30003.8.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1562705278.30003.8.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-sg
X-PR-Tracked-Commit-Id: 3e99b3b13a1fc8f7354edaee4c04f73a07faba69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f7563f743d7081710a9d186a8b203997d09f383
Message-Id: <156288421069.10140.5154229734157920631.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 22:30:10 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 09 Jul 2019 13:47:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-sg

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f7563f743d7081710a9d186a8b203997d09f383

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
