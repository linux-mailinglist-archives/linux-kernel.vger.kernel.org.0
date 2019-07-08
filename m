Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE46628FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 21:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390728AbfGHTJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 15:09:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45260 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390590AbfGHTJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:09:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so17028063lje.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dA2xhiNGZ0tuWmkiPtLUTjcqW1BzzQUxradpm/yDvWk=;
        b=H/Qz6Zl4qWwcws/K4ttAjHFj7ySNEcnvAfua+hF3xC61yiKJu8+PHKTL9/3Q79Ov0F
         04UJsxxgK8HOgQFcL+Y995nNvXIOkKe975rJKD3bDttCNpDbpKWx3P/LaqlIuugcGT8q
         2ZyIADyyETAdZHQUyluRBkVRjZTX98gebReZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dA2xhiNGZ0tuWmkiPtLUTjcqW1BzzQUxradpm/yDvWk=;
        b=hJNaRHzhGF5btn42vYSLqizMqGfzQ4p2LGnb9Tcjr4o2lCn8UgfBfFKB4PwSTjmqA1
         d64Rfh7FscE+Kaaqk5c5wK7BkeeZm9fSHwzDls6nMHy1BqpqE0bO9BLMzLnmHElOvAr3
         KykRROrpaHd3dbn+gewbi7Y+145A0L/modnbqztziNx58GBa/ehyiSbmLRgHpongJMFy
         oJqu3cMvW+0sRY3JfVEYMJvPJ+8w0ppsetUNbMZ8buKPXVL8uekI3Dic3G+tqTwjWYh0
         HNuj4GyjocCrFOR/sBkEUaHWBCh+3kvX9E+TN7c4Q19Mhaq0BzF4Gg8XTdITRoD6gI8M
         g+Zw==
X-Gm-Message-State: APjAAAURrJEKT3LFZS4FQhy3aqTVt4qUK+jqdcdLrEBC7LcSNF/Wl4XX
        8pC9wQTpOnDwO2cx6gMd8Z+Pmw==
X-Google-Smtp-Source: APXvYqwcb8orHaqFemykl0AZtk0WZ0DDmrGen5cKEPKeIzWzqPpyTZWQsDBi7rDXGKW6XAxiXf08jg==
X-Received: by 2002:a2e:858b:: with SMTP id b11mr11221294lji.159.1562612985927;
        Mon, 08 Jul 2019 12:09:45 -0700 (PDT)
Received: from luke-XPS-13 (77-255-206-190.adsl.inetia.pl. [77.255.206.190])
        by smtp.gmail.com with ESMTPSA id k4sm3834016ljg.59.2019.07.08.12.09.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 12:09:45 -0700 (PDT)
Date:   Mon, 8 Jul 2019 12:09:42 -0700
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/56] 4.14.133-stable review
Message-ID: <20190708190942.GA4652@luke-XPS-13>
References: <20190708150514.376317156@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708150514.376317156@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 05:12:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.133 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 10 Jul 2019 03:03:52 PM UTC.
> Anything received after that time might be too late.

Hi Greg, 

Compiled and booted on my x86_64 system. 

Thanks, 
- Luke
