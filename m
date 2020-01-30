Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4194D14E058
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 19:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgA3SAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 13:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgA3SAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:00:15 -0500
Subject: Re: [GIT PULL] Devicetree updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580407215;
        bh=cusQbFWMTnL3Rh1oiIOqngTNbqxWXXjtJnQYo60AcAs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j3pHpRXYQlroO0Lg6ndy3Ngu/mFpqiaAl1hIgnyVKVik+yTkH+HioxUjqvZPJOkcz
         8lL4g+WGbtGWbNeoVMQ3bI8ZxWiuywyFZG34Zdj68z3c50i02LJ70tBVLhCftg1QIn
         NHgfR5sbU0aR3D1/VvdaoGVG+L73Ge3chWRhgYOE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129210736.GA29551@bogus>
References: <20200129210736.GA29551@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129210736.GA29551@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-for-5.6
X-PR-Tracked-Commit-Id: e9a3bfe38e393e1d8bd74986cdc9b99b8f9d1efc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 893e591b59036f9bc629f55bce715d67bdd266a2
Message-Id: <158040721497.2766.9176226336933567028.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 18:00:14 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 15:07:36 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/893e591b59036f9bc629f55bce715d67bdd266a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
