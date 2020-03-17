Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB8A188C37
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 18:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCQRgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 13:36:02 -0400
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:46191 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgCQRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:36:01 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2020 13:36:00 EDT
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 02HHRurI015186
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 18:28:08 +0100
Date:   Tue, 17 Mar 2020 18:27:55 +0100
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 06/17] firewire: firewire-cdev.hL get rid of a docs
 warning
Message-ID: <20200317182755.1c4dd7e7@kant>
In-Reply-To: <1e2af9e7b75c2d968033b5054969c2095b317b16.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
        <1e2af9e7b75c2d968033b5054969c2095b317b16.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 17 Mauro Carvalho Chehab wrote:
> This warning:
> 
> 	./include/uapi/linux/firewire-cdev.h:312: WARNING: Inline literal start-string without end-string.
> 
> is because %FOO doesn't work if there's a parenthesis at the
> string (as a parenthesis may indicate a function). So, mark
> the literal block using the alternate ``FOO`` syntax.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I figure this is meant to go through the Documentation tree, hence

Acked-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

But if I am to apply it, give me a note.

> ---
>  include/uapi/linux/firewire-cdev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
> index 1acd2b179aef..7e5b5c10a49c 100644
> --- a/include/uapi/linux/firewire-cdev.h
> +++ b/include/uapi/linux/firewire-cdev.h
> @@ -308,7 +308,7 @@ struct fw_cdev_event_iso_interrupt_mc {
>  /**
>   * struct fw_cdev_event_iso_resource - Iso resources were allocated or freed
>   * @closure:	See &fw_cdev_event_common;
> - *		set by %FW_CDEV_IOC_(DE)ALLOCATE_ISO_RESOURCE(_ONCE) ioctl
> + *		set by``FW_CDEV_IOC_(DE)ALLOCATE_ISO_RESOURCE(_ONCE)`` ioctl
>   * @type:	%FW_CDEV_EVENT_ISO_RESOURCE_ALLOCATED or
>   *		%FW_CDEV_EVENT_ISO_RESOURCE_DEALLOCATED
>   * @handle:	Reference by which an allocated resource can be deallocated

-- 
Stefan Richter
-======--=-- --== =---=
http://arcgraph.de/sr/
