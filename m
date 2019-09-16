Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A5DB3B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbfIPNgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 09:36:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36736 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfIPNgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:36:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id t3so10442297wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D8kLvyH/OXn+ibww+vsUGpG0WVaMoA8C4bNES7Vdks4=;
        b=PVOTFpuFbj/ezQJ6JAIVgE6mcZQoKkgEvPWpZ7QzoRxb357HCu7YWm8zRNgxTg+0Pb
         kfB2/zHOH3q4kyYVtBVVxxTlyOnbQoghaFBr9ItFVq714HIarmeNzs5aNG2JHQUmYjzh
         E9f45HLy51jgfMwe2MzsTiUTgfrdbEwuGmkoOTRc9TQHC+I9OBrBq6mUmPTV5ePJQRpW
         BP0sEhkXSnoQ6WZy2DWddWyPa1DTeGjRjmj4f/gVQ4CUNJYFVoesVO3xozQvy92DttJu
         K/Al9a+r0z8bznedmOcETGrkxhJC5OPEnVklDUnYoa6VoNGnWjNfckKvXHde9c8qaJ/K
         j3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=D8kLvyH/OXn+ibww+vsUGpG0WVaMoA8C4bNES7Vdks4=;
        b=BWJ7dJPIl85L+8HKHESqPcNfI/uRlIfgT3Hz0zegg/rWSgYNgLIrIhByEg6EdzMBHk
         zdtA6AdMHyjZok8TxtZ4V7Re56Cerl6gbXka5VRCtauuzN6KQ198c4CrTltdEPfyqbHd
         YhkhSdgp3Ql2J3Vpav//k4UjbDooqoc42X1wmMP7+rxKG71YXLTb9RLqRT5MeMZvczyQ
         FpHVwrSI8jrMy4B48mIwlflXG4Pb49quVSgFUwehWki1BEcIlhRcKAlreOvaWkNbFZ7v
         A0YdFV+QpxL+obkcAt+56IBNjRmiDnll6kTFzo3bTfA2XGVa8sSrLvHkwf7xRBRPk+eo
         VyJA==
X-Gm-Message-State: APjAAAXa/6+dtSsIZz5TjKtJh+49N1UM/mBNopKkTXjonZDFgX9ZblVR
        AwsQ+HR9BPqNW9OWmVSROBNTYpDJ
X-Google-Smtp-Source: APXvYqyWDH7ioTbOouM6fvCtb3qF4WRXIJgKTkQT1T1uZCJaI2aBrcEbJ7k0WQ/8i7xFcFawcqiDUA==
X-Received: by 2002:a1c:7902:: with SMTP id l2mr13988415wme.55.1568641008516;
        Mon, 16 Sep 2019 06:36:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w4sm8462369wrv.66.2019.09.16.06.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 06:36:47 -0700 (PDT)
Date:   Mon, 16 Sep 2019 15:36:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/vmware changes for v5.4
Message-ID: <20190916133646.GA112398@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-vmware-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-vmware-for-linus

   # HEAD: f7b15c74cffd760ec9959078982d8268a38456c4 input/vmmouse: Update the backdoor call with support for new instructions

This tree updates the VMWARE guest driver with support for VMCALL/VMMCALL 
based hypercalls.

 Thanks,

	Ingo

------------------>
Thomas Hellstrom (4):
      x86/vmware: Update platform detection code for VMCALL/VMMCALL hypercalls
      x86/vmware: Add a header file for hypercall definitions
      drm/vmwgfx: Update the backdoor call with support for new instructions
      input/vmmouse: Update the backdoor call with support for new instructions


 MAINTAINERS                         |  1 +
 arch/x86/include/asm/cpufeatures.h  |  2 +
 arch/x86/include/asm/vmware.h       | 53 +++++++++++++++++++++
 arch/x86/kernel/cpu/vmware.c        | 94 ++++++++++++++++++++++++++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 21 ++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h | 35 +++++++-------
 drivers/input/mouse/vmmouse.c       |  6 +--
 7 files changed, 163 insertions(+), 49 deletions(-)
 create mode 100644 arch/x86/include/asm/vmware.h
