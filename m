Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB21E198D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 09:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgCaHxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 03:53:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39994 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgCaHxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:53:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id u10so24638803wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 00:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qm1wbxYI4abwRfoFmKlOWUMampCo+IRgCWIazrzvwlE=;
        b=hYg80fO/gfwWvMwj5SVh+6dazFrKKh87Z/3d8kmdnNxcJbl/jp+bjznaZO4UyTdUr9
         DyECSCqilkAc7BmXF4viw4bGgNodHsjPubP7/ZkZjF7plhOKcrCGhdF3Ma9CiFObUafc
         INGNG04/B6YuOPWgs0fKLWKJpw5B6u0E92WbaV7XZD2GMM5FK27aMlk33yXk7exz4mVb
         LHCoVfmLZtHiuGwNWNz+w0xHNxigdPSVtG5OqwKncrHptqUByx/Gbu++AS+saNkLFPeJ
         a4uMw7kalXukDNjby02pC6x0x40MV7s3R3bWH48XpwkCo+MBS41bAgm88u9Bxpw2Leam
         UOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=qm1wbxYI4abwRfoFmKlOWUMampCo+IRgCWIazrzvwlE=;
        b=AptHPoV6z9UEbVyutTwNdtr4P7lLUZgEoXIxcXjOyBViayvK0vtkV22YBx0cy9XsiU
         7YjSVTjqq+lCHbh9Ub8O9wUoaJOwdmfsGn00tnicXIfzl9UXyu1zU+vEXMIHezBLOxSd
         yRi1SvGdfWGyjDhYnRgxiVTUa441DMqPcTkdaBCxtd4/wNLjVZWgwiqs+GzU0vS7L9yI
         VnoIZwM7xaShzSxD3eXIyxw7zD01Gru6CxYpWwwOyHRNnPkvCayOKJLhE0t6GNJv9xev
         OchlXlGRhv0x/8qT/GmK1VlulyDj8pn/HL11Qs6tCeazvAIKu1D79uiqmX+pgM2KMk8W
         Vtqg==
X-Gm-Message-State: ANhLgQ0cNOB5cyw4gQWKuSQdbZ65JQrx+2HPkrFupBCMKifqn/TDEkeJ
        m5sYeEIFJgF8VPDuYQpuXe4=
X-Google-Smtp-Source: ADFU+vv3J/gSIs83hhkakSmZoECv9LiMkUd6jz1znC6BxOg5dQR4sK8960WF5Gb8M1ligB5dqzzO6Q==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr18709106wrw.407.1585641188186;
        Tue, 31 Mar 2020 00:53:08 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f12sm21916992wrm.94.2020.03.31.00.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 00:53:07 -0700 (PDT)
Date:   Tue, 31 Mar 2020 09:53:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/boot changes for v5.7
Message-ID: <20200331075305.GA57035@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-boot-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

   # HEAD: c90beea22a2bece4b0bbb39789bf835504421594 x86/boot/compressed: Fix debug_puthex() parameter type

Misc cleanups and small enhancements all around the map.

  out-of-topic modifications in x86-boot-for-linus:
  ---------------------------------------------------
  drivers/firmware/efi/libstub/Makefile# 003602ad5516: x86/*/Makefile: Use -fno-asy

 Thanks,

	Ingo

------------------>
Arvind Sankar (6):
      x86/boot/compressed/64: Use LEA to initialize boot stack pointer
      x86/boot/compressed/64: Use 32-bit (zero-extended) MOV for z_output_len
      x86/boot/compressed/64: Remove .bss/.pgtable from bzImage
      x86/boot/compressed: Remove .eh_frame section from bzImage
      x86/*/Makefile: Use -fno-asynchronous-unwind-tables to suppress .eh_frame sections
      x86/vmlinux: Drop unneeded linker script discard of .eh_frame

Guenter Roeck (1):
      x86/setup: Fix static memory detection

Joerg Roedel (1):
      x86/boot/compressed: Fix debug_puthex() parameter type


 arch/x86/boot/Makefile                |  1 +
 arch/x86/boot/compressed/Makefile     |  1 +
 arch/x86/boot/compressed/head_64.S    |  8 +++-----
 arch/x86/boot/compressed/misc.h       |  2 +-
 arch/x86/boot/setup.ld                |  1 -
 arch/x86/include/asm/dwarf2.h         |  4 ++--
 arch/x86/include/asm/sections.h       | 20 ++++++++++++++++++++
 arch/x86/kernel/setup.c               |  1 -
 arch/x86/kernel/vmlinux.lds.S         |  7 ++-----
 arch/x86/realmode/rm/Makefile         |  1 +
 arch/x86/realmode/rm/realmode.lds.S   |  1 -
 drivers/firmware/efi/libstub/Makefile |  3 ++-
 12 files changed, 33 insertions(+), 17 deletions(-)

