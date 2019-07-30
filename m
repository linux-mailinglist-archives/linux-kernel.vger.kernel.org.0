Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9161C7B644
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 01:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfG3XcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 19:32:20 -0400
Received: from trent.utfs.org ([94.185.90.103]:59736 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfG3XcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:32:19 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jul 2019 19:32:19 EDT
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 69A185FCCE;
        Wed, 31 Jul 2019 01:24:40 +0200 (CEST)
Date:   Tue, 30 Jul 2019 16:24:40 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
Subject: ptrace.c:202:6: warning: this statement may fall through
Message-ID: <alpine.DEB.2.21.99999.352.1907301559210.29629@trent.utfs.org>
User-Agent: Alpine 2.21.99999 (DEB 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While compiling mainline with gcc-9.1.1 the following warning is emitted:

===========================================================
../arch/x86/kernel/ptrace.c: In function ‘set_segment_reg’: 
../arch/x86/kernel/ptrace.c:202:6: warning: this statement may fall 
through [-Wimplicit-fallthrough=]
  202 |   if (unlikely(value == 0))
      |      ^
../arch/x86/kernel/ptrace.c:205:2: note: here
  205 |  default:
      |  ^~~~~~~
===========================================================

The patch below silences the warning, but I don't know if this is actual 
intended behaviour.

Christian.

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 0fdbe89d0754..0030456d6e5c 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -201,6 +201,7 @@ static int set_segment_reg(struct task_struct *task,
 	case offsetof(struct user_regs_struct, ss):
 		if (unlikely(value == 0))
 			return -EIO;
+		/* fall through */

 	default:
 		*pt_regs_access(task_pt_regs(task), offset) = value;
-- 
BOFH excuse #326:

We need a licensed electrician to replace the light bulbs in the computer room.
