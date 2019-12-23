Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9D12928D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 08:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfLWHxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 02:53:15 -0500
Received: from mail2.skidata.com ([91.230.2.91]:62533 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWHxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 02:53:15 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Dec 2019 02:53:13 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1577087595; x=1608623595;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gkBIp1DHlnurKEshixvjjdnqm0eb66u2RGY3CwCCMXw=;
  b=NB6T6jGIspIkz+OObZFGj1htej0leCYqIFC27zhpiYofqPz8dEhcTmby
   BTgyre1yyY7y3nLAQD9hD5ot4wOADeyNgeKDm6I/qzeDHN25qRuCSOmu8
   Wns2Ou0/dbvcrtdd/6fvg+C6SDYdWtlXyDVAgE5WM35dIVL/MGq1gQ0pX
   4P899sM4H81C+Ui2fGBdXJtXj5Mh7CX+K76CysBKaLMl+txZOparXKx9w
   TTkiV622QyoAXx0Wgc1A/B/F2kDc/971Q8OK0zsDBkq5zZZYTv9PXBGXJ
   QYVf/qaLsk+r/Z9RJpJ90idsQY0rWwvr4Q6LdKPBhw4wQAO1geu6Z1czk
   g==;
IronPort-SDR: /Dd/5G8ZixAieCds/iB8OgiPPmpLnPoT53Bshk5N6ryAfgDbGZlf2u6yV15CF34b3zVpGLYLBl
 kRqJZxupg+ms+FYn6TgHkUUocajU0F/VeuCYvJymqvnOwWSbunQq2v3f7IRufVBUHhyfSPqHMj
 zTBNJZjvpRr+minHn9RjqMXUlnLtbsGqiBzMZx+x6EV6fF8X93pQGAxf+LJ5uk0+1A53S0u0ej
 BU5H/qilPHwNCqKWSLGHPRRQ3p6syEnJxQg8PK1qGc/WcT2hqyXTgXqJPpyu79MsXAMcQjEjmW
 X9k=
X-IronPort-AV: E=Sophos;i="5.69,346,1571695200"; 
   d="scan'208";a="2469609"
Subject: Re: [PATCH 1/2] ARM: dts: tegra20: add labels to i2c nodes
To:     Dmitry Osipenko <digetx@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20191219130431.30458-1-richard.leitner@skidata.com>
 <01ac756c-1e51-5d62-ca45-9e0b4f106a29@gmail.com>
From:   Richard Leitner <richard.leitner@skidata.com>
Message-ID: <27d4c933-8117-f38e-d4da-e58326fc6ee4@skidata.com>
Date:   Mon, 23 Dec 2019 08:46:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <01ac756c-1e51-5d62-ca45-9e0b4f106a29@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
thanks for the reply.

On 20/12/2019 15:00, Dmitry Osipenko wrote:
> 19.12.2019 16:04, Richard Leitner пишет:
>> Add numbered labels to the i2c nodes of the Tegra20 SoC so we just need
>> to alias it from derived boards.
>>
>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
>> ---
>>   arch/arm/boot/dts/tegra20.dtsi | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)

...

> 
> Hello Richard,
> 
> Why derived boards couldn't label nodes by themselves? That's what all
> derived boards are doing already.

Of course they can, but IMHO its more useful to have the same labels for
all derived boards.

> 
> BTW, upstream should benefit from the submitted changes. This is not a
> very useful change for upstream if you're not updating the actual DTs of
> any of the boards in arch/arm/boot/dts/*.

That's true. I thought of also patching the actual DTs but wasn't sure
if that should be in the same series...
Based on your answer I guess it should be.

Therefore I'll send a v2 soon.

Thanks again & regards;richard.l
