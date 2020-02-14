Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC5415EA1A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 18:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392145AbgBNQNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 11:13:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41459 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391994AbgBNQM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:12:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so3890888plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/968X58dLK1gbF0pDZtAYWHd3eejljCvh2jL11+eONM=;
        b=UQILWCtwnIBJgebvt5RT9JS5S2A5Gb+PhZQY94Uu5TmLGYT+bSG687sDAppoY4pWFH
         9pCgh5x7EN14c7S063FkkVdKpxMEuMwarDA4W2dGDhfDrYmFr42b+2q+7kABQovc3zm9
         5ffZ8IHJdJUG+ieABc2OKb32PWGY9BgPzYkfkW5jrgHCPVpweIuWPGlR9b1rVEj9HCib
         Y6J6z46dhhQ0WRMycx7v1XZy3po7OYGmDVwZW/4Lyooj1ummYkobgUGEkbOxC+H57oIc
         vE3xKhsfABJcpjzR1QOFLiz2inoo2uKHreWxxxEd6TA/a44pNMj73dvGPBAtm8w6R/zc
         Ti1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/968X58dLK1gbF0pDZtAYWHd3eejljCvh2jL11+eONM=;
        b=DVybH3e2P+8A8sylPuP0HAIzObam7d18oqTuyJY2HxV2l3eE1bX/jSA+GOWGZe9EsP
         8QaFr73QT2eoxvx+y3i6ZKe48hYr7//y5LV4rMNDqgHf4Uh7wg44cBoKl9rot2BOY145
         srRJ5Yjt4NtZSrbhwKrntqn2B9542W72oEGCnLDEOmu/sddEqSLhbd3HvwAUJwsd3ELX
         usHcqkI5cyluksQH0zFZvTReEXFcQBYeeIZEZJ/9KPCUAoPbrqyM9IgOVLWU5eQoXdSC
         +WKgXjeGeIDQjdmZj1CEoy7rNICjNsShKWpGHIUR60t4m/6NFOLeytdz6HCNfYqtQxrR
         TscA==
X-Gm-Message-State: APjAAAX44z5PVL/PWlRvVtxMDym8inn5UMeUtimZHaIB62ttF3SpG06T
        gxFhdrIT2TT3cXRdpoaMeJyAkw==
X-Google-Smtp-Source: APXvYqwfgkPahw7rPkhdNNYFa40haQXJ7XrXUEWcN8SPIy5CCPGbJU6qPxWgNvJNG5WtKc+QAd63dw==
X-Received: by 2002:a17:90b:243:: with SMTP id fz3mr4623644pjb.29.1581696744437;
        Fri, 14 Feb 2020 08:12:24 -0800 (PST)
Received: from debian ([122.164.201.151])
        by smtp.gmail.com with ESMTPSA id p3sm7727709pfg.184.2020.02.14.08.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 08:12:23 -0800 (PST)
Date:   Fri, 14 Feb 2020 21:42:16 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.4 00/96] 5.4.20-stable review
Message-ID: <20200214161216.GA2654@debian>
References: <20200213151839.156309910@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 07:20:07AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.20 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Feb 2020 15:16:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.20-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.

hello,

compiled and booted 5.4.20-rc1+ . No new error according to "dmesg -l err"

--
software engineer
rajagiri school of engineering and technology
