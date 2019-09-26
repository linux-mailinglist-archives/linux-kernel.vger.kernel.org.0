Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB3BEB26
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 06:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbfIZEVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 00:21:11 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:16673 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728648AbfIZEVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 00:21:11 -0400
X-IronPort-AV: E=Sophos;i="5.64,550,1559491200"; 
   d="scan'208";a="76043412"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Sep 2019 12:21:08 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 1D8DD4CE14EA;
        Thu, 26 Sep 2019 12:21:11 +0800 (CST)
Received: from TSAO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 26 Sep 2019 12:21:19 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <corbet@lwn.net>
Subject: [RFC PATCH] x86/doc/boot_protocol: Correct the description of "reloc"
Date:   Thu, 26 Sep 2019 12:21:16 +0800
Message-ID: <20190926042116.17929-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 1D8DD4CE14EA.AB26D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fields marked with (reloc) actually are not dedicated for writing,
but communicating info for relocatable kernel with boot loaders. For
example:

    ============    ============
    Field name:     pref_address
    Type:           read (reloc)
    Offset/size:    0x258/8
    Protocol:       2.10+
    ============    ============

    ============    ========================
    Field name:     code32_start
    Type:           modify (optional, reloc)
    Offset/size:    0x214/4
    Protocol:       2.00+
    ============    ========================

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
Unless I have incorrect non-native understanding for "fill in", I think
this is inaccurate.

 Documentation/x86/boot.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 08a2f100c0e6..a611bf04492d 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -243,7 +243,7 @@ bootloader ("modify").
 
 All general purpose boot loaders should write the fields marked
 (obligatory).  Boot loaders who want to load the kernel at a
-nonstandard address should fill in the fields marked (reloc); other
+nonstandard address should consult with the fields marked (reloc); other
 boot loaders can ignore those fields.
 
 The byte order of all fields is littleendian (this is x86, after all.)
-- 
2.21.0



