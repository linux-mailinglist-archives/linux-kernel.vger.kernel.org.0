Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2338F13D445
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 07:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbgAPG0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 01:26:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40882 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbgAPG0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 01:26:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id s21so7892447plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 22:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgsZ87j9zhFzITBOLkD7Zx7YPDB2pB7wEvRvkLTLK58=;
        b=oNmexNcVAh+3e35uSrHwMbT1gEdNtfFt+AsrrtqPXQmSRoQ2+dPRtMo5LTrIw10hkD
         u+AKJkLOQ7ejO/lyaa6mLr7Bws1hotDPmNsiYytrmcuCElg5p/2U1uo544G1s8tNj3oi
         67cF7zBrygv/ffmERc13Rw9w/bQ1CKyQ31T20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgsZ87j9zhFzITBOLkD7Zx7YPDB2pB7wEvRvkLTLK58=;
        b=AaJ/MOBDaLbEanEEnXyU3WJK++/UbyJ2rAxMn7ZIxK3MyAU6EYC+ooGvwmdoV7K8Md
         Ts503PrwenkeDj3WuEHP1DVi9gLUFa0EJ/jiu3Da65dGGOPD69YOBJnazMPATbVMrn06
         OsL/DV7l7aUf50YpZzLHi8G7k5GFDBfOfsezaSRt7eiPFeGrrayy9fsRr++v4RvEmJCH
         vR8lqlOxMc+7Fv/eVc0yiP4nGn3e7WdVcexks+cjeTl3uCW7CvfVfWGzXyuAAq3B6cgt
         UQSq2agfVW56+0p0nghu0dk25Fsf6WYNknaUnWSyIpHfMkAYkcPAj4b2XknZjW0gPTjc
         isCg==
X-Gm-Message-State: APjAAAUZ4/NpFgQpwB3v1+5IrZj6WabNRCxhtUNe7HaEDVGdMIoAnweS
        g3hEFxfQLZWeYG59tmnvex/2GHgRTdM=
X-Google-Smtp-Source: APXvYqxr6t7CheZI96TYjHdF4c+2lQSa9v9KFUkO88U4heoEGDZYaqbW2enLJb4tzmBEKZ7QkJrRRA==
X-Received: by 2002:a17:902:9307:: with SMTP id bc7mr29877693plb.338.1579155990819;
        Wed, 15 Jan 2020 22:26:30 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-097c-7eed-afd4-cd15.static.ipv6.internode.on.net. [2001:44b8:1113:6700:97c:7eed:afd4:cd15])
        by smtp.gmail.com with ESMTPSA id c68sm24184007pfc.156.2020.01.15.22.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:26:30 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org, dvyukov@google.com,
        christophe.leroy@c-s.fr, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 0/3] Fix some incompatibilites between KASAN and FORTIFY_SOURCE
Date:   Thu, 16 Jan 2020 17:26:22 +1100
Message-Id: <20200116062625.32692-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3 KASAN self-tests fail on a kernel with both KASAN and FORTIFY_SOURCE:
memchr, memcmp and strlen. I have observed this on x86 and powerpc.

When FORTIFY_SOURCE is on, a number of functions are replaced with
fortified versions, which attempt to check the sizes of the
operands. However, these functions often directly invoke __builtin_foo()
once they have performed the fortify check.

This breaks things in 2 ways:

 - the three function calls are technically dead code, and can be
   eliminated. When __builtin_ versions are used, the compiler can detect
   this.

 - Using __builtins may bypass KASAN checks if the compiler decides to
   inline it's own implementation as sequence of instructions, rather than
   emit a function call that goes out to a KASAN-instrumented
   implementation.

The patches address each reason in turn. Finally, test_memcmp used a
stack array without explicit initialisation, which can sometimes break
too, so fix that up.

v2: - some cleanups, don't mess with arch code as I missed some wrinkles.
    - add stack array init (patch 3)

Daniel Axtens (3):
  kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
  string.h: fix incompatibility between FORTIFY_SOURCE and KASAN
  kasan: initialise array in kasan_memcmp test

 include/linux/string.h | 60 +++++++++++++++++++++++++++++++++---------
 lib/test_kasan.c       | 32 +++++++++++++---------
 2 files changed, 68 insertions(+), 24 deletions(-)

-- 
2.20.1

