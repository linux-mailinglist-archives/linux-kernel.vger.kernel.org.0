Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BC918F864
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 16:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgCWPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 11:20:15 -0400
Received: from ciao.gmane.io ([159.69.161.202]:33788 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbgCWPUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:20:12 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1jGOs7-000HIK-CE
        for linux-kernel@vger.kernel.org; Mon, 23 Mar 2020 16:20:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] perf cpumap: Use scnprintf instead of snprintf
Date:   Mon, 23 Mar 2020 16:20:06 +0100
Message-ID: <8bb4696a-3470-6613-50ce-a002fbce6b23@wanadoo.fr>
References: <20200322172523.2677-1-christophe.jaillet@wanadoo.fr>
 <c0441e54a07e424f9646ca232d44e9d8@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <c0441e54a07e424f9646ca232d44e9d8@AcuMS.aculab.com>
Content-Language: en-US
Cc:     kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/03/2020 à 16:11, David Laight a écrit :
> From: Christophe JAILLET
>> Sent: 22 March 2020 17:25
>> 'scnprintf' returns the number of characters written in the output buffer
>> excluding the trailing '\0', instead of the number of characters which
>> would be generated for the given input.
>>
>> Both function return a number of characters, excluding the trailing '\0'.
>> So comparaison to check if it overflows, should be done against max_size-1.
>> Comparaison against max_size can never match.
> NACK.
> Since snprintf() returns the number of characters it would have
> written to an infinite buffer the comparison can 'match'.
>
> However it should test for (ret >= PATH_MAX).

Agreed. I'll send a V2.

CJ

> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
>


