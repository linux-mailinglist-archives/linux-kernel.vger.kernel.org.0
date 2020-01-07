Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3121131E38
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 05:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgAGEED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 23:04:03 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33064 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgAGEED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 23:04:03 -0500
Received: by mail-pj1-f67.google.com with SMTP id u63so4870549pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 20:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B0oNcIbjX5zAsLAEn09krQRymHbBDEiH3zomLTcEFpM=;
        b=myu93md+K1gu02JO88k7yN9Y6B86Slj8V1E6ZeDSpjG/M1GrkEq2zwlkcX4ccVK9dR
         f2JYbWg2BCyTGaDza1xIipIUzbAoyA5NDV22jh9SvrB4k+JZ7EBvJuwM/SOqrIUaHX+a
         f6M4HwJMr3UGINwkTUQI96firweny1al2DHp3NCqZ7CKJsIetYQ37gtDyCGk+QzHrs3U
         5B3cAf1zGgFM5DtrKp4hxs61XkLDidZYaXk79QwCROzkgc93KjGlUF7oxya/Puuc0WCq
         RVf+uD04i+6BnI76OYXVKH3m6nALjqppDVivgxp9GVjcnxjO/XNfA8p7KAQm23kpqBKo
         U8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B0oNcIbjX5zAsLAEn09krQRymHbBDEiH3zomLTcEFpM=;
        b=fkuWzvB1HTtlw3SAMoZvPLKKY5OUv41H9qWH1LCdT+yJpNzao2zwhNMC6tEFm3hNSP
         ly7odQJIXPJ4tq00vRuILw1HtGfmHFsbOBi04ukhRvKFAN1KTmJvUeHo/Hy9+W9tLChW
         yeirZNR9mPnkLfMgbLGSMmyn9QUoROnzetlCumYLyDJ1d+mb6vAaUtmEpcAZx97B1b+c
         h8X3XV2pfIBkwA+d+nqgBCCwcmS2HA1GHvKpiHCJoGfPE7PQx1Sj+m9eUAVzfU/2Td3d
         CtFPzO7ulV0t9SnoZxjRCwYOb0SPKp0Pe047EREFp2XiGnSb7F1D9EUzKcwNyCnJ+53F
         8zJw==
X-Gm-Message-State: APjAAAUnznX5oLTDgpRAvQ1EfZBdVgIKTfyO0Op9AVM7wKOmzzPl0ZD8
        f6HDpctqWa8cUt87DCJbIqpScw==
X-Google-Smtp-Source: APXvYqzXjszYS29e6Cmc8oD0Uo47Epqq0SwJS5FoW3J5N9rDmzynHTOTAmnXz4a7BB73s4DdnM1hFg==
X-Received: by 2002:a17:902:9045:: with SMTP id w5mr108602172plz.46.1578369842559;
        Mon, 06 Jan 2020 20:04:02 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id l22sm27604050pjc.0.2020.01.06.20.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 20:04:02 -0800 (PST)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
References: <20200106123027.1a162197@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9a87175-64c9-46da-4737-72987a53e836@kernel.dk>
Date:   Mon, 6 Jan 2020 21:04:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106123027.1a162197@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/20 6:30 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> fs/open.c:977:12: error: conflicting types for 'build_open_flags'
>   977 | inline int build_open_flags(const struct open_how *how,
>       |            ^~~~~~~~~~~~~~~~
> In file included from /home/sfr/next/next/fs/open.c:36:
> fs/internal.h:127:12: note: previous declaration of 'build_open_flags' was here
>   127 | extern int build_open_flags(int flags, umode_t mode, struct open_flags *op);
>       |            ^~~~~~~~~~~~~~~~
> 
> Caused by commits
> 
>   4e9e15c9426e ("fs: make build_open_flags() available internally")
>   3bba3e571bc8 ("io_uring: add support for IORING_OP_OPENAT")
> 
> interacting with commit
> 
>   0a51692d49ec ("open: introduce openat2(2) syscall")
> 
> from the vfs tree.
> 
> I have applied the following fix up patch for today:

Thanks Stephen - I'll pull in the VFS tree and rebase the 5.6 io_uring
bits on that. Then I'll send it out for review again, haven't heard from
Al on the non-block open change.

-- 
Jens Axboe

