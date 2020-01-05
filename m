Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19D87130572
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 02:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgAEBgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 20:36:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34574 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAEBgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 20:36:52 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1inuqY-000172-Jo; Sun, 05 Jan 2020 01:36:50 +0000
From:   John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] apparmor bug fixes for v5.5-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Organization: Canonical
Message-ID: <cbec7335-39b8-6b7d-402b-a6dd467b492b@canonical.com>
Date:   Sat, 4 Jan 2020 17:36:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you please pull the following bug fixes for apparmor

Thanks!

- John


The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2020-01-04

for you to fetch changes up to 8c62ed27a12c00e3db1c9f04bc0f272bdbb06734:

  apparmor: fix aa_xattrs_match() may sleep while holding a RCU lock (2020-01-04 15:56:44 -0800)

----------------------------------------------------------------
+ Bug fixes
  - performance regression: only get a label reference if the fast
    path check fails
  - fix aa_xattrs_match() may sleep while holding a RCU lock
  - fix bind mounts aborting with -ENOMEM

----------------------------------------------------------------
John Johansen (2):
      apparmor: only get a label reference if the fast path check fails
      apparmor: fix aa_xattrs_match() may sleep while holding a RCU lock

Patrick Steinhardt (1):
      apparmor: fix bind mounts aborting with -ENOMEM

 security/apparmor/apparmorfs.c |  2 +-
 security/apparmor/domain.c     | 82 ++++++++++++++++++++++--------------------
 security/apparmor/file.c       | 12 ++++---
 security/apparmor/mount.c      |  2 +-
 security/apparmor/policy.c     |  4 +--
 5 files changed, 55 insertions(+), 47 deletions(-)
