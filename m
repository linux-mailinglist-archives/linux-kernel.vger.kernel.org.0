Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309071903D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 20:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfEISdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 14:33:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33293 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfEISdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:33:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id 66so3261015otq.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6LDuh9KBtjyZgSBqOPlt4ghOhYRTyR7+OimbX5fXjTc=;
        b=m7MZm5jn+yUTyqYeKP+3U2AfIk2e/Jl7gRlj1d0vNElu89qzzwPGU4WFh2pRN3iGK8
         6NkXYiIaZxmWqTWtDTsXMCjBrxg3Wi+ON8VLjl28KeXWmZ1yCAk7U2iA9U5wOLGpVrf6
         4C4jvycCm53aEaILky7UnN3UKRuEHLH4DYCjk6kbWNpnMsPw3O4PTkZ34RDNe5jWnbck
         UmNUnENCXk7ZL3MZ1rYS34gPy7dbedYHUod/vucgxDHzv2UGKYZZ9m/Ped5rsgK+BFk/
         Fy+UM5SnDsH5pIswj8zYSyHMqUWESF+i8+t6ovRwRYGQ/c3kpcWuWIDJlTrTTBHJz/6S
         zOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6LDuh9KBtjyZgSBqOPlt4ghOhYRTyR7+OimbX5fXjTc=;
        b=JOiIxW4WrhU7bp6e6UYx6oe9CphRbsRJb9Tg9nVjYIS/s7rr2AY0H4yUf8jUIj5auJ
         hSdOWvjf8robpuvVxYxAU9C0dPPPGoiRNGold0bDkfGGPzqWE5x3ioyZ+VJPcOLy1I0U
         q9m4IM1rHdBjLHZuGnVd2jbC5FsY6lDgFHQXGb3OxCk7gIsqRBVkMFyLi61ASYEbT3Er
         9q6f1BUeB1if/eVS6dFpez1bA0ncb+wN8+6dtroIxgmuqhW/LMyvSCb+TXgJu26xjnc+
         3b6TLwezRvbf1BxFdFyAhcVS2bbMyuR75gDAb6YIT6LQoeXIn22kUeTCk8VuaMmIdBqW
         P7uw==
X-Gm-Message-State: APjAAAVJulb0vudRylngDB/YUyZtivaRCndBR+xo86YTT4eMbDlEO5Pd
        fdvqtxqSWnYdTqXgURgMlzNzCg==
X-Google-Smtp-Source: APXvYqyC+t5IsIZRkPqBYoKSelJuMnV/D1ZbE+b+3mQahrODmHmWzUUCjlIwBfKd2Oj/f6iFjJVnEg==
X-Received: by 2002:a9d:7c88:: with SMTP id q8mr151513otn.167.1557426829720;
        Thu, 09 May 2019 11:33:49 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id j1sm1034165otl.43.2019.05.09.11.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 11:33:49 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, james.w.mcmechan@gmail.com
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <fca8e601-1144-1bb8-c007-518651f624a5@landley.net>
Date:   Thu, 9 May 2019 13:34:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509112420.15671-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/19 6:24 AM, Roberto Sassu wrote:
> This patch set aims at solving the following use case: appraise files from
> the initial ram disk. To do that, IMA checks the signature/hash from the
> security.ima xattr. Unfortunately, this use case cannot be implemented
> currently, as the CPIO format does not support xattrs.
> 
> This proposal consists in marshaling pathnames and xattrs in a file called
> .xattr-list. They are unmarshaled by the CPIO parser after all files have
> been extracted.

So it's in-band signalling that has a higher peak memory requirement.

> The difference with another proposal
> (https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
> included in an image without changing the image format, as opposed to
> defining a new one. As seen from the discussion, if a new format has to be
> defined, it should fix the issues of the existing format, which requires
> more time.

So you've explicitly chosen _not_ to address Y2038 while you're there.

Rob
