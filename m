Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125D1EB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 21:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfD2T7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 15:59:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31849 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2T7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556567952; x=1588103952;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GppUJ721qvDXD5FXETSpJUQwCmaDQ8dPUNFVqKinAfU=;
  b=G56vm10odKoK0gaJm6BNSkICEQ5l3WJe+vjyeEhTMUc5m+vFTKn/Zz07
   pyYWNiBaNvWky2XHpgjpzPX+TOtQFQUNyXGs7D/4KpoluFMr4AVmnmbCz
   OOPJThNILD90zSCNgD51JkSbU+WQbXJAbX9KG31z1C3VFYIu+vWmzflzn
   rI6GIcNlZqBH8mzW+bzzY0REdfsUP5bEUX3eEQBMI9CXMuq216VqzQlx5
   7kP2dgZoQyk2aUMnMpsT74JYZzjAvXWJm8YCwLEP5FTQVZ3KRa5ttmOul
   gdjJ9cN1JFxEudOGLnPxC2nmbsT3dohnruMHMKwRgoVgM1xb8udtZn6Ng
   g==;
X-IronPort-AV: E=Sophos;i="5.60,410,1549900800"; 
   d="scan'208";a="108309663"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2019 03:58:11 +0800
IronPort-SDR: Mxqimv4jQPbi+O0E6GAOJpAgo0XPFhgFhVqWlhAD+D/KwLrd+hLfVqesNYLLBTVaYVvUoJ15sM
 o9rTKDKlcFsSLo97uzBXkc/222hTpbJsMGeffl7sGbks8SIc+F/fINYjIK7vY8Wt5xCh1yyYLP
 qHHyFZOZZTnHjeNC7Y4zf8zb0o0MmX8u213pClv1CIkjKi+0w/GBR5V2BNMyMVrLxp0QspI9TD
 D+p0oLpso/xsWtFZ7fFkvW0Y5//2K2tn8P5+Jrf6BXFgOghXdq1qXIrJ3vum8Dxy7bZZe2xWVs
 A0/WzAVRs1z3kuEn1YN5PNlS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 Apr 2019 12:34:34 -0700
IronPort-SDR: AGlb8C2mLL6BEh346K0F1Ldnycd8TuHmmHBt8swMOSQWKGcUOZ/GtOQDaFFXeORG/zWxkCgHXx
 nzJQlQIghVNQXnkEjAQOEQUPOjNCVQ5y1SBejZUGuuFp9B0eRtslW/zK8NGGjJDIQpFozyVeOM
 c1c2kGCUDOUVsq/h9Ge49ygnvU7TmuxYJwZ5n+rJO10fyN3/A7uhaldxaK15ZJIhvGQrq8VGJu
 nx6P8XoH9tIOdcny39PXJFO6BV+PcDuraWj9yW0XYNUyojx7wUvonwTJv9e1f8aixOeexoZ4Xf
 +80=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2019 12:58:10 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Borislav Petkov <bp@alien8.de>,
        Changbin Du <changbin.du@intel.com>,
        Gary Guo <gary@garyguo.net>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 0/3] TLB flush counters
Date:   Mon, 29 Apr 2019 12:57:56 -0700
Message-Id: <20190429195759.18330-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V patch (2/3) is based on Gary's TLB flush patch series

https://patchwork.kernel.org/project/linux-riscv/list/?series=97315

The x86 kconfig fix patch(1/3) can be applied separately.

Changes from v1->v2:
1. Move the arch specific config option to a common one as it touches
   generic code.
2. Introduced another config that architectures can select to enable
   tlbflush option.

Atish Patra (3):
x86: Move DEBUG_TLBFLUSH option.
RISC-V: Enable TLBFLUSH counters for debug kernel.
RISC-V: Update tlb flush counters

arch/riscv/Kconfig                |  1 +
arch/riscv/include/asm/tlbflush.h |  5 +++++
arch/riscv/mm/tlbflush.c          | 12 ++++++++++++
arch/x86/Kconfig                  |  1 +
arch/x86/Kconfig.debug            | 19 -------------------
mm/Kconfig.debug                  | 13 +++++++++++++
6 files changed, 32 insertions(+), 19 deletions(-)

--
2.21.0

