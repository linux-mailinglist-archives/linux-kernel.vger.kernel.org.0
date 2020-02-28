Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53948173125
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 07:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgB1Gg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 01:36:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54757 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgB1Gg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:36:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id z12so1969808wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 22:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m49OdKPe1I/oPM1RnkJb6B2gHY6zkx2O7ln3AzFZcfU=;
        b=ATAbGjogBvVdPfzGc7nWLhIysYWI0IeFcclb3bwuMJA/jCu1D+zew5i++bdrqRSqaK
         WdfsIsfHlggASETKp2IrEB2lX4ZSQ3Kdzh+vvufqEVmJWY2Uo7QaPihzBYDAWZHkTFzX
         UqF5EagV2+pQu6ToENGYUbBlLkh1igMHH/694s6EcKN1Or/cU8RU/09xf5eYHwKXPSHR
         m9G6z4J4NRqP9aajm/6xfPTLZgoD1aUwBpDTUWbgSSsJOeVW2l4iHHL5ByhgyxFQenSu
         i/zoWc/CO50mhPR4P7DA2wtIwVYfpy3ZLS1ihleCQBM/CwRJsQf0y6ODMavx9WU2XJHi
         /Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m49OdKPe1I/oPM1RnkJb6B2gHY6zkx2O7ln3AzFZcfU=;
        b=FgY80An4DETwtfYqLZPTlnfqw4R2H4HNmtwwqWxYlx+Ow7Gj/QVj5UqTxav80M5tJW
         f+QCWQ1bnue1T1XshL50BmN7jxGnvG7q9HC5pamrvxv6cPuhscmmTYC1oXjyxouIcCW2
         LWLFGzKdYGuMvGCpVAAqRLfqRU4gtv+H0kEBAohcuqlEuQVuvzoKba+ojyOW7/07mL8m
         eVrmszUU25GzjLwh5Fmsq5Gx2lpLqvk5JcWi8XOLK8FrLB3rQc43t+P3E6S8nmAmS2sv
         Wgr4FIL9kOzjJw1EgWZXV+FaVhENAbmSV17p9YNxF/wWiRMlCO20l4oerlWWSdj4iB4V
         4fpg==
X-Gm-Message-State: APjAAAWNDjgVvTaFNUIklgDvsoicWKtUNPGOKGTdxQ0HBnF5QKQ24XjA
        tV8Mi0otZhHgu/zK6hn67DmIzs3QHRM=
X-Google-Smtp-Source: APXvYqz0V6Uk9J3YCoC1wGe50nb9nt68xJZQGKZs6eOrVSfnA0BSW27zUDWztk3gdFiF+lGVMzQxGg==
X-Received: by 2002:a05:600c:2409:: with SMTP id 9mr3208126wmp.140.1582871784752;
        Thu, 27 Feb 2020 22:36:24 -0800 (PST)
Received: from localhost (ip-89-177-130-96.net.upcbroadband.cz. [89.177.130.96])
        by smtp.gmail.com with ESMTPSA id l4sm11640069wrv.22.2020.02.27.22.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 22:36:24 -0800 (PST)
Date:   Fri, 28 Feb 2020 07:36:23 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>
Subject: Re: [RFC net-next 1/3] net: marvell: prestera: Add Switchdev driver
 for Prestera family ASIC device 98DX325x (AC3x)
Message-ID: <20200228063623.GI26061@nanopsycho>
References: <20200225163025.9430-1-vadym.kochan@plvision.eu>
 <20200225163025.9430-2-vadym.kochan@plvision.eu>
 <20200226155423.GC26061@nanopsycho>
 <20200227213150.GA9372@plvision.eu>
 <20200227214357.GB29979@lunn.ch>
 <20200227235048.GA21304@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227235048.GA21304@plvision.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 28, 2020 at 12:50:58AM CET, vadym.kochan@plvision.eu wrote:
>On Thu, Feb 27, 2020 at 10:43:57PM +0100, Andrew Lunn wrote:
>> > > Please be consistent. Make your prefixes, name, filenames the same.
>> > > For example:
>> > > prestera_driver_kind[] = "prestera";
>> > > 
>> > > Applied to the whole code.
>> > > 
>> > So you suggested to use prestera_ as a prefix, I dont see a problem
>> > with that, but why not mvsw_pr_ ? So it has the vendor, device name parts
>> > together as a key. Also it is necessary to apply prefix for the static
>> > names ?
>> 
>> Although static names don't cause linker issues, you do still see them
>> in opps stack traces, etc. It just helps track down where the symbols
>> come from, if they all have a prefix.
>> 
>>      Andrew
>
>Sure, thanks, makes sense. But is it necessary that prefix should match
>filenames too ? Would it be OK to use just 'mvpr_' instead of 'prestera_'

I would vote for "prestera_". It is clean, consistent, obvious.


>for funcs & types in this particular case ?
>
>Regards,
>Vadym Kochan
