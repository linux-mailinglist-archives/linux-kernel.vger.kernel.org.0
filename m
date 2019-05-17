Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB1211F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 04:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfEQCZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 22:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfEQCZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:25:21 -0400
Subject: Re: [GIT PULL] Devicetree vendor prefix schema for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558059920;
        bh=LWMZG6UwQeDWtesoN6jK0L9bMSTeYkxOyVeZ1xdJsKI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WkBASstfb46+kWxUvWA88rkW3U+mcbbn9EJ/Sk3T10kzPZ53ZSjGT1M/NTVkgnmsJ
         blCGOAIl0hyG5syFid23ajB+tNwERzFazuZdngGpDJW8ED+U34T6FM2zOlThhWjNfz
         Ejh7OBTEvvcQlnkBCcgZfdOW+0Az4boHsHy7nIRw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAL_JsqLtkGfSX5bdRWy7MXM+opAd-gWzhTorUoVXOpKktN8YKQ@mail.gmail.com>
References: <CAL_JsqLtkGfSX5bdRWy7MXM+opAd-gWzhTorUoVXOpKktN8YKQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAL_JsqLtkGfSX5bdRWy7MXM+opAd-gWzhTorUoVXOpKktN8YKQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-for-5.2-part2
X-PR-Tracked-Commit-Id: 8122de54602e30f0a73228ab6459a3654e652b92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cbda1bddb4c561f3a7360d36ce13a73bb02bfeb
Message-Id: <155805992067.6110.7638939329773662220.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 02:25:20 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 15:43:27 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.2-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cbda1bddb4c561f3a7360d36ce13a73bb02bfeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
