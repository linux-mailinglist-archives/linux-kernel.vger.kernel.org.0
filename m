Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8CD66385
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 03:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfGLBzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 21:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbfGLBzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 21:55:11 -0400
Subject: Re: [GIT PULL] Devicetree updates for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562896510;
        bh=4oJRQbAb94vMBFp8ji5zLwTApaXBOLkBC6zI3acsPnA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2dtxCNnSfmH3oDbEH3LJxU23wXm90p2ER3AoEhzRWbDzSvnQQ/V8GqftoUtXwqeMj
         mx/YLo6V2B1ozrDduefmXBJIeyeXjddVHjml5urFoFvhSNB/ooEQ2WO/foyEhIqhko
         5deS9xEw+8+6sWMYifmkxBKK91o3LpkLg4BMacQk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAL_JsqJAydO3Zjx_9S+r8h5YAQbDBJjqHSFV-aKkN9n=MH7erg@mail.gmail.com>
References: <CAL_JsqJAydO3Zjx_9S+r8h5YAQbDBJjqHSFV-aKkN9n=MH7erg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAL_JsqJAydO3Zjx_9S+r8h5YAQbDBJjqHSFV-aKkN9n=MH7erg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-for-5.3
X-PR-Tracked-Commit-Id: f59d261180f3b66367962f1974090815ce710056
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d06e4156430e7c5eb4f04dabcaa0d9e2fba335e3
Message-Id: <156289651093.2089.8336732917653000086.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jul 2019 01:55:10 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, David Miller <davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jul 2019 14:50:01 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d06e4156430e7c5eb4f04dabcaa0d9e2fba335e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
