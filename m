Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9576FB9798
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 21:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436709AbfITTKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 15:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406855AbfITTK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:10:28 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.4-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569006627;
        bh=9hcNYCOeUOjjlOWJPMNv/mdersVEM8D++nV/WuzHo40=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aZNMZqq2wNAmzmnDKkHHG5Ltev23VVkdsyH5uYzMxya9T5FttzjhUCMzqk6PgL1vG
         yFehh5yRIpWHgi7GWAz1tPpbz7GA818IALVPrje1K0TN57W6ggdRTB7T3KNFBelDZk
         +uI/l6TalbDkAY8h/8+t8ENoO8WCA8D9UpyVBL7c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87blvft845.fsf@mpe.ellerman.id.au>
References: <87blvft845.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87blvft845.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.4-1
X-PR-Tracked-Commit-Id: d9101bfa6adc831bda8836c4d774820553c14942
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45824fc0da6e46cc5d563105e1eaaf3098a686f9
Message-Id: <156900662776.23740.6952253366695524692.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Sep 2019 19:10:27 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        adam.zerella@gmail.com, aik@ozlabs.ru, ajd@linux.ibm.com,
        andmike@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        arbab@linux.ibm.com, bauerman@linux.ibm.com,
        benh@kernel.crashing.org, bsingharora@gmail.com, cai@lca.pw,
        cclaudio@linux.ibm.com, christophe.jaillet@wanadoo.fr,
        christophe.leroy@c-s.fr, clg@kaod.org, cmr@informatik.wtf,
        dja@axtens.net, ego@linux.vnet.ibm.com, ganeshgr@linux.ibm.com,
        grimm@linux.vnet.ibm.com, gromero@linux.ibm.com,
        gromero@linux.vnet.ibm.com, groug@kaod.org, hbathini@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, hch@lst.de,
        hegdevasant@linux.vnet.ibm.com, jniethe5@gmail.com,
        jsavitz@redhat.com, khandual@linux.vnet.ibm.com,
        leonardo@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com,
        maddy@linux.vnet.ibm.com, maxiwell@linux.ibm.com,
        natechancellor@gmail.com, nathanl@linux.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, npiggin@gmail.com,
        oohall@gmail.com, paulus@ozlabs.org, ravi.bangoria@linux.ibm.com,
        rostedt@goodmis.org, santosh@fossix.org, sbobroff@linux.ibm.com,
        segher@kernel.crashing.org, stewart@linux.ibm.com,
        sukadev@linux.ibm.com, sukadev@linux.vnet.ibm.com,
        tyreld@linux.ibm.com, yamada.masahiro@socionext.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Sep 2019 23:22:50 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45824fc0da6e46cc5d563105e1eaaf3098a686f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
