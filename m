Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BB6147A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 10:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgAXJR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 04:17:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39864 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgAXJR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:17:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id 4so709449pgd.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 01:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FFs/EsdtRscf8mrY/Jnn+OFoGxG7CxqnjEoCeXl2Nps=;
        b=G4Cbvo9JI2cOaoZ6s2snBtga4+6+zZ+SvltXUrVS9l2l0ftyHUrsFQBF5pip5iYmTQ
         RmT6PoG48wReiyER4H92O0wJC/aLoWEvH+SW3hzCxtOpJFbejVmFC5BsD1cMjGbyKJcp
         alEdqeIiup81GNvrnPtLSqvYYHW646cUh/DdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FFs/EsdtRscf8mrY/Jnn+OFoGxG7CxqnjEoCeXl2Nps=;
        b=jQYl+P0+t9tQ49wZRYT04OCaVSkQT4uF+W5fm3DclZxI4GIBUJmxIFP1mBsEChIPw2
         gSoQL3XXmBzQ5w49BfrxFMwO8JILuINuyPcfiash9/PajfJ8L5ptYmYbozhQkw1mDG8L
         mCuhsqc4D8h+rXvIdGdKX6TNl0tmjXATTRpVxuAh4rzg8Bg9s5zjSqNKtK2LoYSeXR4k
         NXcuu0IEwW5Z+kvTk7Jr+qOYiWZnpkAviQ19e8YJxczr+Xb8EffQ322zBSbESO55KH/x
         AvDW2EjdDXW1vJudPNNL+WKg609o2vai2b68WfsCvLupw55dawBIYhqtjetCc+yTtKF8
         XvvQ==
X-Gm-Message-State: APjAAAXF7/RPn3OQkc8N0OIO+uN2BiQ+AUfIKYEnmISBdjDWV3z6FcXm
        cd+3Rd8y7rdKM3u0XOgjR6Isp6qvj/Gwbw==
X-Google-Smtp-Source: APXvYqzLdYRkEKsSqDWOYv8GoFK+AQpSZfH5CoQU2dOQbZHX4rkib4veekPke6G0fxy+dn+UfaXSuw==
X-Received: by 2002:a63:946:: with SMTP id 67mr2925580pgj.277.1579857477139;
        Fri, 24 Jan 2020 01:17:57 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id y14sm5459507pfe.147.2020.01.24.01.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 01:17:56 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        christian.brauner@ubuntu.com
Subject: [PATCH 0/4] Add the ability to get a pidfd on seccomp user notifications
Date:   Fri, 24 Jan 2020 01:17:39 -0800
Message-Id: <20200124091743.3357-1-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the ability for users of the seccomp user notification API
to receive the pidfd of the process which triggered the notification. It is
an optional feature that users must opt into by setting a flag when they
call the ioctl. With enhancements to other APIs, it should decrease
the need for the cookie-checking mechanism.

Sargun Dhillon (4):
  pid: Add pidfd_create_file helper
  fork: Use newly created pidfd_create_file helper
  seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get pidfd on listener
    trap
  selftests/seccomp: test SECCOMP_USER_NOTIF_FLAG_PIDFD

 include/linux/pid.h                           |   1 +
 include/uapi/linux/seccomp.h                  |   4 +
 kernel/fork.c                                 |   4 +-
 kernel/pid.c                                  |  22 ++++
 kernel/seccomp.c                              |  68 ++++++++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 110 ++++++++++++++++++
 6 files changed, 200 insertions(+), 9 deletions(-)

-- 
2.20.1

