Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18B212D4DD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 23:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfL3Wl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 17:41:57 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55732 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfL3Wl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 17:41:57 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so386215pjz.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 14:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xba8FIFzefmv0Pl2yIOHKi2YLMOHTYOjvq/MJDGzbZk=;
        b=oaVlu4ZMb4nJbS8ZAIVbkqLg70LBaTIXwRgvcZZv9SZ248sYUojeDA7qhAd886zZac
         rh9TzFPFxLxPtXU7prskTsr7rL+40M5oYvNuQKFkHgDq1RBNMlak+5SOCJSpFS7YClZY
         c3MHo8ep6VHp9qeUWmCewR18X79OodEPTizuJvdhuUdB/jGBfRyKT/CLR0Kj449F9dSo
         Awr5vHUv3bb8kLJVrFqN8VqLk90VYqZQrVorTvzh20YpKWxTOWEjo0VbAV1/WsozKxJW
         M3WZo8273CPMcm+gw5Bx1T5jRiQnoHQP8MprR5YvRbcakf6ZfvOqfGSUQuPZgdOCAyLd
         Ycrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xba8FIFzefmv0Pl2yIOHKi2YLMOHTYOjvq/MJDGzbZk=;
        b=sv2PbyXoXDZUePcz2HseqxA1mSrszOQX5+QxcpZ86ENBK9n2FBxNQ3blhKfhwTKG80
         pR/kyjTNfsz7CvBfa7qHXbaY1Hw8/lGVCB6zU4bFwDwLbn/mQxDeG9VO2zbfVYRNyBQ7
         5/gRqrxkj58FFY3bmxLiweIjMNz6/MxNqhzt/RvYqX3BLFatzPPE//AcUwcvwPtfTNav
         c/w8F15C3amQ1K+pA2MKHn04UaUIygmR5fP4ycmJiqHrzlMLegxZBZLPl5m237sGA0/z
         59bDl3jyEJq1E4wjpkkBseqEtJmrfaVc2X8vpCZLZM7okySW18EEn+XyHTSVCn5B48dO
         Qdrw==
X-Gm-Message-State: APjAAAUUMwebbil4ObZ0uqVaRNUXTzJOLcxXQ83VasSBbqJkqM81hBcF
        U5T5Qia0P0ogKTgZmSDmZU9P3s5m7Tg=
X-Google-Smtp-Source: APXvYqxDJQOkw3IpX2MxSfODfbrqMn2AEST8zRa82EX9XuOmIXDLDrUxdaPdU89Cg2vVy5Y5+ZNBDw==
X-Received: by 2002:a17:902:a5c1:: with SMTP id t1mr47250002plq.87.1577745716055;
        Mon, 30 Dec 2019 14:41:56 -0800 (PST)
Received: from debian ([122.164.19.238])
        by smtp.gmail.com with ESMTPSA id z19sm49933366pfn.49.2019.12.30.14.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 14:41:55 -0800 (PST)
Date:   Tue, 31 Dec 2019 04:11:43 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.4 000/434] 5.4.7-stable review
Message-ID: <20191230224143.GA3074@debian>
References: <20191229172702.393141737@linuxfoundation.org>
 <20191230174336.GA1498696@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230174336.GA1498696@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 06:43:36PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Dec 29, 2019 at 06:20:53PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.7 release.
> > There are 434 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue, 31 Dec 2019 17:25:52 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.7-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> 
> I have pushed out -rc2:
>  	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.7-rc2.gz
> 
> to resolve some reported issues.
> 
> greg k-h

i have compiled 5.4.7-rc2+ related and "dmesg -l err" has no new errors.
"dmesg -l warn" all clean

--
software engineer
rajagiri school of engineering and technology

