Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0833EB9F51
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbfIUSPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 14:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731775AbfIUSPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 14:15:23 -0400
Subject: Re: [GIT PULL] libnvdimm for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569089723;
        bh=5/1Co2dhtCJ+2dhp9MAkmlBq5yjC23womgX1T5IGAzA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u0cNmLSBT3M0r845jbRhjIPVDphGFo3O8we3cdolMIxbpMDqBMAGyJ70bfS6djcOV
         iY6FInF5TbUo9UCuK6y+YNj3ZP1LsO2meCLeHd/Q0gommxep5CSkBTsn3xEq0h0not
         J3gznpgVgeNiIMTW6EmmUrPuQYk3c4Q/b70GBtag=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4g9TpgciDdVpQajSxEYTaHxB4+R9KWF0d=Emt9J7LkAqg@mail.gmail.com>
References: <CAPcyv4g9TpgciDdVpQajSxEYTaHxB4+R9KWF0d=Emt9J7LkAqg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4g9TpgciDdVpQajSxEYTaHxB4+R9KWF0d=Emt9J7LkAqg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-for-5.4
X-PR-Tracked-Commit-Id: 5b26db95fee3f1ce0d096b2de0ac6f3716171093
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cb2e9ee51b5f1539f027346a02904e282b87d4d
Message-Id: <156908972332.32474.14806435139939273985.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 18:15:23 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Sep 2019 16:57:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cb2e9ee51b5f1539f027346a02904e282b87d4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
