Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0F3734A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 19:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfGXRK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 13:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfGXRKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:10:21 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-2 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563988221;
        bh=8Iv1KNyqx9qxX4tBWmO2qXBdCa/7Mtdy+eUFXutnc2k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gnNuMHvb3zY+RHCONcmiUO5vAwOOLzOxxX6bLB0XbQSyScyNRHUvxB6kuv6jDj6Ay
         rpUIDdogUAjCCK31LSRCkFogRUQtdSHXNGLSW2T8bCuzNT+ExYeVDl4hb7SGEpRwgD
         92Y3ay6PmZocijx8K3Jzx4ELhB57zQDrCYvlzy1c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o91j5z20.fsf@concordia.ellerman.id.au>
References: <87o91j5z20.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o91j5z20.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.3-2
X-PR-Tracked-Commit-Id: 3a855b7ac7d5021674aa3e1cc9d3bfd6b604e9c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bed38c3e2dca01b358a62b5e73b46e875742fd75
Message-Id: <156398822120.2764.10514051840491932120.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Jul 2019 17:10:21 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aarcange@redhat.com, clg@kaod.org, ego@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, shawn@anastas.io, sjitindarsingh@gmail.com,
        vaibhav@linux.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Jul 2019 23:42:31 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bed38c3e2dca01b358a62b5e73b46e875742fd75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
