Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780D0130395
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 17:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgADQ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 11:29:34 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:46144 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgADQ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:29:34 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 7677F67E7DA;
        Sat,  4 Jan 2020 17:29:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1578155371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RboBw79xQDQsEmbNfetBmtEfWpp5jtrjn3jvMeyFDd8=;
        b=DkHWDLocTyngL9E+vupQYYBTyODXr2TXjDvI/3TsSqhEPaM3q+P51wizrwMU4TIGePHz5j
        unvCnt0pxUY7PaVkSI92RlWHybv7hfOpvkJUVW1EgXM0BTj/q645jA/tGSIQdPh1F8cI/+
        5sx+fsMDnp+sAIRnwmzxnUQGkrT3Y5E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 04 Jan 2020 17:29:31 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>
Subject: Multidevice f2fs mount after disk rearrangement
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <4c6cf8418236145f7124ac61eb2908ad@natalenko.name>
X-Sender: oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I was brave enough to create f2fs filesystem spanning through 2 physical 
device using this command:

# mkfs.f2fs -t 0 /dev/sdc -c /dev/sdd

It worked fine until I removed /dev/sdb from my system, so f2fs devices 
became:

/dev/sdc -> /dev/sdb
/dev/sdd -> /dev/sdc

Now, when I try to mount it, I get the following:

# mount -t f2fs /dev/sdb /mnt/fs
mount: /mnt/fs: mount(2) system call failed: No such file or directory.

In dmesg:

[Jan 4 17:25] F2FS-fs (sdb): Mount Device [ 0]:             /dev/sdc,    
59063,        0 -  1cd6fff
[  +0,000024] F2FS-fs (sdb): Failed to find devices

fsck also fails with the following assertion:

[ASSERT] (init_sb_info: 908) !strcmp((char *)sb->devs[i].path, (char 
*)c.devices[i].path)

Am I doing something obviously stupid, and the device path can be 
(somehow) changed so that the mount succeeds, or this is unfixable, and 
f2fs relies on persistent device naming?

Please suggest.

Thank you.

-- 
   Oleksandr Natalenko (post-factum)
