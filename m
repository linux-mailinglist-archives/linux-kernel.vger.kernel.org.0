Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E94C8EDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbfHOOLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 10:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732784AbfHOOLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:11:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D5C9206C2;
        Thu, 15 Aug 2019 14:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565878276;
        bh=MK9pYDd/pRkYq15ySrVY/G8VYSCibcH28hj42sQPutU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fh7wLHe55Sx3SEiOAYQq+MSIm3VGalOMrHqD3ygCTAbH4q/zL0T56AuRKRALpbgNS
         q3e5qT3Ea8YMS6i7l1+8NivtOIPInIEc4reypEwATXJgIpDbyUsqEKGPuZIKfpO/D3
         YNoxxDWFDE9fgpaVrDbXnbAaUm+JHJYBq8MbZesI=
Subject: Re: [PATCH v5 0/2] usbip: Implement SG support
To:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190808155435.10050-1-suwan.kim027@gmail.com>
 <20190814131951.GA1437@infradead.org> <20190815132356.GB27208@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <0cf92881-53c7-09d4-18ac-593034a1a56c@kernel.org>
Date:   Thu, 15 Aug 2019 08:10:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815132356.GB27208@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/19 7:23 AM, Greg KH wrote:
> On Wed, Aug 14, 2019 at 06:19:51AM -0700, Christoph Hellwig wrote:
>> FYI, I think my
>>
>>     "usb: add a HCD_DMA flag instead of guestimating DMA capabilities"
>>
>> is the proper core fix for what your patch 1 works around, as the USB
>> core should not assume DMA capabilities based on the presence of a DMA
>> mask.
> 
> I agree.  Let's wait for Christoph's series to be applied before taking
> this one.
> 

Great. Thanks you both looking at these. Makes sense.

thanks,
-- Shuah

