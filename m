Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90DCB102FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 00:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfKSXNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 18:13:04 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34902 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfKSXNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 18:13:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 4A77D285D9;
        Tue, 19 Nov 2019 18:12:58 -0500 (EST)
Date:   Wed, 20 Nov 2019 10:12:21 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Kars de Jong <jongk@linux-m68k.org>
cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] esp_scsi: Clear Transfer Count registers before PIO
 transfers
In-Reply-To: <alpine.LNX.2.21.1.1911190923120.8@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1.1911201006520.10@nippy.intranet>
References: <2bbb6359d542f5882be67c415ecc25ad2d9eeb5e.1573875417.git.fthain@telegraphics.com.au> <CACz-3rjHAyi6kMQ6j9YALLm1ApYrsqKiTnGNPUhxqqEuRJ9TjQ@mail.gmail.com> <alpine.LNX.2.21.1.1911180947020.8@nippy.intranet> <CACz-3rhr_R+_mJpg+Rvgoj=1GC5AO3YKxYxS_0ShAfQ-NiFDtg@mail.gmail.com>
 <alpine.LNX.2.21.1.1911190923120.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019, I wrote:

> 
> But this is a theoretical problem so far. You may need to use sg_utils 
> to generate a SCSI command like that.
> 
> (For a DMA controller subject to, say, 24-bit boundaries, there are 
> additional ways to end up with short transfers.)
> 

On reflection these probably can't happen in practice. I was being 
over-cautious. So I'll leave this patch out-of-tree until there's a need 
for it (i.e. some driver that uses both DMA and PIO in data phases).

-- 
