Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA22137491
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 18:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgAJRRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 12:17:14 -0500
Received: from ms.lwn.net ([45.79.88.28]:52042 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbgAJRRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:17:09 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2D85077D;
        Fri, 10 Jan 2020 17:17:08 +0000 (UTC)
Date:   Fri, 10 Jan 2020 10:17:07 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, merker@debian.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-doc@vger.kernel.org,
        palmer@sifive.com, mchehab+samsung@kernel.org
Subject: Re: [PATCH] RISC-V: Typo fixes in image header and documentation.
Message-ID: <20200110101707.06800f3c@lwn.net>
In-Reply-To: <mhng-94b9cad5-0d14-480f-b428-8752630064d2@palmerdabbelt-glaptop>
References: <20191210072947.7018340c@lwn.net>
        <4912c007ab6c19321c8c988ae2328efbfb3e582d.camel@wdc.com>
        <mhng-3a815562-1222-4737-a77c-6dab9948db79@palmerdabbelt-glaptop>
        <mhng-94b9cad5-0d14-480f-b428-8752630064d2@palmerdabbelt-glaptop>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jan 2020 15:42:27 -0800 (PST)
Palmer Dabbelt <palmerdabbelt@google.com> wrote:

> > I was assuming it was going through the risc-v tree since it touches arch
> > code :)  I can go ahead and apply it.  
> 
> I don't see this in 5.5-rc5.

It's in docs-next; I've not pushed it through straight to 5.5.  I can do
that, I suppose, if it seems urgent?

Thanks,

jon
