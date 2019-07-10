Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0D5644AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 11:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfGJJvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 05:51:32 -0400
Received: from first.geanix.com ([116.203.34.67]:51562 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfGJJvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:51:32 -0400
Received: from [192.168.8.20] (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 9058830A;
        Wed, 10 Jul 2019 09:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1562752289; bh=Anc3qLvqQqoj+ZC+cEIfZy5xFnlWI1L+yTCIBGrNCic=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FhQnwWbjze5et81xbmPl9z5dFlZn1VgxDyMkuXvple33vECzwqTcG6vjeYZE1RJoc
         aPmsHqpExoxCA9L9/F2BcIm0SZAxGna89sLrzng+L5hI9Ke85ybJsz7F1eHOH/XESm
         1AViR1A9jY+i8U91ZwXXcoMGbnmZ200j4PFNPjMdy6B46S8+OJyDdRiePMuwmHxGQd
         jKsCdY395FaJcxzATw8HF7o/6odn0XBLJl2VHFZ4NN4f1otj8Pz3ctbNQVCisuJ46H
         6YdDEFIycghTaEU3wr0HUf8xiH0VX9l4sMYZwvutOCu4W8aslofUpwnM/15p31R1Qb
         RukcQ9UTXldTw==
Subject: Re: [PATCH 4/4] tty: n_gsm: add ioctl to map serial device to mux'ed
 tty
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
References: <20190708190252.24628-1-martin@geanix.com>
 <20190708190252.24628-4-martin@geanix.com>
 <20190709162221.623f99ce@alans-desktop>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Message-ID: <789b9d92-8110-d9e6-796e-e372d440fe51@geanix.com>
Date:   Wed, 10 Jul 2019 11:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709162221.623f99ce@alans-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8945dcc0271d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2019 17.22, Alan Cox wrote:
>> +	int base;
>>   
>>   	/* open the serial port connected to the modem */
>>   	fd = open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);
>> @@ -58,6 +61,11 @@ Major parts of the initialization program :
>>   	c.mtu = 127;
>>   	/* set the new configuration */
>>   	ioctl(fd, GSMIOC_SETCONF, &c);
>> +	/* get and print base gsmtty device node */
>> +	ioctl(fd, GSMIOC_GETBASE, &base);
> Can we at least use a specific sized type ? uint32_t or whatever is fine.

Sure.

I am also considering whether returning the base (i.e. the unexposed 
control line) just confuses users. It might be better to use 
GSMIOC_GETFIRST instead, which would then return 1 for the first mux, 
and 65 for the second, and so forth.

// Martin
