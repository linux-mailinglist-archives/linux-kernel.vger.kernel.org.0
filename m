Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608385D540
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 19:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfGBR2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 13:28:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38611 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfGBR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:28:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so17753007ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=a0+afBeFhXMaSDxEXuOeB1KzgbW6mX8UltDVbEoXcC0=;
        b=m7rTfVa3GhKeyQ1tRHrfNrMSFYuDu7GJwEl2I8ZuQW275CgGZ1b5kmqwNchjZxNVUz
         Z3/tpQA+vn/rY37OkxEty2h5lfcc4iFSQ+Qvd2H8Y+2kAgKxI6/JH+XbTvbeMEzRhq9H
         6i46/wS7jgLZhBeqCIHIfz8LmkyBBOQ6gLfDUtZ7Qk6vU32G7GhJh1DMVKsFgGX6X4Pv
         oHlmwqRSO8d7E0D6QRwEKbrbhqrl1Gv927x2QrexmySa0Qvz2vQY88xysgBeUTqbUa2O
         jiIIEH4hS6oBddwyzaxlo/aRP8JGqGWD2GTVfgJEDREV5WuHwg/FRlaJGZ8JOb0jxbyJ
         4QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=a0+afBeFhXMaSDxEXuOeB1KzgbW6mX8UltDVbEoXcC0=;
        b=l2ybSyP7wBaqk9V2GpW9nsFzcwGZy8fxKyDNPrge/4r9Q6nR6mYkjYsevx1LxFAEo/
         7WuGv3h5dS4VE5k4kLmxwHM3EQD0CmzbC98ULe/txouVbJGxvFQILqPbNEUCySqpdzfr
         tF56ZIGCuuRf4/eIssoxObwgCEpxOqUZxh/8OWEss+nTUMu5JHFyI0ItddAjihGmIyqZ
         wKk58sjTajQP0MG/VOs1xpcyp60e0FhCFIMPwDn10ZmqB9L2CsuVp56EwVL03ST6Karj
         iUAud19gMSx9X/H2CboiQkQZ8ezfzHvfR70A+4tj8HZXvdiyArI4OtkcO7MW8NjOvAsi
         5IEA==
X-Gm-Message-State: APjAAAVC0yF+kztezvIWYJRsxc789F0NOyPRxcauvhZiAwK+Su5300Fi
        nYzqxe5jv561BhMpUSJgK0jXyEGScIOS4lac/60F
X-Google-Smtp-Source: APXvYqyJx55tXOysFh5O10sG7PB2CO7dlcMfdmcjMB52mnL5E3vkpkQXx9TgV2Li3nPU5lrlR3PvSldFb+Qu4UAotD0=
X-Received: by 2002:a2e:86c3:: with SMTP id n3mr4206972ljj.129.1562088527957;
 Tue, 02 Jul 2019 10:28:47 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Jul 2019 13:28:37 -0400
Message-ID: <CAHC9VhSERNCM2d42y8fBT236D62mco=B_ZM_vytEoBP1qicvCA@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Like the audit PR this is a little early due to some upcoming vacation
plans and uncertain network access while I'm away.  Also like the
audit PR, the list of patches here is pretty minor, the highlights
include:

- Explicitly use __le variables to make sure "sparse" can verify
proper byte endian handling.

- Remove some BUG_ON()s that are no longer needed.

- Allow zero-byte writes to the "keycreate" procfs attribute without
requiring key:create to make it easier for userspace to reset the
keycreate label.

- Consistently log the "invalid_context" field as an untrusted string
in the AUDIT_SELINUX_ERR audit records.

Please pull this once the merge window opens,
-Paul

--
The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

 Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190702

for you to fetch changes up to ea74a685ad819aeed316a9bae3d2a5bf762da82d:

 selinux: format all invalid context as untrusted
   (2019-07-01 16:29:05 -0400)

----------------------------------------------------------------
selinux/stable-5.3 PR 20190702

----------------------------------------------------------------
Nicholas Mc Guire (1):
     selinux: provide __le variables explicitly

Ondrej Mosnacek (2):
     selinux: remove some no-op BUG_ONs
     selinux: fix empty write to keycreate file

Richard Guy Briggs (1):
     selinux: format all invalid context as untrusted

security/selinux/hooks.c       | 11 ++++++-----
security/selinux/ss/ebitmap.c  | 10 ++++++----
security/selinux/ss/services.c | 33 +++++++++++++++++++--------------
3 files changed, 31 insertions(+), 23 deletions(-)

-- 
paul moore
www.paul-moore.com
