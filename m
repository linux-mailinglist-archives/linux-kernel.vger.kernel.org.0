Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACBC2FCFE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 16:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfE3OOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 10:14:01 -0400
Received: from ms.lwn.net ([45.79.88.28]:56814 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfE3OOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:14:00 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CDA636D9;
        Thu, 30 May 2019 14:13:59 +0000 (UTC)
Date:   Thu, 30 May 2019 08:13:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/stackprotector: powerpc supports stack
 protector
Message-ID: <20190530081358.650930ad@lwn.net>
In-Reply-To: <CACi5LpM9v1YC_6HhA-uKghawzkEu=TTPVkomMmv2i-LGi8X7+g@mail.gmail.com>
References: <1559212177-7072-1-git-send-email-bhsharma@redhat.com>
        <87v9xsnlu9.fsf@concordia.ellerman.id.au>
        <CACi5LpM9v1YC_6HhA-uKghawzkEu=TTPVkomMmv2i-LGi8X7+g@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019 18:37:46 +0530
Bhupesh Sharma <bhsharma@redhat.com> wrote:

> > This should probably go via the documentation tree?
> >
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au>  
> 
> Thanks for the review Michael.
> I am ok with this going through the documentation tree as well.

Works for me too, but I don't seem to find the actual patch anywhere I
look.  Can you send me a copy?

Thanks,

jon
