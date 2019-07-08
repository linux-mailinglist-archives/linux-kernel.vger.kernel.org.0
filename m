Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA645625DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 18:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388646AbfGHQLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 12:11:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52059 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbfGHQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:11:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so97808wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0YfI9ulneYjIAaJNmJ8mTywngdZ+lHgD4fcT0tv/HX4=;
        b=KuJxlfGSU5CrH+UyUj3RrfYszPQdIS+qFBc/8q4LZQFsF8gr3fI1k06KNU/flDpO0Y
         OaPUT7gkE+8A837BzZzqiJNoo/JaocYLjTEQmysD6qqRuASRcarZ8/YncjTdzagwHM3F
         rBYcovuoG3gyfSMlmk7Onz3hc4rRxg7/waa1sXtgkaIhE42q6UAZJDyCi1Y9wrk5r/JF
         mGTncNPvrZJMVePCOUOMNGhOnqMQUPg5dzC6Nm/tU2Qobl6p8cSYGeJfKucToh43Ng3U
         pcCzYYa1FfV+ouprsLMvwi0tK+bQQkxFFbyghY2AJkmBS6IwtOMLYacVYUB4cNhqcrVa
         EesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=0YfI9ulneYjIAaJNmJ8mTywngdZ+lHgD4fcT0tv/HX4=;
        b=nAT5aCdF315had+XT3ADLZQl2zal9dSN1zpjy97Ioiv8DQ9DdSAxRsByU+KFZSofOL
         qLHL3Tyc9yKTLjvlXV0zRavvD8NCmH/LAGHWmFDZIKNR/0bjVNdwDyV6azqS5SG3qQv0
         pX60Ux5iBxSCc/AjFMqRfr5w2dh1V5zMZDSoJRQYpFgvq3AWjo67o7Cb09Nf7YKVoe06
         DAmbhP+rvi1m09y0jJG3cADydWzA/ZxT7AXeAAk0HE4LSaJcVFxLOcBgYJZvOTNrHojl
         EW7iAk4RfbS+otuqGFGcXp9EwoS+zSTLTEsmHvTSZ0xj3fiVES0oJk24JM5p9BcYBD6v
         bO0g==
X-Gm-Message-State: APjAAAUcsrIoE85GlKcc3nYv3jTJ1++sTJ5Ls6M8t6qN5C7b1Dsm5Jer
        Yu+nDiLsGg92ULPeiIPK03M=
X-Google-Smtp-Source: APXvYqzPSP9SkpEHuug5qKqst+jRHha9sIk0sCJ3FTpsskyruj5gpiRwAlffmfG+JrPW6rJ8PPST1w==
X-Received: by 2002:a7b:c398:: with SMTP id s24mr17777923wmj.53.1562602304553;
        Mon, 08 Jul 2019 09:11:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f204sm28747wme.18.2019.07.08.09.11.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:11:44 -0700 (PDT)
Date:   Mon, 8 Jul 2019 18:11:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/core changes for v5.3
Message-ID: <20190708161142.GA107326@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-for-linus

   # HEAD: 711486fd18596315d42cebaac3dba8c408f60a3d Documentation/filesystems/proc.txt: Add arch_status file

This adds a new ABI that the main scheduler probably doesn't want to deal 
with but HPC job schedulers might want to use, the AVX512_elapsed_ms 
field in the new /proc/<pid>/arch_status task status file, which allows 
the user-space job scheduler to cluster such tasks, to avoid turbo 
frequency drops.


  out-of-topic modifications in x86-core-for-linus:
  ---------------------------------------------------
  fs/proc/Kconfig                    # 68bc30bb9f33: proc: Add /proc/<pid>/arch_s
  fs/proc/base.c                     # 68bc30bb9f33: proc: Add /proc/<pid>/arch_s
  include/linux/proc_fs.h            # 68bc30bb9f33: proc: Add /proc/<pid>/arch_s

 Thanks,

	Ingo

------------------>
Aubrey Li (3):
      proc: Add /proc/<pid>/arch_status
      x86/process: Add AVX-512 usage elapsed time to /proc/pid/arch_status
      Documentation/filesystems/proc.txt: Add arch_status file


 Documentation/filesystems/proc.txt | 40 ++++++++++++++++++++++++++++++++
 arch/x86/Kconfig                   |  1 +
 arch/x86/kernel/fpu/xstate.c       | 47 ++++++++++++++++++++++++++++++++++++++
 fs/proc/Kconfig                    |  4 ++++
 fs/proc/base.c                     |  6 +++++
 include/linux/proc_fs.h            |  9 ++++++++
 6 files changed, 107 insertions(+)

