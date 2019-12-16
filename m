Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7354F11FFE7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 09:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLPIeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 03:34:12 -0500
Received: from mail.sysgo.com ([176.9.12.79]:51130 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfLPIeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:34:12 -0500
Subject: Re: [PATCH v2] tty/serial: atmel: fix out of range clock divider
 handling
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     richard.genoud@gmail.com, jslaby@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1e2e3f63-84db-4b38-1bf1-85916116e0a2@sysgo.com>
 <20191213140301.16490-1-david.engraf@sysgo.com>
 <20191213160726.GB2632926@kroah.com>
From:   David Engraf <david.engraf@sysgo.com>
Message-ID: <39e4d1c7-20b0-a024-3a46-e4d4369eed8e@sysgo.com>
Date:   Mon, 16 Dec 2019 09:34:09 +0100
MIME-Version: 1.0
In-Reply-To: <20191213160726.GB2632926@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.19 at 17:07, Greg KH wrote:
> On Fri, Dec 13, 2019 at 03:03:01PM +0100, David Engraf wrote:
>> Use MCK_DIV8 when the clock divider is > 65535. Unfortunately the mode
>> register was already written thus the clock selection is ignored.
>>
>> Fix by doing the baud rate calulation before setting the mode.
>>
>> Fixes: 5bf5635ac170 ("tty/serial: atmel: add fractional baud rate support")
>> Signed-off-by: David Engraf <david.engraf@sysgo.com>
>> ---
>>   drivers/tty/serial/atmel_serial.c | 43 ++++++++++++++++---------------
>>   1 file changed, 22 insertions(+), 21 deletions(-)
> 
> What changed from v1?
> 
> Always put that below the --- line.

Oh sorry.

> v3 please?

Sure.

Best regards
- David

> thanks,
> 
> greg k-h
> 

