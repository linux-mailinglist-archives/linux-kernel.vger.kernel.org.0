Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E3C12F2B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 02:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgACBZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 20:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgACBZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:25:06 -0500
Subject: Re: [GIT PULL] FIELD_SIZEOF() removal for v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578014706;
        bh=4pI4pA7Gdo8/z+gKOaECYS+rN+QJnhYwKrpfFwCllqQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jd0m8vlXPuRDxmHi8aSqCdK2A/sQwxX35SY5WDIJI2LZV5O29D/pOiu16PuSAgVXG
         maPByBHyCiY/U2S4VlO6Gw/bCUv3DKdjY/MjWhx0e1ThPSZkO+zdUOmtLfH2DvCn3x
         1MjqzW3VIlVNaKdNuESYA+IBqHjGUu01sZ4W12vk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202001021346.11B0D2B5F@keescook>
References: <202001021346.11B0D2B5F@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202001021346.11B0D2B5F@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/sizeof_field-v5.5-rc5
X-PR-Tracked-Commit-Id: 1f07dcc459d5f2c639f185f6e94829a0c79f2b4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ca4ad5ba886557b67d42242a80f303c3a99ded1
Message-Id: <157801470604.30243.2120904029404947302.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 01:25:06 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Jan 2020 13:48:01 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/sizeof_field-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ca4ad5ba886557b67d42242a80f303c3a99ded1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
