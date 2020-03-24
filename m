Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457F2191C67
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 23:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgCXWDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 18:03:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31041 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727496AbgCXWDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585087411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J5qcb1/OhlKqVfNitQSriXuTEhrd8dgod3HgoDfcPzE=;
        b=dSPMGztm7jCbRtInYqalxJauSklqxXOX6c12Jtdo68xgqlpnYerM55a4MpHEDlIoMurBx9
        Ycs20Jdy9iQUPrMTtfoS83BGpFVEcqThA8kaQ0eDKJg+OumvMutPk2mTevcKDzUZgBhzzL
        T/0R8x29j+WfNcGCHgmoJVr6xndQUs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-727OHuF8OaKoo-GDhntVTw-1; Tue, 24 Mar 2020 18:03:27 -0400
X-MC-Unique: 727OHuF8OaKoo-GDhntVTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 028B013F5;
        Tue, 24 Mar 2020 22:03:26 +0000 (UTC)
Received: from treble (unknown [10.10.119.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14E255C1B2;
        Tue, 24 Mar 2020 22:03:24 +0000 (UTC)
Date:   Tue, 24 Mar 2020 17:03:21 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 23/26] kbuild/objtool: Add objtool-vmlinux.o pass
Message-ID: <20200324220321.ivoh47j4tkbcwotr@treble>
References: <20200324153113.098167666@infradead.org>
 <20200324160925.288855432@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324160925.288855432@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:31:36PM +0100, Peter Zijlstra wrote:
> Now that objtool is capable of processing vmlinux.o and actually has
> something useful to do there, (conditionally) add it to the final link
> pass.
> 
> This will increase build time by a few seconds.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  lib/Kconfig.debug       |    5 +++++
>  scripts/link-vmlinux.sh |   24 ++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -379,6 +379,11 @@ config STACK_VALIDATION
>  	  For more information, see
>  	  tools/objtool/Documentation/stack-validation.txt.
>  
> +config VMLINUX_VALIDATION
> +	bool
> +	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
> +	default y
> +

So I'm assuming this is incompatible with PARAVIRT because of all the
indirect pvops calls?

I'm thinking it should be easy to detect those and whitelist them
because they always have a pv_ops relocation associated with the call
instruction.

-- 
Josh

