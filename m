Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C1C14F2E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 20:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgAaTpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 14:45:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43379 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAaTpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 14:45:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so3833411pfh.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 11:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WpGTs6wk68o47CN1/DRt9VHyowucU6UaB1AMmww7rZI=;
        b=jXDzOK3WCXpHkL9Q8yGzO1v05N+a1wZmEMIs6Zs1OkXpjU84OrlAcFMSnYp6wrZ8Cb
         +zXQuD/2Ok9MwT/Q1XYe9Dv8p2KzZg+WKqAKjrvjTpiAKYOPqXhdffHP7mcifqQY5UrX
         +K8N5cHatjM76/sfcIEijjaCMjlh6oOsBX2TazP0V2quD5fYEjtCimihD2TiYkoHvIwn
         LSA/FSUQyQfD/o9wvabHx3D2BP4c0mjcjZuc8O3aWBrefyeRIcBFpu6HizjWkdjaTy/m
         TP0Wg3MSfF9XSSIm0ciWIw7l1v/yo9zxRaLUw2qU6Sderdkx35gx3qpNMNzxRgTlftgZ
         dYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WpGTs6wk68o47CN1/DRt9VHyowucU6UaB1AMmww7rZI=;
        b=lfWAk/dAYrDsifwUoy3UwN+yF6C5RChHLsf1B80izdStXBA3/UPXV9wKIJ5KKqrDes
         wAeMQTAwtS9UTwW/0wKUbm7Q1S6onurSARbhgMF94g4fBsmIctjInVPLRiUdF9pzw0uH
         Z9nk+wILkjMNbXCqQjW1FRpKC0agbrRN0TA3b3jmevIviRu3A1/CopQ6mnG7UO41PaHT
         Vv3dGIx5iiRcriVjg/dB8IxPwaEh3YXOUuFh4Yppjy67XOERzwH+6OVRdgbtrTWuqO4t
         ePNNAc20JXv13XBjNXvoOm7RoPS4YaRlpxycsbaoKrYzeyNzUgqL1aCxyfQAmYnWcasE
         7xdQ==
X-Gm-Message-State: APjAAAUHOZSDSokIYdow+kNIqAunXlHcPOq5vHZhlUNXEt1t2hq7QowA
        EqW4gOGd4NYDFakNIhtmfdebog==
X-Google-Smtp-Source: APXvYqwZQP6nu2iuJWmR5ARlc+7fEa8aUWut81icyjcwj3Nzbu+8zSs8Vo4SfGnmQkvOx3sf49K4xA==
X-Received: by 2002:a63:b141:: with SMTP id g1mr12596332pgp.168.1580499905186;
        Fri, 31 Jan 2020 11:45:05 -0800 (PST)
Received: from debian ([171.49.162.166])
        by smtp.gmail.com with ESMTPSA id d24sm12299704pfq.75.2020.01.31.11.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 11:45:04 -0800 (PST)
Date:   Sat, 1 Feb 2020 01:14:57 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.4 000/110] 5.4.17-stable review
Message-ID: <20200131194457.GA3818@debian>
References: <20200130183613.810054545@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 07:37:36PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.17 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2020 18:35:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.

compiled and booted 5.4.17-rc1+ . No new errors according to "sudo dmesg -l err"

--
software engineer
rajagiri school of engineering and technology
