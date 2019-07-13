Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D5867AB8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 17:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfGMO7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 10:59:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46444 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfGMO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 10:59:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so12697547wru.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xmdUDnhWJVovmByVoh8W0nHbRzDTU6bE3u0Nvyxwtbo=;
        b=1yJBr/TlTwB1USdmoac+6WLgPef4V0EyO1yqmAUzf/v6NSbsTlyC8AxCM3llEYRMoZ
         cQt0gZkJ6hA97c3/Wi1y+hol4ja7bQ2t4/Apc51k+HrF5GZyzsBaDDo6TgBOiuK5LTnS
         2dqayVAQyc36Y6vrjUuNsuWUthwoOr9uhffFyUXdXjYKV4m2+2rmrM+7c2DUGfJhJdjz
         XJHt2wima4MV/K/KIR+tfOZvtvSmnVyxaMAZRVbtaNQFY2eLaXuAeNM7+ipwaBcsSWrx
         zOkE345L/fPOGwZ3EmdFKTszdW0Qis/Q4B3b/lRlcBzFe/80asztlmnA2C92QovMTGys
         PnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xmdUDnhWJVovmByVoh8W0nHbRzDTU6bE3u0Nvyxwtbo=;
        b=N14U2eYBfvwrFR/vo+o0UKjgd21dB+mLeuPAFETsat8a72wFaG9SXTWczppYDS6WfP
         NGwAhCgqvpC3D64T2jbHlMJ9jMo3bewHoJOoJlDmV8lDJcRMueZHaVpcW3n3qwpPPcun
         pNfFUehcPdymPtZeVV+4YN43ux7ZSFKtpI/Q6zR+Nmlv3YFh4MNRL2TFu9qHAr9feNEU
         Ib9Yx6DbCwOtiLbnyZT9NutqJcMK2ff+UVI5Q7ZpQjR+zoLjuQjUyHErXU5b5YcbiFaQ
         ReAKfBtoBk+SjLrL9tVrc/wIF6Tc0T5I8C5ocwDRotkuJ8vo2LJfX+lc3bgLfqk4Dhtp
         GlSQ==
X-Gm-Message-State: APjAAAXfSRGBo2EzxxSnTQ5Ipgi6nBBZx5LZFg63KF72JYBKSiwX+XyT
        jgHRCmczQTbi3mG+rG7xKMqW2T6tnqM=
X-Google-Smtp-Source: APXvYqyuOTqDDaoRk/O+sKZuJHRXrxGoEJ+hMe/XYFAiQn+mjCGhYrKXmOxmEzJnevFQQufSIxqIGA==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr17378161wrr.5.1563029973866;
        Sat, 13 Jul 2019 07:59:33 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:f40e:900::64c])
        by smtp.gmail.com with ESMTPSA id g12sm16148820wrv.9.2019.07.13.07.59.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 07:59:33 -0700 (PDT)
From:   Mike Lothian <mike@fireburn.co.uk>
To:     thomas.lendacky@amd.com
Cc:     bhe@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        lijiang@redhat.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org
Subject: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be reserved
Date:   Sat, 13 Jul 2019 15:59:08 +0100
Message-Id: <20190713145909.30749-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <7db7da45b435f8477f25e66f292631ff766a844c.1560969363.git.thomas.lendacky@amd.com>
References: <7db7da45b435f8477f25e66f292631ff766a844c.1560969363.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This appears to be causing issues with gold again:

axion /usr/src/linux # make
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  VDSOCHK arch/x86/entry/vdso/vdso64.so.dbg
  VDSOCHK arch/x86/entry/vdso/vdso32.so.dbg
  CHK     kernel/kheaders_data.tar.xz
  CC      arch/x86/boot/compressed/misc.o
  RELOCS  arch/x86/boot/compressed/vmlinux.relocs
Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
make[2]: *** [arch/x86/boot/compressed/Makefile:130: arch/x86/boot/compressed/vmlinux.relocs] Error 1
make[2]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
make: *** [arch/x86/Makefile:316: bzImage] Error 2

Here's the version I'm running:

sys-devel/gcc-9.1.0-r1 
sys-libs/glibc-2.29-r2 
sys-devel/binutils-2.32-r1

Cheers

Mike

