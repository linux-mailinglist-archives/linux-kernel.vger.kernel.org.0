Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6251419BE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 22:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgARVFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 16:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgARVFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:05:03 -0500
Subject: Re: [GIT PULL] s390 updates for 5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579381503;
        bh=7IX9vEs7ojp3ZgO+H9YO55X6TXH4dQxVyIV8DtZJ3Ig=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mHW23Fxjbn8S4qUuQeuLtHrobrDjTLS7emMIoUsI0xQsobEKg4P59YYMMBt8n7ZZd
         lm/rPnggKGgfF48eBjM9EE1eURekDkWOAkKd0Tig0tf0IM+HBOVlApRLl4B6a6u+hl
         QseEMCcmuantL3RQIXhsTnQYk9RQX4D8nS4h1k9o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01579351767-ext-7089@work.hours>
References: <your-ad-here.call-01579351767-ext-7089@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01579351767-ext-7089@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-5
X-PR-Tracked-Commit-Id: 40260b01d029ba374637838213af500e03305326
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2324de6fab2223287da7628ba92dc6cfed4f46ca
Message-Id: <157938150305.20598.8146120296125028034.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 21:05:03 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 13:49:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2324de6fab2223287da7628ba92dc6cfed4f46ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
