Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC142FF617
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 00:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfKPXC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 18:02:59 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52816 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfKPXC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 18:02:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 875D728EDF;
        Sat, 16 Nov 2019 18:02:56 -0500 (EST)
Date:   Sun, 17 Nov 2019 10:02:46 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kars de Jong <jongk@linux-m68k.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] esp_scsi: Clear Transfer Count registers before PIO
 transfers
In-Reply-To: <36712461-b94c-4aff-8664-3896c2cf2524@gmail.com>
Message-ID: <alpine.LNX.2.21.1.1911170959440.10@nippy.intranet>
References: <2bbb6359d542f5882be67c415ecc25ad2d9eeb5e.1573875417.git.fthain@telegraphics.com.au> <36712461-b94c-4aff-8664-3896c2cf2524@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Nov 2019, Michael Schmitz wrote:

> 
> I believe you also need to send a DMA NOP command to the ESP
> 

I believe you're right. I shall add the missing DMA NOP command. Thanks 
for your review!

-- 
