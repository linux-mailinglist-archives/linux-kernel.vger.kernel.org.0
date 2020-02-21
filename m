Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5731681E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 16:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgBUPgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 10:36:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgBUPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=mOBq/DnlITgcMyGEsOv/16qY2RfS/eYU8Wrrz6Eva3A=; b=TY0RXMwJFDfbeRIjGlCC1oEc38
        VEw6sYUqBf1rgqJPRie4U5JOEBc3EiEY5V7x9pK7yJfj52VpMUBgGvcVQ1jdv3qG5KiukUNVjllQv
        eoMWUwgeYbbORIpoMW+x38rcZOK1kGyuRNmNv4PVoyKX75u7PLdDCtmHsRjdvz6Xe9+X5Vu+UPlEW
        Eef3FM4yjlaQJuEd2L1rGxOYJCmUyZB1UFeLhHhvZATBFDNARv9yzMiv7UuEPpGnptAsBkhRKPkbz
        D+q9gwn/Mm9kQrcWe3Zq5b8xYQdu52xq180ZRDbOYtWRAetzH1we52lPzdNRlps4jbY5LFDvaHOnU
        CQATVA4A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5ALw-0006Lr-NS; Fri, 21 Feb 2020 15:36:32 +0000
Subject: Re: [PATCH v3 5/5] add i3cdev documentation
To:     Vitor Soares <Vitor.Soares@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
 <a6f65d23947070f52c43fee4a1427745ea675ae0.1582069402.git.vitor.soares@synopsys.com>
 <13770b93-d98b-81d7-0cab-92daf9151ee6@infradead.org>
 <CH2PR12MB42160E59DE750C4C4242E6E8AE120@CH2PR12MB4216.namprd12.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <994bfe97-af31-3423-c293-2beb75e0406a@infradead.org>
Date:   Fri, 21 Feb 2020 07:36:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CH2PR12MB42160E59DE750C4C4242E6E8AE120@CH2PR12MB4216.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/20 2:31 AM, Vitor Soares wrote:
>>> +BASIC CHARACTER DEVICE API
>>> +===============================
>>> +For now, the API has only support private SDR read and write transfers.
>>                         only support for private
>>
>> For the unfamiliar, what is this "SDR"?  (thanks)
> SDR stands for Single Data Rate. In I3C we can also have High Data Rate 
> (HDR) modes:
>   - Double Data Rate (HDR-DDR);
>   - Ternary Symbol Legacy (HDR-TSL)
>   - Ternary Symbol for Pure Bus (no I2C devices present on the bus)
> 
> Should I use Single Data Rate instead SDR  for the first time?

Yes, please.

thanks.
-- 
~Randy

