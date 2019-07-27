Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F4977A9B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387719AbfG0QfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 12:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbfG0QfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 12:35:18 -0400
Subject: Re: [GIT PULL] Devicetree fixes for 5.3-rc, take 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564245317;
        bh=uhULmTb0NqEXonl23BHXNBYi1WNxz0CdZNkYi0nQreM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o8H391UrTqOvkJxugeBUF5VfLMkYo2+4NGV29nd945IzvpccKIIYcYydLqn2s+ZZI
         ytcatw+ezNTeJOvdvyY2caElmlRwxgM3Yc+QGSdRZTHLGzASd4PlWrjpJY8grEOoIF
         mxSwU0ZSBVXg3o+sUZok298YvTn1HkzA5B1x92Ug=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAL_JsqJLB4q6wqTOX0oXAGQF4wuZ0irNT8nmpFEmuUKjvv38BQ@mail.gmail.com>
References: <CAL_JsqJLB4q6wqTOX0oXAGQF4wuZ0irNT8nmpFEmuUKjvv38BQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAL_JsqJLB4q6wqTOX0oXAGQF4wuZ0irNT8nmpFEmuUKjvv38BQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.3-2
X-PR-Tracked-Commit-Id: e1ff7390f58e609aa113a2452a953f669abce6cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5efbd93708df56e0fb92b4398960a5bb1ab62f02
Message-Id: <156424531777.2399.5990197327652199705.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jul 2019 16:35:17 +0000
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 18:03:50 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5efbd93708df56e0fb92b4398960a5bb1ab62f02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
