Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781E4118AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 15:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLJO3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 09:29:50 -0500
Received: from ms.lwn.net ([45.79.88.28]:49778 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbfLJO3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:29:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 63380739;
        Tue, 10 Dec 2019 14:29:48 +0000 (UTC)
Date:   Tue, 10 Dec 2019 07:29:47 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, merker@debian.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-doc@vger.kernel.org,
        palmer@sifive.com, mchehab+samsung@kernel.org
Subject: Re: [PATCH] RISC-V: Typo fixes in image header and documentation.
Message-ID: <20191210072947.7018340c@lwn.net>
In-Reply-To: <mhng-3a815562-1222-4737-a77c-6dab9948db79@palmerdabbelt-glaptop>
References: <4912c007ab6c19321c8c988ae2328efbfb3e582d.camel@wdc.com>
        <mhng-3a815562-1222-4737-a77c-6dab9948db79@palmerdabbelt-glaptop>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Dec 2019 15:03:10 -0800 (PST)
Palmer Dabbelt <palmerdabbelt@google.com> wrote:

> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> I'm assuming this is not going in through the RISC-V tree as it mostly touches
> Documentation/.

I was assuming it was going through the risc-v tree since it touches arch
code :)  I can go ahead and apply it.

Thanks,

jon
