Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E9EED037
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 19:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfKBSfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 14:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfKBSfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 14:35:06 -0400
Subject: Re: [GIT PULL] s390 updates for 5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572719706;
        bh=TOyYussdSLJNvufipa1EX90zquHkMbJWvDpA/Jmt63k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ClzSLg1k6Az7Hfy5Er52q9iyfvKbsinqx4O20wtKnFxq8ah4xy2Eh5MvFnkkpueql
         e0MStL4ByPggMI5ead1TXyefXFYzdOApwjbZVHwsy2S5iOD6T+AtFu4e1ZkaxCGTki
         GXpaC4tm4rv5upb+3GUK5+rTvb7uqwcGmb7/N/9c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01572690220-ext-8522@work.hours>
References: <your-ad-here.call-01572690220-ext-8522@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01572690220-ext-8522@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-6
X-PR-Tracked-Commit-Id: 3d7efa4edd07be5c5c3ffa95ba63e97e070e1f3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 969a5197da89454c41d95e2404e2e9d91ad73ba6
Message-Id: <157271970622.32009.11368122331007905497.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Nov 2019 18:35:06 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Nov 2019 11:23:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/969a5197da89454c41d95e2404e2e9d91ad73ba6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
