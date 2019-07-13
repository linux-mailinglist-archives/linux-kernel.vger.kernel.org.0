Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B9567C73
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 01:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfGMXPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 19:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbfGMXPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 19:15:16 -0400
Subject: Re: [GIT] Sparc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563059716;
        bh=9JBOotczWgZpK5tseRn08nHfizYrttK15HHA84w7ymM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=a5APnUYut9XEHy6LTRhejBi02YJx7OO40MVah99ruPIULQEkOk9O9EwBGoqh4PxhE
         7DdbPTflV5LviAFOOwyYE2Z4Ygj6P3t20dRFLTOZ3UZTLjx/io8ukcof5PsONT57ox
         Vjek6+fX2xkZa1+Gj74U4AvJoPVVB0Ks/uTuLTeo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190712.231742.1744524168822613248.davem@davemloft.net>
References: <20190712.231742.1744524168822613248.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190712.231742.1744524168822613248.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 61daf52c4ddd433924687850fa04ed85c0d806dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec9249752465b87b5b26d03f476eebaf872ebd12
Message-Id: <156305971620.4281.13657812831041025401.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 23:15:16 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 23:17:42 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec9249752465b87b5b26d03f476eebaf872ebd12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
