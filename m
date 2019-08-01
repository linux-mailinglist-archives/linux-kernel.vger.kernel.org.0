Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 384B57D836
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 11:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfHAJGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 05:06:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40700 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHAJGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:06:02 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ht728-0007Tj-20
        for linux-kernel@vger.kernel.org; Thu, 01 Aug 2019 09:06:00 +0000
Received: by mail-pg1-f199.google.com with SMTP id h3so44757813pgc.19
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 02:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CE/jIvfMb8MGoIQ8tRgk5BgnN9f/9L2WwMekkyWaOOI=;
        b=Bkt9Y3gkRSxC0CJNLMICB2hwsc5glSocnB8WIG4XccAerUaP18GJAPKbMkrQ9xJrMy
         gQF6xMk/rmiKljVV5wYkZyrx8upnWyXqB1PfMcxwVdT2VTZk82VRQt9JiWS54aS8cfrT
         EqNE8WRLwH0tLmu0Ff5xtBj6EBIbIvg8wE/z3ImM8GrFKt5A3eua3UMBKwAe7IujcIME
         OyAsP74BhMOJtZku30qxNGo7r3tYMRauDush+wKxLCwv5moVP4x3R/obtX4Cvde8uOEC
         K69Td+LNX1Btv1GbNDLYNqYf7xHbcjT+Ae1JQ7fXDPftqth+gr4mAziLzTUZPFU8irp0
         tQmw==
X-Gm-Message-State: APjAAAWPDk8oEl0DeOh3Gs2HILPBZXJiTJR9ScPDHldz/Mg6gpESe3M1
        yUMMEJDfLHsLAllkrOJPQ1HhYbY+OmUjzgJ/TCV0U437Jc1/J9afSgXSOw8mKvydqvTUmOWJtdc
        mlxD4sw2V51bWwHu1080K5HdGOOPJWOHVBWI2+RnOOQ==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr37995693pla.34.1564650358686;
        Thu, 01 Aug 2019 02:05:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAXl4RJjTfmo0Fjo42W3mWvcZyKw/aanim8XYIpsdISoCCH8mQj5GW8+GFyrYPLhWNDtgylw==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr37995661pla.34.1564650358329;
        Thu, 01 Aug 2019 02:05:58 -0700 (PDT)
Received: from 2001-b011-380f-37d3-ac53-c2c3-6814-e821.dynamic-ip6.hinet.net (2001-b011-380f-37d3-ac53-c2c3-6814-e821.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:ac53:c2c3:6814:e821])
        by smtp.gmail.com with ESMTPSA id s7sm3536097pjn.28.2019.08.01.02.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 02:05:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAJZ5v0hxYGBXau39sb80MQ8jbZZCzH0JU2DYZvn9JOtYT2+30g@mail.gmail.com>
Date:   Thu, 1 Aug 2019 17:05:54 +0800
Cc:     Keith Busch <kbusch@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Content-Transfer-Encoding: 8bit
Message-Id: <70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain>
 <CAJZ5v0hxYGBXau39sb80MQ8jbZZCzH0JU2DYZvn9JOtYT2+30g@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 06:33, Rafael J. Wysocki <rafael@kernel.org> wrote:

> On Thu, Aug 1, 2019 at 12:22 AM Keith Busch <kbusch@kernel.org> wrote:
>> On Wed, Jul 31, 2019 at 11:25:51PM +0200, Rafael J. Wysocki wrote:
>>> A couple of remarks if you will.
>>>
>>> First, we don't know which case is the majority at this point.  For
>>> now, there is one example of each, but it may very well turn out that
>>> the SK Hynix BC501 above needs to be quirked.
>>>
>>> Second, the reference here really is 5.2, so if there are any systems
>>> that are not better off with 5.3-rc than they were with 5.2, well, we
>>> have not made progress.  However, if there are systems that are worse
>>> off with 5.3, that's bad.  In the face of the latest findings the only
>>> way to avoid that is to be backwards compatible with 5.2 and that's
>>> where my patch is going.  That cannot be achieved by quirking all
>>> cases that are reported as "bad", because there still may be
>>> unreported ones.
>>
>> I have to agree. I think your proposal may allow PCI D3cold,
>
> Yes, it may.

Somehow the 9380 with Toshiba NVMe never hits SLP_S0 with or without  
Rafael’s patch.
But the “real” s2idle power consumption does improve with the patch.

Can we use a DMI based quirk for this platform? It seems like a platform  
specific issue.

>
>> In which case we do need to reintroduce the HMB handling.
>
> Right.

The patch alone doesn’t break HMB Toshiba NVMe I tested. But I think it’s  
still safer to do proper HMB handling.

Kai-Heng

