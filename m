Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68E17066
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 07:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfEHFkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 01:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbfEHFkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 01:40:12 -0400
Subject: Re: [GIT PULL] Devicetree for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557294012;
        bh=JfIUpGCXTqfyhoR5IJzHP9LnRN5bJm4BN8SgDFXXK8k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VaHN+VZgN+4wc1/RK813fmJBYlt3DnIjOro/Zppk0Otj8pNsnmMw3idxJ14Y7aw7P
         rRHyfh+N67hK5n+py7XdXyA/xx4YVPejUe3p1oHMhu7YAfA151iyrz4tkhSmKrWUK/
         TAlX1GD68shT/ckU/UBJ9PqpYdN0RYvyICp6tLiY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAL_JsqJ8YqaiNwj715B=5r39RzuXLn1inhAQ044j8d-L0vYLZA@mail.gmail.com>
References: <CAL_JsqJ8YqaiNwj715B=5r39RzuXLn1inhAQ044j8d-L0vYLZA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAL_JsqJ8YqaiNwj715B=5r39RzuXLn1inhAQ044j8d-L0vYLZA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-for-5.2
X-PR-Tracked-Commit-Id: 2a656cb5a4a3473c5fc6bf4fddc3560ceed53220
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82efe439599439a5e1e225ce5740e6cfb777a7dd
Message-Id: <155729401200.2342.4457780261177778683.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 05:40:12 +0000
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 18:53:25 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82efe439599439a5e1e225ce5740e6cfb777a7dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
