Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80ABC1289B4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 15:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfLUOz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 09:55:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfLUOzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 09:55:10 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576940110;
        bh=MI/JmG2aNZLH/n4zNzRm8HaS1AdrgVr2N65rL/m9UO8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dRhbY1jJH0CP7sZg8h2wzi5T8ukY+RVnvEPChsH2sWHaR430ctqXdKlbzMlNXOw5J
         zEDz53EQbjeBEPDrgDQMxD7Wpa7atNFm7M/3QzyTeGzzzWU3l0sbYLRMiv07rGeOZU
         avuJYeHI85dOGasK7J8KlKGurO73naWiJRGtIMiE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sgldlwb0.fsf@mpe.ellerman.id.au>
References: <87sgldlwb0.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sgldlwb0.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.5-4
X-PR-Tracked-Commit-Id: 228b607d8ea1b7d4561945058d5692709099d432
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d04182dd36dc5a4dd2e352c1d0f0241e83bd2a0
Message-Id: <157694011047.20544.8813472995788397797.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 14:55:10 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com,
        christophe.leroy@c-s.fr, david@redhat.com, fbarrat@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        longman@redhat.com, marcus@mc.pp.se, pauld@redhat.com,
        rppt@linux.ibm.com, srikar@linux.vnet.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 23:04:03 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.5-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d04182dd36dc5a4dd2e352c1d0f0241e83bd2a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
