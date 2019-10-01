Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7634C2BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 04:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfJACWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 22:22:20 -0400
Received: from nl101-2.vfemail.net ([149.210.219.31]:31199 "HELO
        freequeue.vfemail.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726157AbfJACWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 22:22:20 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2019 22:22:19 EDT
Received: (qmail 95000 invoked from network); 1 Oct 2019 02:14:51 -0000
Received: from nl101-2.vfemail.net (149.210.219.31)
  by localhost with SMTP; 1 Oct 2019 02:14:51 -0000
Received: (qmail 94692 invoked from network); 1 Oct 2019 02:14:34 -0000
Received: by simscan 1.4.0 ppid: 94686, pid: 94688, t: 0.1108s
         scanners:none
Received: from unknown (HELO localhost) (aGdudGt3aXNAdmZlbWFpbC5uZXQ=@192.168.1.192)
  by nl101.vfemail.net with ESMTPA; 1 Oct 2019 02:14:34 -0000
Received: from 71-215-123-70.ftmy.centurylink.net
 (71-215-123-70.ftmy.centurylink.net [71.215.123.70]) by www.vfemail.net
 (Horde Framework) with HTTPS; Tue, 01 Oct 2019 02:14:45 +0000
Date:   Tue, 01 Oct 2019 02:14:45 +0000
Message-ID: <20191001021445.Horde.vJlgHZzdj07RiCXGaQ6yOqT@www.vfemail.net>
From:   hgntkwis@vfemail.net
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: x86/random: Speculation to the rescue
User-Agent: Horde Application Framework 5
X-VFEmail-Originating-IP: 71.215.123.70
X-VFEmail-AntiSpam: Notify admin@vfemail.net of any spam, and include
 VFEmail headers
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why not get entropy from the white noise that can be obtained from any  
attached ADC? Audio cards, some SBCs, and microcontrollers all have  
ADCs.
Not that I'm familiar with when the kernel first needs entropy or an  
expert in the field.

Thanks



-------------------------------------------------
This free account was provided by VFEmail.net - report spam to abuse@vfemail.net
 
ONLY AT VFEmail! - Use our Metadata Mitigator to keep your email out of the NSA's hands!
$24.95 ONETIME Lifetime accounts with Privacy Features!  
15GB disk! No bandwidth quotas!
Commercial and Bulk Mail Options!  
