Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1618831106
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 17:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfEaPNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 11:13:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfEaPNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:13:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Fnyr2t7Bz9s1c;
        Sat,  1 Jun 2019 01:13:40 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jonathan Corbet <corbet@lwn.net>,
        Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/stackprotector: powerpc supports stack protector
In-Reply-To: <20190530081358.650930ad@lwn.net>
References: <1559212177-7072-1-git-send-email-bhsharma@redhat.com> <87v9xsnlu9.fsf@concordia.ellerman.id.au> <CACi5LpM9v1YC_6HhA-uKghawzkEu=TTPVkomMmv2i-LGi8X7+g@mail.gmail.com> <20190530081358.650930ad@lwn.net>
Date:   Sat, 01 Jun 2019 01:13:36 +1000
Message-ID: <87ef4eodwf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:
> On Thu, 30 May 2019 18:37:46 +0530
> Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
>> > This should probably go via the documentation tree?
>> >
>> > Acked-by: Michael Ellerman <mpe@ellerman.id.au>  
>> 
>> Thanks for the review Michael.
>> I am ok with this going through the documentation tree as well.
>
> Works for me too, but I don't seem to find the actual patch anywhere I
> look.  Can you send me a copy?

You can get it from lore:

  https://lore.kernel.org/linuxppc-dev/1559212177-7072-1-git-send-email-bhsharma@redhat.com/raw

Or patchwork (automatically adds my ack):

  https://patchwork.ozlabs.org/patch/1107706/mbox/

Or Bhupesh can send it to you :)

cheers
