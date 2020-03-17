Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A535B1884EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 14:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgCQNLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 09:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgCQNK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:10:56 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFDF82076F;
        Tue, 17 Mar 2020 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584450656;
        bh=FgXdusS3QcmJA6yjKg7Ucj0EuTexWmbLfH2/1fRwm7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KpZAbHxr3qsr9d3K+aXdCwtnZ4Mb8x4E8eCxc6TNBcjG7ieh0w/kB9vUGrb7gnSZI
         Ow4I5x2bcp3fpnogJGCNsIK9+ijSIXsR2dT5YmDf+kWgTHEfrxBIHnW9v8jl98/zSK
         nhDElxhUqGp6MLSZXiIQ0tVlEtU7ig4TqE/nNID4=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEBzi-0006Sa-07; Tue, 17 Mar 2020 14:10:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 12/12] docs: kernel-parameters.txt: remove reference for removed Intel MPX
Date:   Tue, 17 Mar 2020 14:10:51 +0100
Message-Id: <956bdad7bed30593175b7c1272e043f3804c5afb.1584450500.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584450500.git.mchehab+huawei@kernel.org>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel MPX support got removed on Kernel 5.6, but the
kernel-parameters file still mentions it.

Update the text to document that this parameter is not needed
anymore, as the Intel MPX will always be disabled now on
(as its support got removed).

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 192a36a66fc9..ff5e0ca7d9a7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -990,9 +990,10 @@
 			Documentation/admin-guide/dynamic-debug-howto.rst
 			for details.
 
-	nompx		[X86] Disables Intel Memory Protection Extensions.
-			See Documentation/x86/intel_mpx.rst for more
-			information about the feature.
+	nompx		X86] Previously, disabled Intel Memory Protection
+			Extensions.
+			NOTE: It is now default, as the Intel MPX code
+			was removed in v5.6.
 
 	nopku		[X86] Disable Memory Protection Keys CPU feature found
 			in some Intel CPUs.
-- 
2.24.1

