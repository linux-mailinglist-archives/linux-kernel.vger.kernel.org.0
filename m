Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D61170D21
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 01:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgB0AX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 19:23:58 -0500
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:47255
        "EHLO know-smtprelay-omc-7.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgB0AX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 19:23:58 -0500
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Feb 2020 19:23:57 EST
Received: from [192.168.10.214] ([82.47.85.138])
        by cmsmtp with ESMTPA
        id 76sgjlSyzIUP976sgjMWRL; Thu, 27 Feb 2020 00:18:22 +0000
X-Originating-IP: [82.47.85.138]
X-Authenticated-User: sboyce@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.3 cv=Is0wjo3g c=1 sm=1 tr=0 a=mctQX8G8JfdR+oUIdXtpKQ==:117
 a=mctQX8G8JfdR+oUIdXtpKQ==:17 a=N659UExz7-8A:10 a=x7bEGLp0ZPQA:10
 a=AC4NO0dKrlcA4nJGS5EA:9 a=pILNOxqGKmIA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blueyonder.co.uk;
        s=meg.feb2017; t=1582762702;
        bh=TRvD3DxADXQD+mmli0EPslNY1ViY0Df93S+7eiy3lS8=;
        h=Reply-To:To:From:Subject:Date;
        b=ADCUTvpk20p+GvFGuuREPLK4PFv1dsavDKAin6hg2HVxXK/X7+wk02bn1tBCF2p2H
         X9YeNCL7TUWWGbRt9IK5BWtM3J0teL4xrTI2XMYBqms1YIgFzvvv7rkFXkoMZZ0uP9
         1lNxeWi/n+YYNIrZeghOhbijhPS3RqieV0172opy0bSMRrLPWJmnOAoc3RqIg6rNOW
         s3eXQUN7MdfxJOapFiEvSd6HjAnJekLgWlaNupWs5hTDpPb2ITuA0vkYdj9T5tYCWQ
         M8IGzUsQDn3uGJbd+N3aONE7q4HZtMjltM54z988waiPoq+ty32eC9xij7OUkpOLMz
         2M35RKHTQcbvA==
Reply-To: sboyce@blueyonder.co.uk
To:     LKML Mailing List <linux-kernel@vger.kernel.org>
From:   Sid Boyce <sboyce@blueyonder.co.uk>
Organization: blueyonder.co.uk
Subject: 5.6-rc3 nouveau failure, 5.6-rc2 OK
Message-ID: <ae2dc143-8d38-1942-9ebd-87c9c9c09960@blueyonder.co.uk>
Date:   Thu, 27 Feb 2020 00:18:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfNU1KjhjxpKrwbcK8i7t1ZHKw1RWLC5KJyCNF1md/J0xVysg+Pv9LZ5P7Zfl4w/vrLz6F2GlQzrJe89VnsEDoZOihyxtTOY8sOfcHXbJC+QNHooq9pCq
 Uez8xSf9FAL9LWMv1Jj47m7Wpk++PvkrLVHHkAgDxk1rklY9q+j0KCuXeV2L7rSt7ypt02vko2j6Ng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[94.455712] [T411] nouveau 0000:07:00.0 disp ctor failed, -12

Welcome to openSUSE Tumbleweed 20200224 - Kernel 5.6.0-rc3 (tty1)

ens3s0: 192.168.10.214 .......

login:


I can login here but X does not start -- lspci

07:00.0 VGA compatible controller: NVIDIA Corporation TU117 [GeForce GTX 
1650] (rev a1)

from dmesg:-

[Wed Feb 26 22:42:39 2020] nouveau 0000:07:00.0: NVIDIA TU117 (167000a1)
[Wed Feb 26 22:42:39 2020] nouveau 0000:07:00.0: bios: version 
90.17.2a.00.39
[Wed Feb 26 22:44:12 2020] nouveau 0000:07:00.0: disp ctor failed, -12
[Wed Feb 26 22:44:12 2020] nouveau: probe of 0000:07:00.0 failed with 
error -12


Another box with VGA compatible controller: NVIDIA Corporation GP107 
[GeForce GTX 1050 Ti] (rev a1) boots to graphical environment with 5.6-rc3.

tindog:~ # dmesg -T|grep nouveau
[Mon Feb 24 12:50:16 2020] nouveau 0000:07:00.0: NVIDIA GF106 (0c3100a1)
[Mon Feb 24 12:50:16 2020] nouveau 0000:07:00.0: bios: version 
70.26.37.00.01
[Mon Feb 24 12:50:16 2020] nouveau 0000:07:00.0: fb: 4096 MiB GDDR5
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: VRAM: 4096 MiB
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: GART: 1048576 MiB
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: TMDS table version 2.0
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: DCB version 4.0
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: DCB outp 00: 
02000300 00000000
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: DCB outp 01: 
01000302 00020030
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: DCB outp 02: 
04011380 00000000
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: DCB outp 03: 
08011382 00020030
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: DCB outp 04: 
02022362 00020010
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: DCB conn 00: 00001030
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: DCB conn 01: 00000100
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: DCB conn 02: 00002261
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: MM: using COPY0 
for buffer copies
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: DRM: allocated 
1920x1080 fb: 0x60000, bo 000000008db05e25
[Mon Feb 24 12:50:17 2020] fbcon: nouveaudrmfb (fb0) is primary device
[Mon Feb 24 12:50:17 2020] nouveau 0000:07:00.0: fb0: nouveaudrmfb frame 
buffer device
[Mon Feb 24 12:50:17 2020] [drm] Initialized nouveau 1.3.1 20120801 for 
0000:07:00.0 on minor 0

Regards

Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Senior Staff Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

