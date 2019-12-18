Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABEC6123EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 06:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfLRFZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 00:25:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46300 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfLRFZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 00:25:05 -0500
Received: by mail-qt1-f194.google.com with SMTP id 38so970847qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 21:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uIMTyYXR3nXqdy95e1OaQ4blqi70Uo0OIJA0JwHv2YQ=;
        b=zNU9URTpXbNk0H+bfxQuplRFAZ/+QuFZ6Yd096coCKdylsucVnKFkkww084LxKN7G6
         ulzFsZdIg6SVR4tgU5cDYYlo0CXtfCmJPQycPblX0FFaYBE+cL5OKLuhei9teC6wUmmK
         Oc84j0+Vw2gcCS4XC4WrHqz+fOgW/0CdiGR1dfMf/HODZ23IlHU7H1OJ2CmQoBfC4Z94
         f3LbaBfhZ7wGluYaje4wnjvDGbcUfG9nrco1qf0kRn8/Ks0eSGsFKNjKDm+D7ZY8tNEi
         OLH5Ejd9W1dUkuKA9ZRRYIkpvVpXSQKY6b9y3iYGtMQQIKB/nk3glaiVf+nHotXjSwF/
         CilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uIMTyYXR3nXqdy95e1OaQ4blqi70Uo0OIJA0JwHv2YQ=;
        b=pzMtmIAyGbHn3S2ESG2Dsu9XS+WZdDkv/6+8CxGbT1smY44BQ8bKtBHo5gOj4mfaIu
         UtSxnPcUcU1Y4WLL8tRBUbaaSAFRVx2uLGA1yrbqFW37OxEDgXR6iBtFynQzXgWB2nOn
         hY+Gu0KyYMgr8DusfgCP0TZLbk263My7w4Q4W3rV31oecm2n9/1DS7rzR8Hru7LKthvY
         YOaeohYGFdzGrk2Xl3mb8JF0jw1AwQECiBtGZQnJExnmWIRBE6e1zavX9014WGKzJ4rK
         xV+afSbWgxt4HSAiMZBtHUNHkHmgZiOWOiLqaWkVwJTO0S8F2QIztvDOSgltlMl2f2fg
         oyTA==
X-Gm-Message-State: APjAAAVxQ7b3HVAGTHR1SBQx3NeZ0AV3lZU6dhjW2v0TriRDvz8DgL7E
        l0lbPFoYDlCNLS4sCDVz0gpbgk4d8cmL0A==
X-Google-Smtp-Source: APXvYqw0LJ2pIxnufMfbafewC8CwiqT+EqKHOTuPpD18gUxiTVv4YVZQUuZHJ8Y4ZurUv0V5JwW/og==
X-Received: by 2002:ac8:2af4:: with SMTP id c49mr659933qta.367.1576646704962;
        Tue, 17 Dec 2019 21:25:04 -0800 (PST)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id t7sm315351qkm.136.2019.12.17.21.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:25:04 -0800 (PST)
Subject: Re: [PATCH] pcie: Add quirk for the Arm Neoverse N1SDP platform
To:     Will Deacon <will@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20191209160638.141431-1-andre.przywara@arm.com>
 <20191209162645.GA7489@willie-the-truck>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <dacfd8bf-0f68-f2af-9238-4b0fadfbdfe3@jonmasters.org>
Date:   Tue, 17 Dec 2019 21:21:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209162645.GA7489@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/19 11:26 AM, Will Deacon wrote:
> On Mon, Dec 09, 2019 at 04:06:38PM +0000, Andre Przywara wrote:
>> From: Deepak Pandey <Deepak.Pandey@arm.com>
>>
>> The Arm N1SDP SoC suffers from some PCIe integration issues, most
>> prominently config space accesses to not existing BDFs being answered
>> with a bus abort, resulting in an SError.
> 
> "Do as I say, not as I do"?

In my former role I asked nicely that these patches not be posted 
upstream, but I see that they ended up being posted anyway. Hacking up 
upstream Linux to cover for the fact that a (reference) platform is 
non-standard is not only not good form but it actively harms the community.

You'll have people consume this platform and not realize that it's 
broken, IP won't get fixed, and generally it'll be a mess. Yes, it's 
unfortunate, but so was taping out that platform without working PCI. We 
all know what should have happened, and what the right move ahead is.

Jon.

-- 
Computer Architect
