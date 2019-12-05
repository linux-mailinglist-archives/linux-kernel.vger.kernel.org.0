Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C58114851
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 21:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbfLEUps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 15:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730157AbfLEUpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:45:31 -0500
Subject: Re: [GIT PULL 4/4] ARM: SoC defconfig updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575578731;
        bh=HziuGArZJwNyrmXlMkgBlDPOsf8gS5LIoS+W1M3z4ew=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=alnSzEYWbGDWOOb6/N9NcuW5AyDGTTfSI3ucS86a4Xi4hjG9QwmbQQYbBK5IF6Yqv
         AaM50gP3bqhg2KsO3UN/yip5RPuBCa543zVTrekeh4zvgB3fDYUuBeZv8d7tyNN1sL
         DKTq36wewsSr3g2tvF0+jr7LS6Wbubo03vSIOpxo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191205180453.14056-4-olof@lixom.net>
References: <20191205180453.14056-1-olof@lixom.net>
 <20191205180453.14056-4-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191205180453.14056-4-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 tags/armsoc-defconfig
X-PR-Tracked-Commit-Id: a235f803dbc878d1db83cbaabf6963ca9ef3a1a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b08baef02b26cf7c2123e4a24a2fa1fb7a593ffb
Message-Id: <157557873109.26858.14041273176630769964.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 20:45:31 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  5 Dec 2019 10:04:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-defconfig

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b08baef02b26cf7c2123e4a24a2fa1fb7a593ffb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
