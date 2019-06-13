Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22CE844689
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393048AbfFMQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730118AbfFMDPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:15:10 -0400
Subject: Re: [GIT PULL] SELinux fixes for v5.2 (#2)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560395709;
        bh=3oMBlDRrBIeV7aZZR/5/H9S3HH+AvOnnKJxido+N9jM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S7rHAx4A+QXwEhTqiv2M9GU+ligvs1br2kDnnJw0r+NROKSFH/zSnINxo5iro0vvl
         nv69qfZuvTSW93VWyxwhfCFKlMY+4Sa5FZYX6pbiqISAj7u8aFLA2Ihlfl8SR7rtXx
         yapvJ6xAQlY0zALPMEfnso8zSWhj0A5ra91DGpwM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhT8tYyUt_gtUR-jD-33LMW2RmzSXwP_OgPrh5ujQSiuUA@mail.gmail.com>
References: <CAHC9VhT8tYyUt_gtUR-jD-33LMW2RmzSXwP_OgPrh5ujQSiuUA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhT8tYyUt_gtUR-jD-33LMW2RmzSXwP_OgPrh5ujQSiuUA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190612
X-PR-Tracked-Commit-Id: fec6375320c6399c708fa9801f8cfbf950fee623
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b076173a309e2ceae84257d1d52cd3cc53b00e39
Message-Id: <156039570947.24640.14489241728856509537.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jun 2019 03:15:09 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jun 2019 16:59:05 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190612

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b076173a309e2ceae84257d1d52cd3cc53b00e39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
