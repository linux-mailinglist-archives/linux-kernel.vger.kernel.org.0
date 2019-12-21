Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 832B4128696
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 03:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLUCMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 21:12:22 -0500
Received: from trent.utfs.org ([94.185.90.103]:59536 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfLUCMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 21:12:22 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Dec 2019 21:12:21 EST
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 5B03F6015C;
        Sat, 21 Dec 2019 03:02:54 +0100 (CET)
Date:   Fri, 20 Dec 2019 18:02:54 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: filesystem being remounted supports timestamps until 2038
Message-ID: <alpine.DEB.2.21.99999.375.1912201332260.21037@trent.utfs.org>
User-Agent: Alpine 2.21.99999 (DEB 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed the following messages in my dmesg:

 xfs filesystem being remounted at /mnt/disk supports imestamps until 2038 (0x7fffffff)

These messages get printed over and over again because /mnt/disk is 
usually a read-only mount that is remounted (rw) a couple of times a day 
for backup purposes.

I see that these messages have been introduced with f8b92ba67c5d ("mount: 
Add mount warning for impending timestamp expiry") resp. 0ecee6699064 
("fix use-after-free of mount in mnt_warn_timestamp_expiry()") and I was 
wondering if there is any chance to either adjust this to pr_debug (but 
then it would still show up in dmesg, right?) or to only warn once when 
it's mounted, but not on re-mount?

Thanks,
Christian.
-- 
BOFH excuse #83:

Support staff hung over, send aspirin and come back LATER.
