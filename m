Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D77610DFC9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2019 00:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfK3XFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 18:05:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfK3XFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 18:05:20 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575155120;
        bh=tGckANu044kEHwyFyJWgagVeyE0g1taM4zR/godAuo8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XU3HwnFERqjhyOJpClp9IVB9F4kgbNCv6gHgTa3BJCUoSJOAomp7beGVZdqdT/TqY
         F/g1eZ3pHpySi1GNkSdijFxg/VzcsFtxbA72iwV6KfbS1rHO73Hc26o7Zs0KvqlAWH
         Pts7FFFj+INMqZELm6iLTQZuRSbpcdF4Gitjryyc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877e3hfxyq.fsf@mpe.ellerman.id.au>
References: <877e3hfxyq.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877e3hfxyq.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.5-1
X-PR-Tracked-Commit-Id: 2807273f5e88ed086d7d5d838fdee71e11e5085f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7794b1d4185e2587af46435e3e2f6696dae314c7
Message-Id: <157515512019.27985.3391840091234798469.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 23:05:20 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com,
        alastair@d-silva.org, aneesh.kumar@linux.ibm.com,
        asteinhauser@google.com, bhelgaas@google.com, cai@lca.pw,
        chris.packham@alliedtelesis.co.nz,
        chris.smart@humanservices.gov.au, christophe.leroy@c-s.fr,
        clg@kaod.org, cmr@informatik.wtf, david@redhat.com,
        debmc@linux.vnet.ibm.com, geert+renesas@glider.be,
        gwalbon@linux.ibm.com, harish@linux.ibm.com,
        hbathini@linux.ibm.com, hch@lst.de, krzk@kernel.org,
        leonardo@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, linuxppc-dev@lists.ozlabs.org,
        linuxram@us.ibm.com, madalin.bucur@nxp.com, malat@debian.org,
        msuchanek@suse.de, natechancellor@gmail.com, nathanl@linux.ibm.com,
        nayna@linux.ibm.com, npiggin@gmail.com, oohall@gmail.com,
        oss@buserror.net, ravi.bangoria@linux.ibm.com, ruscur@russell.cc,
        sbobroff@linux.ibm.com, thuth@redhat.com, tyreld@linux.ibm.com,
        vaibhav@linux.ibm.com, valentin@longchamp.me, yanaijie@huawei.com,
        yuehaibing@huawei.com, zohar@linux.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Nov 2019 21:41:17 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7794b1d4185e2587af46435e3e2f6696dae314c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
