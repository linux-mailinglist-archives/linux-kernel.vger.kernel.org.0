Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7FAEAA4C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 15:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfIENmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 09:42:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11947 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfIENmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:42:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A3A210A8122;
        Thu,  5 Sep 2019 13:42:03 +0000 (UTC)
Received: from localhost (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 320445D9E1;
        Thu,  5 Sep 2019 13:42:01 +0000 (UTC)
Date:   Thu, 5 Sep 2019 21:41:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] x86/boot: Wrap up the SRAT traversing code into
 subtable_parse()
Message-ID: <20190905134157.GA20805@MiWiFi-R3L-srv>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
 <20190830214707.1201-2-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830214707.1201-2-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 05 Sep 2019 13:42:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/19 at 05:47pm, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Wrap up the SRAT traversing code into subtable_parse().
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpi.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 149795c36..908a1bfab 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -362,6 +362,19 @@ static unsigned long get_acpi_srat_table(void)
>  	return 0;
>  }

Reviewed-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan
>  
> +static void subtable_parse(struct acpi_subtable_header *sub_table, int *num)
> +{
> +	struct acpi_srat_mem_affinity *ma;
> +
> +	ma = (struct acpi_srat_mem_affinity *)sub_table;
> +
> +	if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
> +		immovable_mem[*num].start = ma->base_address;
> +		immovable_mem[*num].size = ma->length;
> +		(*num)++;
> +	}
> +}
> +
>  /**
>   * count_immovable_mem_regions - Parse SRAT and cache the immovable
>   * memory regions into the immovable_mem array.
> @@ -395,14 +408,8 @@ int count_immovable_mem_regions(void)
>  	while (table + sizeof(struct acpi_subtable_header) < table_end) {
>  		sub_table = (struct acpi_subtable_header *)table;
>  		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
> -			struct acpi_srat_mem_affinity *ma;
>  
> -			ma = (struct acpi_srat_mem_affinity *)sub_table;
> -			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
> -				immovable_mem[num].start = ma->base_address;
> -				immovable_mem[num].size = ma->length;
> -				num++;
> -			}
> +			subtable_parse(sub_table, &num);
>  
>  			if (num >= MAX_NUMNODES*2) {
>  				debug_putstr("Too many immovable memory regions, aborting.\n");
> -- 
> 2.18.1
> 
