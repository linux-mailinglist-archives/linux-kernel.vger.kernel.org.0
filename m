Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0325113D3FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 06:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgAPFxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 00:53:54 -0500
Received: from ozlabs.org ([203.11.71.1]:41861 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgAPFxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 00:53:53 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47ytfm1x2Mz9sPW;
        Thu, 16 Jan 2020 16:53:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1579154032;
        bh=9RJsA4ixbU88RCAM8/QGkNN4hFo2PgW5OQD3mizTqI4=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=FqKdsNN0+BMLA/sv1/RKIUVNjSC86xzmMHFRbQrb//m3wbAbN4rnKXI9uln9OlG6o
         5TlVgSy7N/4wJS42CWV1b2DqgfuWNNOAg9D2IDvHcioJiIYuaPbZHGMmTC+DYbj/Np
         ZX+/S7m/WmXN6ka4CEjNIYF0dVvZSEv5yMp2ooTpKtAqGPuvrTrjX6R97FYnJC/7d8
         VHmD+JvS8o4D3g53Yb43H+3lA9R9U3fs+1+LVBrXTSiwkybYxVlDSinm6F7k5dVk+K
         JhXymh3j23dlNfXiEgcOfZQQnzvRDrXm8n9KZP5rPlvnfTz9ts+pKinLnyHlt5MbhP
         yj73JrISh1PRA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michael Bringmann <mwb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Gustavo Walbon <gwalbon@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] Fix display of Maximum Memory
In-Reply-To: <5577aef8-1d5a-ca95-ff0a-9c7b5977e5bf@linux.ibm.com>
References: <5577aef8-1d5a-ca95-ff0a-9c7b5977e5bf@linux.ibm.com>
Date:   Thu, 16 Jan 2020 15:53:57 +1000
Message-ID: <8736cg9cay.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bringmann <mwb@linux.ibm.com> writes:
> Correct overflow problem in calculation+display of Maximum Memory
> value to syscfg where 32bits is insufficient.
>
> Signed-off-by: Michael Bringmann <mwb@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/lparcfg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
> index e33e8bc..f00411c 100644
> --- a/arch/powerpc/platforms/pseries/lparcfg.c
> +++ b/arch/powerpc/platforms/pseries/lparcfg.c
> @@ -433,12 +433,12 @@ static void parse_em_data(struct seq_file *m)
>  
>  static void maxmem_data(struct seq_file *m)
>  {
> -	unsigned long maxmem = 0;
> +	u64 maxmem = 0;

This is 64-bit only code, so u64 == unsigned long.

> -	maxmem += drmem_info->n_lmbs * drmem_info->lmb_size;
> -	maxmem += hugetlb_total_pages() * PAGE_SIZE;
> +	maxmem += (u64)drmem_info->n_lmbs * drmem_info->lmb_size;

The only problem AFAICS is n_lmbs is int and lmb_size is u32, so this
multiplication will overflow.

> +	maxmem += (u64)hugetlb_total_pages() * PAGE_SIZE;

hugetlb_total_pages() already returns unsigned long.

> -	seq_printf(m, "MaxMem=%ld\n", maxmem);
> +	seq_printf(m, "MaxMem=%llu\n", maxmem);
>  }

This should be sufficient?

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index e33e8bc4b69b..38c306551f76 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -435,10 +435,10 @@ static void maxmem_data(struct seq_file *m)
 {
        unsigned long maxmem = 0;
 
-       maxmem += drmem_info->n_lmbs * drmem_info->lmb_size;
+       maxmem += (unsigned long)drmem_info->n_lmbs * drmem_info->lmb_size;
        maxmem += hugetlb_total_pages() * PAGE_SIZE;
 
-       seq_printf(m, "MaxMem=%ld\n", maxmem);
+       seq_printf(m, "MaxMem=%lu\n", maxmem);
 }
 
 static int pseries_lparcfg_data(struct seq_file *m, void *v)


cheers
