Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA02A94E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 23:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfIDVXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 17:23:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45640 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfIDVXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:23:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id l1so152812lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y0/K/3NHW2BoW66hjF3E64lXnccuPIx+Txfbqzf3jL0=;
        b=e4KCsujIe59XNJPsOgxhHEmYvS6Ir/WAdxo1GJhGHE/R3+AjBK2RgqtyTX3IZyINrf
         SRreCzQZEnn0Yq8Wtj1O65F1SFMziACSlVSQCqda7Bh2FAcpMMUbrNGrjCaBJj9Zs4Ib
         OuBXJPEFa3+9pMFMo7zbfu76utYP3aIKNBrbRWQ6M+zBO7HmbHg4RrESIbDQapxTQ+c1
         hLH3lRY0zxCVAUmNOE73sfln/v46G/JKY5aY8q8Ida9BNUwgRAlBkTpd99zCRrZURLSt
         00nL2H4XqV0cpyNBcr7DamsSvkZTS5zQmVLP7Iqc+4QDVhEp+crY/7PKZWNKycVzq0V2
         fkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y0/K/3NHW2BoW66hjF3E64lXnccuPIx+Txfbqzf3jL0=;
        b=DgMv7dSDSWvYP7TiUZWas/s47qKsaurYrixvUd3XABqyWhH+j2whidjtvb9ADI2qli
         Ura/iqSiHGifS2ra3oHs1iOE3fyStTDIlB9cUSePIFMnkUprc2buzilA0MwXZNEGNMwd
         RWYF9aQXMvPQ/NpuAZtTfhv+PKT9g+nHz2diLdZF2gMDtYWTBnjt8sdYc2WbntvilEKN
         QG+5zKkKm4ae+mrIGr+bKojH/DMEHi1Ll4/wKvmHqrWJQmCMizXLuk3Puo6fvIS0uzP/
         fvCIw0DsU7AnPi0fg+EWSoyY+evAwJE3REL4lgySjszDZbM6At+Ofu2mnkC/5TrDlyXM
         xH2Q==
X-Gm-Message-State: APjAAAVfKLQGtgrlgSCdH3h3AaWo7IBuu/NyZioIyjoLsWBxr61ebdy+
        HeAb0oceanXrQ/xOrBcKTnm//g==
X-Google-Smtp-Source: APXvYqxRpzRoAAkk3MuHOz0pYKzdu098OV1QWuP6crUl1RenkK0czy8yKZ2lfl5cQtYl5dgLJMMYOg==
X-Received: by 2002:a2e:9882:: with SMTP id b2mr3706041ljj.225.1567632181203;
        Wed, 04 Sep 2019 14:23:01 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id s8sm3540836ljd.94.2019.09.04.14.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:23:00 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 0/8] samples: bpf: improve/fix cross-compilation
Date:   Thu,  5 Sep 2019 00:22:04 +0300
Message-Id: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains mainly fixes/improvements for cross-compilation
(also verified on native platform build), tested on arm, but intended
for any arch.

Initial RFC link:
https://lkml.org/lkml/2019/8/29/1665

Besides the pathces given here, the RFC also contains couple patches
related to llvm clang
  arm: include: asm: swab: mask rev16 instruction for clang
  arm: include: asm: unified: mask .syntax unified for clang

The change touches not only cross-compilation and can have impact on
other archs and build environments, so might be good idea to verify
it in order to add appropriate changes, some warn options could be
tuned also.

Ivan Khoronzhuk (8):
  samples: bpf: Makefile: use --target from cross-compile
  samples: bpf: Makefile: remove target for native build
  libbpf: Makefile: add C/CXX/LDFLAGS to libbpf.so and test_libpf
    targets
  samples: bpf: use own EXTRA_CFLAGS for clang commands
  samples: bpf: Makefile: use vars from KBUILD_CFLAGS to handle linux
    headers
  samples: bpf: makefile: fix HDR_PROBE "echo"
  samples: bpf: add makefile.prog for separate CC build
  samples: bpf: Makefile: base progs build on Makefile.progs

 samples/bpf/Makefile      | 177 ++++++++++++++++++++++----------------
 samples/bpf/Makefile.prog |  77 +++++++++++++++++
 samples/bpf/README.rst    |   7 ++
 tools/lib/bpf/Makefile    |  11 ++-
 4 files changed, 197 insertions(+), 75 deletions(-)
 create mode 100644 samples/bpf/Makefile.prog

-- 
2.17.1

