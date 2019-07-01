Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4019D54
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 14:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfEJMfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 08:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfEJMfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:35:14 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.2-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557491713;
        bh=0ihxgez7etArzPMdt7Fob4yziLE29y2EEZW93s0R294=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0BBs7oqzZdzDhfsBqiQPfaEKLQYGHYa0llO/ydJ/nBuswWEQP6EOoTqZmB7PxVoWX
         Wn16zvkr6I4APTv56U94gNWiYoSef8waG/b04cNKkcCrcGmFmNNpz25oHmV+yqoBk5
         QrFXHT4HQ9trAfrCZmTuQD2C8NisfGZHaulzxSQQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874l62v6u0.fsf@concordia.ellerman.id.au>
References: <874l62v6u0.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <874l62v6u0.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.2-1
X-PR-Tracked-Commit-Id: 8150a153c013aa2dd1ffae43370b89ac1347a7fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b970afcfcabd63cd3832e95db096439c177c3592
Message-Id: <155749171372.31662.8613188433450334678.pr-tracker-bot@kernel.org>
Date:   Fri, 10 May 2019 12:35:13 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Julia.Lawall@lip6.fr, aik@ozlabs.ru, ajd@linux.ibm.com,
        alastair@d-silva.org, andrew.donnellan@au1.ibm.com,
        aneesh.kumar@linux.ibm.com, anju@linux.vnet.ibm.com,
        anton@ozlabs.org, ben@decadent.org.uk, cai@lca.pw,
        christophe.leroy@c-s.fr, clg@kaod.org, cmr@informatik.wtf,
        colin.king@canonical.com, dja@axtens.net, dvyukov@google.com,
        fbarrat@linux.ibm.com, ganeshgr@linux.ibm.com, hch@lst.de,
        horia.geanta@nxp.com, jagdsh.linux@gmail.com, joe@perches.com,
        joel@jms.id.au, laurentiu.tudor@nxp.com, leitao@debian.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lkml@sdf.org, lukas.bulwahn@gmail.com, lvivier@redhat.com,
        maddy@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
        malat@debian.org, mikey@neuling.org, nathanl@linux.ibm.com,
        ndesaulniers@google.com, nfont@linux.vnet.ibm.com,
        npiggin@gmail.com, paulmck@linux.ibm.com,
        ricklind@linux.vnet.ibm.com, ruscur@russell.cc,
        sachinp@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
        thuth@redhat.com, tobin@kernel.org, tsu.yubo@gmail.com,
        valentin.schneider@arm.com, weiyongjun1@huawei.com,
        wen.yang99@zte.com.cn, yuehaibing@huawei.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 May 2019 22:20:55 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b970afcfcabd63cd3832e95db096439c177c3592

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
