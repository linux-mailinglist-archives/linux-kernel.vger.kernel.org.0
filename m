Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E082861C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 20:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbfEWSoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 14:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731261AbfEWSoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:44:18 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D4F20862;
        Thu, 23 May 2019 18:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558637058;
        bh=vYa/QYzhrVwmjzkyCdB1uSBJM69i8p5GMH/VTjXTFFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iLo1k5LgmzliVY1bAONTj8MD7+T3Hq+PQB8ZjiJ0qJ0DMlV9DxCx0txUky6uI3Mah
         hVfIqW3NoDjbITh3pUy+Kp2VuTXTfdB2gcrODjFGe3XqSvbqPiZd2o6rLjWJUOuCaD
         VbYJ6d6yN8M/6lkESWh+9/UY8ze51T4xIGc7rBBQ=
Date:   Thu, 23 May 2019 11:44:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] elf: fix "start_code" evaluation
Message-Id: <20190523114417.f99d781754ed22950115c64a@linux-foundation.org>
In-Reply-To: <20190523175736.GA6222@avx2>
References: <20190523175736.GA6222@avx2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 20:57:36 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Only executable ELF program headers should change ->start_code.
> 
> ...
>
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1026,7 +1026,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  			}
>  		}
>  		k = elf_ppnt->p_vaddr;
> -		if (k < start_code)
> +		if ((elf_ppnt->p_flags & PF_X) && k < start_code)
>  			start_code = k;
>  		if (start_data < k)
>  			start_data = k;

What problem does this solve?  How does it alter runtime behaviour? 
How do we know it won't break anything?

