Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43DB917693D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 01:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCCAU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 19:20:27 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56936 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCCAU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 19:20:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 6F0632A436;
        Mon,  2 Mar 2020 19:20:24 -0500 (EST)
Date:   Tue, 3 Mar 2020 11:20:22 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 31/42] docs: scsi: convert scsi_mid_low_api.txt to ReST
In-Reply-To: <881e7741dfed5d6f5f73e1dfc2826b200b8604aa.1583136624.git.mchehab+huawei@kernel.org>
Message-ID: <alpine.LNX.2.22.394.2003031104580.12@nippy.intranet>
References: <cover.1583136624.git.mchehab+huawei@kernel.org> <881e7741dfed5d6f5f73e1dfc2826b200b8604aa.1583136624.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020, Mauro Carvalho Chehab wrote:

> +			slave_alloc()
> +			slave_configure()
> +			    |
> +			slave_alloc()   ***
> +			slave_destroy() ***
> +
> +
> +    *** For scsi devices that the mid level tries to scan but do not
> +	respond, a slave_alloc(), slave_destroy() pair is called.
>  
>  If the LLD wants to adjust the default queue settings, it can invoke
>  scsi_change_queue_depth() in its slave_configure() routine.
>  
> -*** For scsi devices that the mid level tries to scan but do not
> -    respond, a slave_alloc(), slave_destroy() pair is called.
> -

Elsewhere in this series you have replaced asterisks with footnotes, as in 
[#]. Was that overlooked here?

BTW, certain patches in this series produce warnings from 'git am', that 
is, 'space before tab in indent'. Most of that whitespace appears to be 
intentional (for table formatting) or is pre-existing, but some seems to 
have been accidentally added...

$ git diff @~42.. | grep $'^[+].*\x20\x09'

Also, some of the patches in this series, like this one, were not Cc'd to 
the linux-scsi mailing list.
