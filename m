Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DEE49875
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 06:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfFREzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 00:55:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41672 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFREzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:55:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id 83so6964134pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 21:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fASSq0Wc774NJxzj3o2gVuE5L9Puh7p/qKeMYZ6n7cI=;
        b=kfXDN39x37u2gUdXh+31TVmw16KUbhKiGXOUmJK5IjvAQyqqoQGsF+yxC7w6YsYspo
         YdKYEmiFvEROnpcEaCue7cQjW/ReQiiP8z3EhSEYK8o8dzSJrngcUUMOH5G1jQibPf+U
         at0UlIUZFTfO7GkFUTJI6I7V89g/bXLxrdJ7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fASSq0Wc774NJxzj3o2gVuE5L9Puh7p/qKeMYZ6n7cI=;
        b=IYjZpBtv7gIjztT7+H+nSxznapZu8dv0OMJ4t3VTCr5NIvYLM7LLZ9WmjLkdZbRms7
         byxamejEXqD/uStB1SYI76XycOonl+cpfBlVfWlzYrzTaGrRgjRGjMJTLeMPDb4XJXfc
         DwqX+nyauf/ne2pYLihKuoJGp+ssbWYNSdTArLBjoOrL+s3GyyI6clsf66FiB8m3aUBQ
         LLUzfwSj5nEcGkVFSuSCQVU1ReVK7pjENPdNU1voSboR9hElFsbovMN2iJyZlYP/5zOW
         ahL7A3uqybfnIgE9SZ+gTXxobpW2h8g8pd3WcOXaXTb8oC2GisCWnNxrhgYboTa5Ic8U
         UkEg==
X-Gm-Message-State: APjAAAVgRst8qVqIubm9adkXUiq78B6fJbBLfVNKmiBuLlaprwrETY8i
        wIIr3LIM8n9CFimur/LH5AwHUw==
X-Google-Smtp-Source: APXvYqzQ6ivjg+w9Tcb/dlwC09AhFIwKHfALRY+f+pu5Z7NUCBWf3NtYl2A0C3qWH168n0z7jQNATw==
X-Received: by 2002:a63:905:: with SMTP id 5mr863624pgj.173.1560833707635;
        Mon, 17 Jun 2019 21:55:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f7sm11967580pfd.43.2019.06.17.21.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 21:55:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH v3 0/3] x86/asm: Pin sensitive CR4 and CR0 bits
Date:   Mon, 17 Jun 2019 21:55:00 -0700
Message-Id: <20190618045503.39105-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This updates the cr pinning series to allow for no silent papering-over
of pinning bugs (thanks to tglx to pointing out where I needed to poke
cr4 harder). I've tested with under normal boot and hibernation.

-Kees

Kees Cook (3):
  lkdtm: Check for SMEP clearing protections
  x86/asm: Pin sensitive CR4 bits
  x86/asm: Pin sensitive CR0 bits

 arch/x86/include/asm/special_insns.h | 37 +++++++++++++++-
 arch/x86/kernel/cpu/common.c         | 20 +++++++++
 arch/x86/kernel/smpboot.c            |  8 +++-
 drivers/misc/lkdtm/bugs.c            | 66 ++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c            |  1 +
 drivers/misc/lkdtm/lkdtm.h           |  1 +
 6 files changed, 130 insertions(+), 3 deletions(-)

--
2.17.1

