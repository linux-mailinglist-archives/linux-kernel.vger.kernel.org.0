Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F248F092
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 18:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfHOQZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 12:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729274AbfHOQZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:25:05 -0400
Subject: Re: [GIT PULL] Devicetree fixes for 5.3-rc, take 3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565886305;
        bh=9/lOd+65RW8ZAu7Yw5/MTMHV6Kx4Opl8+KAGfcZ1Tro=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m9To6Szz1QEXaLLXWS/KGkwjRZGlbvfUoROIJS177Fy82C4CdI7uuFsY06Ez/AFDs
         0coXrgqEF/RiknDacCwOaxs7q3ld32GLTRvv0KQctmtnObHxrEN89DBm7fecPMPw2v
         KIG+++VZfZItIJ4gjNPAczKvs4n44YFhQdF3yHo0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAL_JsqJRJp8a_sytr2C_18muxt4ehGQRdfu8n8J70HdRz-gFHw@mail.gmail.com>
References: <CAL_JsqJRJp8a_sytr2C_18muxt4ehGQRdfu8n8J70HdRz-gFHw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAL_JsqJRJp8a_sytr2C_18muxt4ehGQRdfu8n8J70HdRz-gFHw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.3-3
X-PR-Tracked-Commit-Id: 83f82d7a42583e93d0f0dde3d61ed10f75c0f4d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b245b8b033a90c6373400a29ec93a8713601eff
Message-Id: <156588630528.19165.11370971071369925979.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Aug 2019 16:25:05 +0000
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Aug 2019 20:34:37 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b245b8b033a90c6373400a29ec93a8713601eff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
