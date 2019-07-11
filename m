Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E50665F81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 20:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfGKSfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 14:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729042AbfGKSfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 14:35:07 -0400
Subject: Re: [GIT PULL] clone3 for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562870107;
        bh=F2k0I3YJr1cB+GClQEeL2TgwA20r6xaiCbx0tiNOvwY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JLJh5lqdxz70+igfz7K4pZ8d+rgY8IaPdN3cKVDmJtdYA0nWgj/jVOiaYXEimG/mi
         kCLNwAC/T797KXM1jmz19/uyAP9v14r5adKxG/iBDheot5bb+u0ERkU/y0grhIr16s
         QolIZ2VPQzqTc8SjWoQyL1CyswJcDcaSfSi0iiKk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708150042.11590-1-christian@brauner.io>
References: <20190708150042.11590-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708150042.11590-1-christian@brauner.io>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/clone3-v5.3
X-PR-Tracked-Commit-Id: d68dbb0c9ac8b1ff52eb09aa58ce6358400fa939
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f6ccf6159aed1f04c6d179f61f6fb2691261e84
Message-Id: <156287010730.13847.13561875228958547242.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 18:35:07 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  8 Jul 2019 17:00:42 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/clone3-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f6ccf6159aed1f04c6d179f61f6fb2691261e84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
