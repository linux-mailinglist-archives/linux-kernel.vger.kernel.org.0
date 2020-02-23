Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625871692E0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 02:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgBWBwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 20:52:45 -0500
Received: from ishtar.tlinx.org ([173.164.175.65]:50994 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgBWBwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:52:45 -0500
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id 01N1qgA2080730;
        Sat, 22 Feb 2020 17:52:44 -0800
Message-ID: <5E51DAEA.8090702@tlinx.org>
Date:   Sat, 22 Feb 2020 17:52:42 -0800
From:   L Walsh <cifs@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     linux-cifs <linux-cifs@vger.kernel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Regression -- linux 5.5.3: can no longer mount with unix extentions
 using cifs 2.1 (Win10-only client additions)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hard links and serverino numbers, among other things used to work when
mounting a win7 client using a linux cifs client

I tried this today, and am getting:

[701913.978407] CIFS VFS: Autodisabling the use of server inode numbers 
on \\Athenae\C.
[701913.986151] CIFS VFS: The server doesn't seem to support them 
properly or the files might be on different servers (DFS).
[701913.997116] CIFS VFS: Hardlinks will not be recognized on this 
mount. Consider mounting with the "noserverino" option to silence this 
message.
[703793.287615] CIFS VFS: Server does not support mounting with posix 
SMB3.11 extensions.
[703793.295810] CIFS VFS: cifs_mount failed w/return code = -95

The win7 workstation in question is running 1 hard disk, no DFS.

Unix extensions worked long before SMB3.x.  It seems there is ongoing work
to disable SMB2.1 support and replace it with only latest SMB from MS
compatible with Win10. 

If MS wants to backport SMB3.x to Win7, that would be fine, but I
doubt that is going to happen.  NTL, if they keep breaking 2.1 compatibility
that would be one option.



